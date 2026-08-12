<?php
// ============================================
// College Campus Connect - Posts API
// GET    /api/posts       (feed)
// POST   /api/posts       (create)
// DELETE /api/posts/{id}
// POST   /api/posts/{id}/like
// POST   /api/posts/{id}/comment
// GET    /api/posts/{id}/comments
// ============================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method = $_SERVER['REQUEST_METHOD'];
$path   = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$postId = is_numeric($path[0] ?? '') ? (int)$path[0] : null;
$action = $path[1] ?? '';
$db     = getDB();

// GET /posts — paginated feed
if ($method === 'GET' && !$postId) {
    $page  = max(1, (int)($_GET['page'] ?? 1));
    $limit = min(20, (int)($_GET['limit'] ?? 10));
    $offset = ($page - 1) * $limit;
    $type  = $_GET['type'] ?? null;

    $where = $type ? "WHERE p.post_type = ?" : "";
    $params = $type ? [$type, $limit, $offset] : [$limit, $offset];

    $stmt = $db->prepare("
        SELECT p.*, u.name AS author_name, u.avatar AS author_avatar, u.major AS author_major, u.year AS author_year
        FROM posts p
        JOIN users u ON p.user_id = u.id
        $where
        ORDER BY p.created_at DESC
        LIMIT ? OFFSET ?
    ");
    $stmt->execute($params);
    $posts = $stmt->fetchAll();

    jsonResponse(['posts' => $posts, 'page' => $page, 'limit' => $limit]);
}

// POST /posts — create post
if ($method === 'POST' && !$postId) {
    $user = requireAuth();
    $data = json_decode(file_get_contents('php://input'), true);
    $content = sanitize($data['content'] ?? '');
    $type    = $data['post_type'] ?? 'general';
    $image   = sanitize($data['image'] ?? '');

    if (strlen($content) < 5) {
        jsonError('Post content too short.');
    }

    $stmt = $db->prepare(
        "INSERT INTO posts (user_id, content, post_type, image) VALUES (?, ?, ?, ?)"
    );
    $stmt->execute([$user['id'], $content, $type, $image ?: null]);
    $id = $db->lastInsertId();

    jsonResponse(['message' => 'Post created!', 'post_id' => $id], 201);
}

// POST /posts/{id}/like
if ($method === 'POST' && $postId && $action === 'like') {
    $user = requireAuth();
    try {
        $db->prepare("INSERT INTO post_likes (post_id, user_id) VALUES (?, ?)")->execute([$postId, $user['id']]);
        $db->prepare("UPDATE posts SET likes_count = likes_count + 1 WHERE id = ?")->execute([$postId]);
        jsonResponse(['liked' => true]);
    } catch (\Exception $e) {
        // Already liked — unlike
        $db->prepare("DELETE FROM post_likes WHERE post_id = ? AND user_id = ?")->execute([$postId, $user['id']]);
        $db->prepare("UPDATE posts SET likes_count = GREATEST(0, likes_count - 1) WHERE id = ?")->execute([$postId]);
        jsonResponse(['liked' => false]);
    }
}

// GET /posts/{id}/comments
if ($method === 'GET' && $postId && $action === 'comments') {
    $stmt = $db->prepare("
        SELECT c.*, u.name AS author_name, u.avatar AS author_avatar
        FROM comments c
        JOIN users u ON c.user_id = u.id
        WHERE c.post_id = ?
        ORDER BY c.created_at ASC
    ");
    $stmt->execute([$postId]);
    jsonResponse(['comments' => $stmt->fetchAll()]);
}

// POST /posts/{id}/comment
if ($method === 'POST' && $postId && $action === 'comment') {
    $user = requireAuth();
    $data = json_decode(file_get_contents('php://input'), true);
    $content = sanitize($data['content'] ?? '');

    if (empty($content)) jsonError('Comment cannot be empty.');

    $db->prepare("INSERT INTO comments (post_id, user_id, content) VALUES (?, ?, ?)")->execute([$postId, $user['id'], $content]);
    $db->prepare("UPDATE posts SET comments_count = comments_count + 1 WHERE id = ?")->execute([$postId]);

    jsonResponse(['message' => 'Comment added!'], 201);
}

// DELETE /posts/{id}
if ($method === 'DELETE' && $postId && !$action) {
    $user = requireAuth();
    $stmt = $db->prepare("DELETE FROM posts WHERE id = ? AND user_id = ?");
    $stmt->execute([$postId, $user['id']]);
    if ($stmt->rowCount() === 0) jsonError('Not found or unauthorized.', 404);
    jsonResponse(['message' => 'Post deleted.']);
}

jsonError('Not found.', 404);

