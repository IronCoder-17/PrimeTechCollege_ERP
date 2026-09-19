<?php
// ============================================================
// College Campus Connect — Suggestion Box API
//
// Endpoints:
//   GET  /api/suggestions.php/my            (student|faculty) own suggestions
//   POST /api/suggestions.php/create        (student|faculty) submit one
//   GET  /api/suggestions.php/admin         (admin) list all, with search/filter
//   PUT  /api/suggestions.php/admin/update  (admin) change status / respond
//   GET  /api/suggestions.php/admin/stats   (admin) dashboard counters
//
// Security:
//   - The submitting identity (user_id / user_role / user_name) is
//     ALWAYS derived server-side from the authenticated session
//     (students/faculty tables keyed off email), never from the
//     request body.
//   - Students/faculty can only ever read rows they own (enforced
//     by a WHERE user_id = ? AND user_role = ? clause tied to the
//     resolved identity — a client cannot pass another user's id).
//   - Admin endpoints require requireAdmin() and are otherwise
//     unreachable.
// ============================================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method   = $_SERVER['REQUEST_METHOD'];
$path     = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$resource = $path[0] ?? '';
$sub      = $path[1] ?? '';
$db       = getDB();

const SUGGESTION_CATEGORIES = [
    'Academic', 'Faculty', 'Infrastructure', 'Technology', 'Events',
    'Library', 'Campus', 'Hostel', 'Transport', 'Fees', 'General', 'Other',
];

const SUGGESTION_STATUSES = [
    'Pending', 'Under Review', 'In Progress', 'Implemented', 'Rejected',
];

// ── Resolve (user_id, user_role, user_name) for the authenticated
//    student or faculty member, the same trusted-identity pattern
//    used throughout messages.php / timetable.php / results.php. ──
function sgResolveIdentity($db, $user) {
    if ($user['role'] === 'student') {
        $stmt = $db->prepare(
            "SELECT s.id, CONCAT(s.first_name, ' ', s.last_name) AS name
             FROM students s
             JOIN login_credentials lc ON lc.student_id = s.id
             WHERE lc.email = ?"
        );
        $stmt->execute([$user['email']]);
        $row = $stmt->fetch();
        if (!$row) jsonError('Student record not found for this account.', 404);
        return ['id' => (int)$row['id'], 'role' => 'student', 'name' => trim($row['name']) ?: 'Student'];
    }

    if ($user['role'] === 'faculty') {
        $stmt = $db->prepare(
            "SELECT faculty_id, CONCAT(first_name, ' ', last_name) AS name FROM faculty WHERE email = ?"
        );
        $stmt->execute([$user['email']]);
        $row = $stmt->fetch();
        if (!$row) jsonError('Faculty record not found for this account.', 404);
        return ['id' => (int)$row['faculty_id'], 'role' => 'faculty', 'name' => trim($row['name']) ?: 'Faculty'];
    }

    jsonError('Only students and faculty may use the suggestion box.', 403);
}

function sgValidateCategory($category) {
    return in_array($category, SUGGESTION_CATEGORIES, true) ? $category : 'General';
}

function sgSerialize($row) {
    return [
        'id'             => (int)$row['id'],
        'user_id'        => (int)$row['user_id'],
        'user_role'      => $row['user_role'],
        'user_name'      => $row['user_name'],
        'title'          => $row['title'],
        'description'    => $row['description'],
        'category'       => $row['category'],
        'status'         => $row['status'],
        'admin_response' => $row['admin_response'],
        'reviewed_by'    => $row['reviewed_by'],
        'reviewed_at'    => $row['reviewed_at'],
        'created_at'     => $row['created_at'],
        'updated_at'     => $row['updated_at'],
    ];
}

// ============================================================
// GET /suggestions.php/my
// ============================================================
if ($resource === 'my' && $method === 'GET') {
    $user     = requireRole(['student', 'faculty']);
    $identity = sgResolveIdentity($db, $user);

    $stmt = $db->prepare(
        "SELECT * FROM suggestions WHERE user_id = ? AND user_role = ? ORDER BY created_at DESC"
    );
    $stmt->execute([$identity['id'], $identity['role']]);
    $rows = array_map('sgSerialize', $stmt->fetchAll());

    // Viewing your own list marks any status/response updates as seen.
    $db->prepare("UPDATE suggestions SET is_seen_by_user = 1 WHERE user_id = ? AND user_role = ?")
       ->execute([$identity['id'], $identity['role']]);

    jsonResponse(['success' => true, 'suggestions' => $rows]);
}

// ============================================================
// POST /suggestions.php/create   { title, description, category }
// ============================================================
if ($resource === 'create' && $method === 'POST') {
    $user     = requireRole(['student', 'faculty']);
    $identity = sgResolveIdentity($db, $user);
    $data     = json_decode(file_get_contents('php://input'), true) ?: [];

    $title       = sanitize($data['title'] ?? '');
    $description = sanitize($data['description'] ?? '');
    $category    = sgValidateCategory(trim($data['category'] ?? 'General'));

    if ($title === '' || mb_strlen($title) < 3) {
        jsonError('Title must be at least 3 characters.');
    }
    if (mb_strlen($title) > 200) {
        jsonError('Title is too long (max 200 characters).');
    }
    if ($description === '' || mb_strlen($description) < 10) {
        jsonError('Description must be at least 10 characters.');
    }
    if (mb_strlen($description) > 4000) {
        jsonError('Description is too long (max 4000 characters).');
    }

    $stmt = $db->prepare(
        "INSERT INTO suggestions (user_id, user_role, user_name, title, description, category, status)
         VALUES (?, ?, ?, ?, ?, ?, 'Pending')"
    );
    $stmt->execute([$identity['id'], $identity['role'], $identity['name'], $title, $description, $category]);
    $newId = $db->lastInsertId();

    $row = $db->prepare("SELECT * FROM suggestions WHERE id = ?");
    $row->execute([$newId]);

    jsonResponse(['success' => true, 'message' => 'Your suggestion has been submitted successfully.', 'suggestion' => sgSerialize($row->fetch())], 201);
}

