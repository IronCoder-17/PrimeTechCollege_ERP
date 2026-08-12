<?php
// ============================================
// College Campus Connect - Auth API
// POST /api/auth/register
// POST /api/auth/login
// GET  /api/auth/me
// ============================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method = $_SERVER['REQUEST_METHOD'];
$path = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$action = $path[0] ?? '';

if ($method === 'POST' && $action === 'register') {
    $data = json_decode(file_get_contents('php://input'), true);

    $name  = sanitize($data['name'] ?? '');
    $email = filter_var($data['email'] ?? '', FILTER_VALIDATE_EMAIL);
    $pass  = $data['password'] ?? '';
    $major = sanitize($data['major'] ?? '');
    $year  = $data['year'] ?? 'Freshman';

    if (!$name || !$email || strlen($pass) < 8) {
        jsonError('Invalid input. Name, valid email, and password (8+ chars) required.');
    }

    $db = getDB();
    $check = $db->prepare("SELECT id FROM users WHERE email = ?");
    $check->execute([$email]);
    if ($check->fetch()) {
        jsonError('Email already registered.', 409);
    }

    $hash = password_hash($pass, PASSWORD_BCRYPT);
    $stmt = $db->prepare(
        "INSERT INTO users (name, email, password_hash, major, year) VALUES (?, ?, ?, ?, ?)"
    );
    $stmt->execute([$name, $email, $hash, $major, $year]);
    $userId = $db->lastInsertId();
    $token = issueSignedToken($userId);

    jsonResponse([
        'message' => 'Account created successfully!',
        'token' => $token,
        'user' => ['id' => $userId, 'name' => $name, 'email' => $email, 'major' => $major, 'year' => $year]
    ], 201);
}

if ($method === 'POST' && $action === 'login') {
    // ────────────────────────────────────────────────────────────────────
    // NOTE: This endpoint (POST /api/auth.php/login) is used exclusively
    // by the Admin Login page (see frontend AuthContext.login()'s
    // 'admin' branch — students and faculty authenticate entirely
    // client-side and never call this route).
    //
    // Per requirement, Admin Login must NOT query the database. Instead
    // of a `users` table lookup + password_hash verification, the admin
    // identity is validated against fixed static credentials. A signed,
    // expiring session token is still issued afterward (see
    // issueSignedToken()/getAuthUser() in config/helpers.php) so that
    // route protection, RBAC (requireAdmin), and logout continue to work
    // exactly as before — only the credential-verification step changed.
    //
    // Every other module (Admin Dashboard, Students, Faculty, Courses,
    // Fees, Results, etc.) is untouched and keeps using the database.
    // ────────────────────────────────────────────────────────────────────
    $data  = json_decode(file_get_contents('php://input'), true);
    $email = trim($data['email'] ?? '');
    $pass  = $data['password'] ?? '';

    if (!$email || !$pass) {
        jsonError('Email and password are required.');
    }

    if (!verifyStaticAdminCredentials($email, $pass)) {
        jsonError('Invalid Admin Email or Password.', 401);
    }

    $admin = getStaticAdminUser();
    $token = issueSignedToken($admin['id']);

    jsonResponse(['message' => 'Login successful!', 'token' => $token, 'user' => $admin]);
}

if ($method === 'GET' && $action === 'me') {
    $user = requireAuth();
    unset($user['password_hash']);
    jsonResponse($user);
}

jsonError('Not found.', 404);

