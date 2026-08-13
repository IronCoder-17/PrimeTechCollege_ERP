<?php
// ============================================
// College Campus Connect - Users API
// GET  /api/users/{id}
// PUT  /api/users/me
// GET  /api/users/{id}/posts
// POST /api/users/{id}/follow
// GET  /api/users/search?q=
// ============================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method = $_SERVER['REQUEST_METHOD'];
$path   = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$userId = is_numeric($path[0] ?? '') ? (int)$path[0] : $path[0];
$action = $path[1] ?? '';
$db     = getDB();

// GET /users/search
if ($method === 'GET' && $userId === 'search') {
    $q = sanitize($_GET['q'] ?? '');
    if (strlen($q) < 2) jsonError('Search query too short.');

    $stmt = $db->prepare("
        SELECT id, name, avatar, major, year, campus FROM users
        WHERE name LIKE ? OR major LIKE ?
        LIMIT 20
    ");
    $stmt->execute(["%$q%", "%$q%"]);
    jsonResponse(['users' => $stmt->fetchAll()]);
}

// GET /users/me
if ($method === 'GET' && $userId === 'me') {
    $user = requireAuth();
    unset($user['password_hash']);

    // Get follower/following counts
    $fc = $db->prepare("SELECT COUNT(*) AS c FROM follows WHERE following_id = ?");
    $fc->execute([$user['id']]);
    $user['followers'] = (int)$fc->fetch()['c'];

    $fg = $db->prepare("SELECT COUNT(*) AS c FROM follows WHERE follower_id = ?");
    $fg->execute([$user['id']]);
    $user['following'] = (int)$fg->fetch()['c'];

    jsonResponse($user);
}

// GET /users/{id}
if ($method === 'GET' && is_numeric($userId) && !$action) {
    $stmt = $db->prepare("SELECT id, name, avatar, cover_photo, bio, major, year, campus, created_at FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    $user = $stmt->fetch();
    if (!$user) jsonError('User not found.', 404);

    $fc = $db->prepare("SELECT COUNT(*) AS c FROM follows WHERE following_id = ?");
    $fc->execute([$userId]);
    $user['followers'] = (int)$fc->fetch()['c'];

    $fg = $db->prepare("SELECT COUNT(*) AS c FROM follows WHERE follower_id = ?");
    $fg->execute([$userId]);
    $user['following'] = (int)$fg->fetch()['c'];

    jsonResponse($user);
}

// GET /users/{id}/posts
if ($method === 'GET' && is_numeric($userId) && $action === 'posts') {
    $page = max(1, (int)($_GET['page'] ?? 1));
    $limit = 10;
    $offset = ($page - 1) * $limit;

    $stmt = $db->prepare("SELECT p.*, u.name AS author_name, u.avatar AS author_avatar FROM posts p JOIN users u ON p.user_id = u.id WHERE p.user_id = ? ORDER BY p.created_at DESC LIMIT ? OFFSET ?");
    $stmt->execute([$userId, $limit, $offset]);
    jsonResponse(['posts' => $stmt->fetchAll()]);
}

// PUT /users/me — update profile
if ($method === 'PUT' && $userId === 'me') {
    $user = requireAuth();
    $data = json_decode(file_get_contents('php://input'), true);

    $name   = sanitize($data['name'] ?? $user['name']);
    $bio    = sanitize($data['bio'] ?? '');
    $major  = sanitize($data['major'] ?? '');
    $year   = $data['year'] ?? $user['year'];
    $avatar = sanitize($data['avatar'] ?? '');

    $db->prepare("UPDATE users SET name = ?, bio = ?, major = ?, year = ?, avatar = ? WHERE id = ?")->execute([$name, $bio, $major, $year, $avatar, $user['id']]);

    jsonResponse(['message' => 'Profile updated!']);
}

// POST /users/{id}/follow
if ($method === 'POST' && is_numeric($userId) && $action === 'follow') {
    $user = requireAuth();
    if ((int)$userId === $user['id']) jsonError('Cannot follow yourself.');

    try {
        $db->prepare("INSERT INTO follows (follower_id, following_id) VALUES (?, ?)")->execute([$user['id'], $userId]);
        jsonResponse(['following' => true]);
    } catch (\Exception $e) {
        $db->prepare("DELETE FROM follows WHERE follower_id = ? AND following_id = ?")->execute([$user['id'], $userId]);
        jsonResponse(['following' => false]);
    }
}

jsonError('Not found.', 404);

