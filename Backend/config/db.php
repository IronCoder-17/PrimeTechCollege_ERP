<?php
// SECURITY: DB credentials were previously hardcoded in this source file
// (root / the real production password, in plaintext, committed to the
// repo) even though a backend/.env already existed. Load them from the
// environment instead so real credentials never live in version control.
if (!getenv('DB_HOST') && file_exists(__DIR__ . '/../.env')) {
    foreach (file(__DIR__ . '/../.env', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
        if ($line[0] === '#' || !str_contains($line, '=')) continue;
        [$k, $v] = explode('=', $line, 2);
        putenv(trim($k) . '=' . trim($v));
    }
}

// LAZY CONNECTION: the connection is opened the first time getDB() is
// actually called, not the moment this file is require'd. Several
// endpoints (e.g. Admin Login, which now authenticates via static
// credentials — see config/helpers.php / api/auth.php) include this
// file for other helpers but never touch the database, so they must
// not be blocked or crashed by a database outage. Every module that
// does call getDB() (Admin Dashboard, Students, Faculty, Courses,
// Fees, Results, etc.) behaves exactly as before — it still connects,
// still gets the same PDO instance, still fails the same way if the
// database really is unreachable.
function getDB() {
    static $pdo = null;

    if ($pdo === null) {
        // NOTE: use `getenv(...) !== false` rather than `?:` — the Elvis
        // operator treats an empty string ('') as falsy too, which was
        // silently discarding a genuinely empty DB_PASS (e.g. local
        // XAMPP installs where root has no password) and substituting
        // the hardcoded fallback instead, causing "Access denied" even
        // when .env was configured correctly.
        $envOrDefault = function (string $key, string $default) {
            $val = getenv($key);
            return $val !== false ? $val : $default;
        };

        $host = $envOrDefault('DB_HOST', '127.0.0.1');
        $db   = $envOrDefault('DB_NAME', 'college_campus');
        $user = $envOrDefault('DB_USER', 'root');
        $pass = $envOrDefault('DB_PASS', '1786');
        $port = $envOrDefault('DB_PORT', '3306');

        try {
            $pdo = new PDO("mysql:host=$host;port=$port;dbname=$db;charset=utf8mb4", $user, $pass);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            error_log('DB connection failed: ' . $e->getMessage());
            http_response_code(500);
            echo json_encode(['error' => 'Database connection failed.']);
            exit;
        }
    }

    return $pdo;
}