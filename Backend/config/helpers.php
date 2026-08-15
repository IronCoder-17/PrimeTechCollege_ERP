<?php
// ============================================
// College Campus Connect - Helpers
// ============================================

// ── Error hardening ──────────────────────────────────────────────────────
// Every API response must be valid JSON. Left at their defaults, PHP dev
// setups (XAMPP in particular) print warnings/notices straight into the
// response body BEFORE the JSON — which silently breaks every endpoint's
// JSON parsing on the frontend (axios sees a non-JSON body, so
// err.response.data.error is undefined and the UI falls back to a generic
// "Failed to save..." message with no clue what actually went wrong).
//
// Fix: never let errors print to the response. Turn a PHP warning/notice
// into a normal catchable exception (so a `catch` block can roll back a
// transaction and return a clean JSON error), and add a last-resort
// shutdown handler that turns even a fatal error into valid JSON instead
// of an HTML/plain-text stack trace.
ini_set('display_errors', '0');
error_reporting(E_ALL);

set_error_handler(function ($severity, $message, $file, $line) {
    if (!(error_reporting() & $severity)) return false; // respect @-suppressed errors
    throw new \ErrorException($message, 0, $severity, $file, $line);
});

register_shutdown_function(function () {
    $error = error_get_last();
    if ($error && in_array($error['type'], [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR], true)) {
        if (!headers_sent()) {
            header('Content-Type: application/json; charset=utf-8');
            http_response_code(500);
        }
        echo json_encode(['error' => 'A server error occurred. Please try again, and check the PHP error log for details.']);
    }
});
// ─────────────────────────────────────────────────────────────────────────────

// ── PATH_INFO fix ────────────────────────────────────────────────────────────
// Apache with AcceptPathInfo On sets PATH_INFO automatically.
// PHP built-in server (php -S) does NOT — it leaves PATH_INFO unset.
// The fix: derive it from REQUEST_URI by stripping the script name prefix.
//
// Example: REQUEST_URI = /api/admin.php/students?foo=bar
//          SCRIPT_NAME = /api/admin.php
//          → PATH_INFO  = /students
//
// We only fill in the fallback when PATH_INFO is absent, so Apache/Nginx
// behaviour is unchanged (their PATH_INFO takes precedence).
if (!isset($_SERVER['PATH_INFO']) || $_SERVER['PATH_INFO'] === '') {
    $scriptName = $_SERVER['SCRIPT_NAME'] ?? ''; // e.g. /api/admin.php
    $requestUri = strtok($_SERVER['REQUEST_URI'] ?? '', '?'); // strip query string
    if ($scriptName !== '' && str_starts_with($requestUri, $scriptName)) {
        $derived = substr($requestUri, strlen($scriptName));
        if ($derived !== false && $derived !== '') {
            $_SERVER['PATH_INFO'] = $derived;
        }
    }
}
// ─────────────────────────────────────────────────────────────────────────────

// ── CORS: allow-listed origins only ─────────────────────────────────────────
// SECURITY: never reflect an arbitrary Origin and never use "*" — both,
// combined with credentials:true, would let ANY website read authenticated
// API responses (including admin data) on a logged-in admin's behalf.
// Configure real domains via CLIENT_URL / EXTRA_CLIENT_URLS in backend/.env
// (comma-separated), e.g. for Hostinger:
//   CLIENT_URL=https://yourcollege.com
//   EXTRA_CLIENT_URLS=https://www.yourcollege.com
function getAllowedOrigins() {
    $primary = getenv('CLIENT_URL') ?: 'http://localhost:5173';
    $extra   = getenv('EXTRA_CLIENT_URLS') ?: '';
    $list = array_filter(array_map('trim', explode(',', $primary . ',' . $extra)));
    return $list;
}

function setCORSHeaders() {
    $allowed = getAllowedOrigins();
    $origin  = $_SERVER['HTTP_ORIGIN'] ?? '';

    if ($origin !== '' && in_array($origin, $allowed, true)) {
        header('Access-Control-Allow-Origin: ' . $origin);
        header('Vary: Origin');
        header('Access-Control-Allow-Credentials: true');
    }
    header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type, Authorization');
    header('Content-Type: application/json; charset=utf-8');

    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        http_response_code(200);
        exit();
    }
}

