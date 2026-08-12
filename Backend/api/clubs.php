<?php
// ============================================
// College Campus Connect - Clubs API
// GET  /api/clubs
// GET  /api/clubs/{id}
// POST /api/clubs
// POST /api/clubs/{id}/join
// ============================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method  = $_SERVER['REQUEST_METHOD'];
$path    = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$clubId  = is_numeric($path[0] ?? '') ? (int)$path[0] : null;
$action  = $path[1] ?? '';
$db      = getDB();

// GET /clubs
if ($method === 'GET' && !$clubId) {
    $category = $_GET['category'] ?? null;
    $search   = $_GET['q'] ?? null;
    $where    = "WHERE 1=1";
    $params   = [];

    if ($category) { $where .= " AND c.category = ?"; $params[] = $category; }
    if ($search)   { $where .= " AND c.name LIKE ?";  $params[] = "%$search%"; }

    $stmt = $db->prepare("
        SELECT c.*, u.name AS president_name, u.avatar AS president_avatar
        FROM clubs c
        LEFT JOIN users u ON c.president_id = u.id
        $where
        ORDER BY c.members_count DESC
    ");
    $stmt->execute($params);
    jsonResponse(['clubs' => $stmt->fetchAll()]);
}

// GET /clubs/{id}
if ($method === 'GET' && $clubId && !$action) {
    $stmt = $db->prepare("SELECT c.*, u.name AS president_name FROM clubs c LEFT JOIN users u ON c.president_id = u.id WHERE c.id = ?");
    $stmt->execute([$clubId]);
    $club = $stmt->fetch();
    if (!$club) jsonError('Club not found.', 404);

    // Get members
    $members = $db->prepare("SELECT u.id, u.name, u.avatar, u.major, cm.role FROM club_members cm JOIN users u ON cm.user_id = u.id WHERE cm.club_id = ? LIMIT 20");
    $members->execute([$clubId]);
    $club['members'] = $members->fetchAll();

    jsonResponse($club);
}

// POST /clubs
if ($method === 'POST' && !$clubId) {
    $user = requireAuth();
    $data = json_decode(file_get_contents('php://input'), true);

    $name = sanitize($data['name'] ?? '');
    $desc = sanitize($data['description'] ?? '');
    $cat  = sanitize($data['category'] ?? 'Other');

    if (!$name) jsonError('Club name is required.');

    $stmt = $db->prepare("INSERT INTO clubs (name, description, category, president_id) VALUES (?, ?, ?, ?)");
    $stmt->execute([$name, $desc, $cat, $user['id']]);
    $clubId = $db->lastInsertId();

    // Auto-join as president
    $db->prepare("INSERT INTO club_members (club_id, user_id, role) VALUES (?, ?, 'president')")->execute([$clubId, $user['id']]);
    $db->prepare("UPDATE clubs SET members_count = 1 WHERE id = ?")->execute([$clubId]);

    jsonResponse(['message' => 'Club created!', 'club_id' => $clubId], 201);
}

// POST /clubs/{id}/join
if ($method === 'POST' && $clubId && $action === 'join') {
    $user = requireAuth();
    try {
        $db->prepare("INSERT INTO club_members (club_id, user_id) VALUES (?, ?)")->execute([$clubId, $user['id']]);
        $db->prepare("UPDATE clubs SET members_count = members_count + 1 WHERE id = ?")->execute([$clubId]);
        jsonResponse(['message' => 'Joined club!', 'joined' => true]);
    } catch (\Exception $e) {
        $db->prepare("DELETE FROM club_members WHERE club_id = ? AND user_id = ?")->execute([$clubId, $user['id']]);
        $db->prepare("UPDATE clubs SET members_count = GREATEST(0, members_count - 1) WHERE id = ?")->execute([$clubId]);
        jsonResponse(['message' => 'Left club.', 'joined' => false]);
    }
}

jsonError('Not found.', 404);

