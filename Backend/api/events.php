<?php
// ============================================
// College Campus Connect - Events API
// GET  /api/events
// POST /api/events
// GET  /api/events/{id}
// POST /api/events/{id}/rsvp
// ============================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method = $_SERVER['REQUEST_METHOD'];
$path   = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$eventId = is_numeric($path[0] ?? '') ? (int)$path[0] : null;
$action  = $path[1] ?? '';
$db      = getDB();

// GET /events
if ($method === 'GET' && !$eventId) {
    $type   = $_GET['type'] ?? null;
    $search = $_GET['q'] ?? null;
    $page   = max(1, (int)($_GET['page'] ?? 1));
    $limit  = 12;
    $offset = ($page - 1) * $limit;

    $where = "WHERE e.start_datetime >= NOW()";
    $params = [];

    if ($type) { $where .= " AND e.event_type = ?"; $params[] = $type; }
    if ($search) { $where .= " AND (e.title LIKE ? OR e.description LIKE ?)"; $params[] = "%$search%"; $params[] = "%$search%"; }

    $params[] = $limit;
    $params[] = $offset;

    $stmt = $db->prepare("
        SELECT e.*, u.name AS organizer_name, u.avatar AS organizer_avatar, c.name AS club_name
        FROM events e
        LEFT JOIN users u ON e.organizer_id = u.id
        LEFT JOIN clubs c ON e.club_id = c.id
        $where
        ORDER BY e.start_datetime ASC
        LIMIT ? OFFSET ?
    ");
    $stmt->execute($params);
    jsonResponse(['events' => $stmt->fetchAll(), 'page' => $page]);
}

// GET /events/{id}
if ($method === 'GET' && $eventId && !$action) {
    $stmt = $db->prepare("
        SELECT e.*, u.name AS organizer_name, u.avatar AS organizer_avatar
        FROM events e LEFT JOIN users u ON e.organizer_id = u.id
        WHERE e.id = ?
    ");
    $stmt->execute([$eventId]);
    $event = $stmt->fetch();
    if (!$event) jsonError('Event not found.', 404);
    jsonResponse($event);
}

// POST /events — create event
if ($method === 'POST' && !$eventId) {
    $user = requireAuth();
    $data = json_decode(file_get_contents('php://input'), true);

    $title    = sanitize($data['title'] ?? '');
    $desc     = sanitize($data['description'] ?? '');
    $location = sanitize($data['location'] ?? '');
    $start    = $data['start_datetime'] ?? '';
    $end      = $data['end_datetime'] ?? null;
    $type     = $data['event_type'] ?? 'other';
    $isFree   = isset($data['is_free']) ? (int)$data['is_free'] : 1;

    if (!$title || !$start) jsonError('Title and start datetime are required.');

    $stmt = $db->prepare("
        INSERT INTO events (title, description, location, start_datetime, end_datetime, organizer_id, event_type, is_free)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ");
    $stmt->execute([$title, $desc, $location, $start, $end, $user['id'], $type, $isFree]);
    jsonResponse(['message' => 'Event created!', 'event_id' => $db->lastInsertId()], 201);
}

// POST /events/{id}/rsvp
if ($method === 'POST' && $eventId && $action === 'rsvp') {
    $user = requireAuth();
    $data = json_decode(file_get_contents('php://input'), true);
    $status = $data['status'] ?? 'going';

    try {
        $db->prepare("INSERT INTO event_rsvps (event_id, user_id, status) VALUES (?, ?, ?)")->execute([$eventId, $user['id'], $status]);
        $db->prepare("UPDATE events SET attendees_count = attendees_count + 1 WHERE id = ?")->execute([$eventId]);
        jsonResponse(['message' => 'RSVP saved!', 'status' => $status]);
    } catch (\Exception $e) {
        $db->prepare("UPDATE event_rsvps SET status = ? WHERE event_id = ? AND user_id = ?")->execute([$status, $eventId, $user['id']]);
        jsonResponse(['message' => 'RSVP updated!', 'status' => $status]);
    }
}

jsonError('Not found.', 404);