function jsonResponse($data, $code = 200) {
    http_response_code($code);
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit();
}

function jsonError($message, $code = 400) {
    http_response_code($code);
    echo json_encode(['error' => $message]);
    exit();
}

// ── Signed session tokens ────────────────────────────────────────────────
// SECURITY: previously tokens were just base64(user_id) (or a client-made
// "mock-token-{id}-{ts}" string) with NO server-side signature — anyone
// could open devtools, set localStorage to `mock-token-2-<timestamp>` (or
// craft base64("2")) and be authenticated as user id 2 with ZERO password
// check. If that id belonged to an admin, this handed out full Admin Panel
// / admin API access to the public. Tokens are now HMAC-signed with a
// server-only secret and carry an expiry, so they cannot be forged or
// replayed indefinitely.
//
// Set APP_TOKEN_SECRET in backend/.env in production — never rely on the
// fallback below outside local development.
define('TOKEN_SECRET', getenv('APP_TOKEN_SECRET') ?: 'dev-only-insecure-secret-CHANGE-ME');
define('TOKEN_TTL_SECONDS', 12 * 3600); // 12 hours

function issueSignedToken($userId) {
    $payload = $userId . '.' . time();
    $sig = hash_hmac('sha256', $payload, TOKEN_SECRET);
    return base64_encode($payload . '.' . $sig);
}

// Returns the verified user id, or null if the token is missing, malformed,
// tampered with (bad signature), or expired.
function verifySignedToken($token) {
    $decoded = base64_decode($token, true);
    if ($decoded === false) return null;
    $parts = explode('.', $decoded);
    if (count($parts) !== 3) return null;
    [$userId, $ts, $sig] = $parts;
    if (!ctype_digit($userId) || !ctype_digit($ts)) return null;

    $expected = hash_hmac('sha256', $userId . '.' . $ts, TOKEN_SECRET);
    if (!hash_equals($expected, $sig)) return null; // forged / tampered
    if (time() - (int)$ts > TOKEN_TTL_SECONDS) return null; // expired session

    return (int)$userId;
}

function getAuthUser() {
    $headers = getallheaders();
    $token = $headers['Authorization'] ?? '';
    if (empty($token)) return null;
    $token = str_replace('Bearer ', '', $token);

    // 1. Secure path: a properly signed, unexpired token issued by
    //    POST /api/auth.php/login.
    $signedUserId = verifySignedToken($token);
    if ($signedUserId !== null) {
        // 1a. Static Admin: recognized purely from the reserved sentinel id
        //     inside the signed token — no database lookup, since Admin
        //     Login no longer has a database-backed identity.
        if ($signedUserId === STATIC_ADMIN_ID) {
            return getStaticAdminUser();
        }

        // 1b. Every other role (student/faculty/etc.) is still verified
        //     against the database exactly as before.
        $db = getDB();
        $stmt = $db->prepare("SELECT * FROM users WHERE id = ?");
        $stmt->execute([$signedUserId]);
        return $stmt->fetch() ?: null;
    }

    $db = getDB();

    // 2a. Admission-created student accounts: AuthContext.login() issues
    //     "pt-token-{grNumber}-{timestamp}" for these (see contexts/
    //     AuthContext.jsx) since they are rows in `students` +
    //     `login_credentials`, not `users` — there is no numeric users.id
    //     to extract. Resolve the student directly by GR number and
    //     return a user shape (id/email/role) compatible with every
    //     endpoint that already looks the student up by email (e.g.
    //     results.php's getStudentForUser(), timetable.php's
    //     ttGetStudentForUser()).
    if (preg_match('/^pt-token-(.+)-\d+$/', $token, $m)) {
        $grNumber = $m[1];
        $stmt = $db->prepare(
            "SELECT s.id, lc.email
             FROM students s
             JOIN login_credentials lc ON lc.student_id = s.id
             WHERE s.gr_number = ?"
        );
        $stmt->execute([$grNumber]);
        $row = $stmt->fetch();
        if (!$row) return null;
        return [
            'id'    => (int)$row['id'],
            'name'  => null,
            'email' => $row['email'],
            'role'  => 'student',
            'major' => null,
            'year'  => null,
        ];
    }

    // 2b. Faculty accounts approved via the Admission/HR flow: AuthContext
    //     issues "ptfac-token-{employeeId}-{timestamp}" for these (see
    //     contexts/AuthContext.jsx) since they are rows in `faculty`, not
    //     `users`. Resolve directly by employee_id.
    if (preg_match('/^ptfac-token-(.+)-\d+$/', $token, $m)) {
        $employeeId = $m[1];
        $stmt = $db->prepare(
            "SELECT faculty_id, email FROM faculty WHERE employee_id = ?"
        );
        $stmt->execute([$employeeId]);
        $row = $stmt->fetch();
        if (!$row) return null;
        return [
            'id'    => (int)$row['faculty_id'],
            'name'  => null,
            'email' => $row['email'],
            'role'  => 'faculty',
            'major' => null,
            'year'  => null,
        ];
    }

    // 2. Legacy path: the client-side mock AuthContext (student/faculty
    //    demo) still issues unsigned tokens like "mock-token-{id}-{ts}"
    //    or base64(id) that were never server-verified. These are kept
    //    ONLY for backward compatibility with existing non-admin
    //    features, and are explicitly never trusted to grant admin
    //    access (see the role check below) — closing the public
    //    admin-impersonation hole while the rest of the app is migrated
    //    to real server-issued sessions.
    $userId = null;
    if (preg_match('/^mock-token-(\d+)-/', $token, $m)) {
        $userId = (int)$m[1];
    } else {
        $decoded = base64_decode($token, true);
        if ($decoded !== false && ctype_digit($decoded)) {
            $userId = (int)$decoded;
        }
    }
    if ($userId === null) return null;

    $stmt = $db->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->execute([$userId]);
    $user = $stmt->fetch();
    if (!$user) return null;

    // SECURITY: never grant an admin identity through the unsigned legacy
    // path — admins must present a real, server-signed token.
    if ($user['role'] === 'admin') return null;

    return $user;
}