// ============================================================
// GET /suggestions.php/admin?search=&category=&status=&role=&date=
// ============================================================
if ($resource === 'admin' && $sub === '' && $method === 'GET') {
    requireAdmin();

    $where  = [];
    $params = [];

    $search = trim($_GET['search'] ?? '');
    if ($search !== '') {
        $where[] = "(title LIKE ? OR description LIKE ? OR user_name LIKE ? OR category LIKE ?)";
        $like = '%' . $search . '%';
        array_push($params, $like, $like, $like, $like);
    }

    $role = trim($_GET['role'] ?? '');
    if (in_array($role, ['student', 'faculty'], true)) {
        $where[] = "user_role = ?";
        $params[] = $role;
    }

    $category = trim($_GET['category'] ?? '');
    if ($category !== '' && in_array($category, SUGGESTION_CATEGORIES, true)) {
        $where[] = "category = ?";
        $params[] = $category;
    }

    $status = trim($_GET['status'] ?? '');
    if ($status !== '' && in_array($status, SUGGESTION_STATUSES, true)) {
        $where[] = "status = ?";
        $params[] = $status;
    }

    $date = trim($_GET['date'] ?? ''); // YYYY-MM-DD
    if ($date !== '' && preg_match('/^\d{4}-\d{2}-\d{2}$/', $date)) {
        $where[] = "DATE(created_at) = ?";
        $params[] = $date;
    }

    $sql = "SELECT * FROM suggestions";
    if ($where) $sql .= " WHERE " . implode(' AND ', $where);
    $sql .= " ORDER BY created_at DESC LIMIT 500";

    $stmt = $db->prepare($sql);
    $stmt->execute($params);
    $rows = array_map('sgSerialize', $stmt->fetchAll());

    jsonResponse(['success' => true, 'suggestions' => $rows]);
}

// ============================================================
// GET /suggestions.php/admin/stats
// ============================================================
if ($resource === 'admin' && $sub === 'stats' && $method === 'GET') {
    requireAdmin();

    $total = (int)$db->query("SELECT COUNT(*) FROM suggestions")->fetchColumn();

    $byStatus = array_fill_keys(SUGGESTION_STATUSES, 0);
    $stmt = $db->query("SELECT status, COUNT(*) AS c FROM suggestions GROUP BY status");
    foreach ($stmt->fetchAll() as $r) {
        $byStatus[$r['status']] = (int)$r['c'];
    }

    $byRole = ['student' => 0, 'faculty' => 0];
    $stmt2 = $db->query("SELECT user_role, COUNT(*) AS c FROM suggestions GROUP BY user_role");
    foreach ($stmt2->fetchAll() as $r) {
        $byRole[$r['user_role']] = (int)$r['c'];
    }

    jsonResponse([
        'success' => true,
        'total' => $total,
        'by_status' => $byStatus,
        'by_role' => $byRole,
    ]);
}

// ============================================================
// PUT /suggestions.php/admin/update   { id, status?, admin_response? }
// ============================================================
if ($resource === 'admin' && $sub === 'update' && $method === 'PUT') {
    $admin = requireAdmin();
    $data  = json_decode(file_get_contents('php://input'), true) ?: [];

    $id = (int)($data['id'] ?? 0);
    if (!$id) jsonError('Suggestion id is required.');

    $check = $db->prepare("SELECT id FROM suggestions WHERE id = ?");
    $check->execute([$id]);
    if (!$check->fetch()) jsonError('Suggestion not found.', 404);

    $sets   = [];
    $params = [];

    if (array_key_exists('status', $data)) {
        $status = trim($data['status']);
        if (!in_array($status, SUGGESTION_STATUSES, true)) {
            jsonError('Invalid status value.');
        }
        $sets[] = "status = ?";
        $params[] = $status;
        $sets[] = "reviewed_by = ?";
        $params[] = $admin['name'] ?? $admin['email'] ?? 'Administrator';
        $sets[] = "reviewed_at = NOW()";
    }

    if (array_key_exists('admin_response', $data)) {
        $response = sanitize($data['admin_response'] ?? '');
        if (mb_strlen($response) > 4000) jsonError('Response is too long (max 4000 characters).');
        $sets[] = "admin_response = ?";
        $params[] = $response === '' ? null : $response;
        $sets[] = "reviewed_by = ?";
        $params[] = $admin['name'] ?? $admin['email'] ?? 'Administrator';
        $sets[] = "reviewed_at = NOW()";
    }

    if (!$sets) jsonError('Nothing to update.');

    // Any admin edit flips is_seen_by_user so the submitter sees a fresh badge.
    $sets[] = "is_seen_by_user = 0";

    $params[] = $id;
    $sql = "UPDATE suggestions SET " . implode(', ', $sets) . " WHERE id = ?";
    $db->prepare($sql)->execute($params);

    $row = $db->prepare("SELECT * FROM suggestions WHERE id = ?");
    $row->execute([$id]);

    jsonResponse(['success' => true, 'suggestion' => sgSerialize($row->fetch())]);
}

jsonError('Not found.', 404);