function requireAuth() {
    $user = getAuthUser();
    if (!$user) {
        jsonError('Unauthorized', 401);
    }
    return $user;
}

// ── RBAC: require the authenticated user to have one of the given roles ──
// Admin is always treated as a superuser and passes any role check.
function requireRole($roles) {
    $user = requireAuth();
    $roles = (array)$roles;
    if ($user['role'] === 'admin') return $user; // superuser bypass
    if (!in_array($user['role'], $roles, true)) {
        jsonError('Forbidden: insufficient permissions.', 403);
    }
    return $user;
}

// ── RBAC: require the authenticated user to be an admin (superuser) ──────
function requireAdmin() {
    $user = requireAuth();
    if ($user['role'] !== 'admin') {
        jsonError('Forbidden: admin access required.', 403);
    }
    return $user;
}

function sanitize($str) {
    return htmlspecialchars(strip_tags(trim($str)), ENT_QUOTES, 'UTF-8');
}

// ── Static Admin Login (no database dependency) ──────────────────────────
// Per project requirement: the Admin Login page must authenticate against
// a fixed set of credentials instead of querying the `users` table. This
// applies ONLY to the admin identity/session — every other module (Students,
// Faculty, Courses, Fees, Results, etc.) is untouched and keeps reading and
// writing the database exactly as before.
//
// STATIC_ADMIN_ID is a reserved, out-of-range sentinel id (never assigned
// by MySQL AUTO_INCREMENT for a real `users` row) used to recognize a
// static-admin session token without ever hitting the database.
define('STATIC_ADMIN_ID', 999999999);
define('STATIC_ADMIN_EMAIL', 'admin1617@primetechcollege.edu');
define('STATIC_ADMIN_PASSWORD', 'admin@103');

// Returns the hardcoded admin "user" record shape expected by the rest of
// the app (dashboard header, activity log attribution, etc.) — never reads
// or writes to the database.
function getStaticAdminUser() {
    return [
        'id'    => STATIC_ADMIN_ID,
        'name'  => 'Administrator',
        'email' => STATIC_ADMIN_EMAIL,
        'role'  => 'admin',
        'major' => 'Administration',
        'year'  => null,
    ];
}

// Constant-time credential check for the static admin login.
function verifyStaticAdminCredentials($email, $password) {
    $emailOk = hash_equals(STATIC_ADMIN_EMAIL, (string)$email);
    $passOk  = hash_equals(STATIC_ADMIN_PASSWORD, (string)$password);
    return $emailOk && $passOk;
}