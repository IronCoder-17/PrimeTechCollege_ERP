<?php
// ============================================================
// College Campus Connect — PHP Built-in Server Router
//
// Start the backend with:
//   cd backend
//   php -S localhost:8000 api/router.php
//
// WHY THIS FILE EXISTS
// ─────────────────────────────────────────────────────────────
// PHP's built-in dev server does NOT set PATH_INFO automatically.
// All admin, faculty, admission, fee, and results endpoints use
// URL patterns like  GET /api/admin.php/students  and rely on
// PATH_INFO being set to  /students  by the web server.
//
// Apache (with AcceptPathInfo On) and Nginx handle this natively.
// The built-in server needs this router to emulate the same
// behaviour: parse REQUEST_URI, extract the path suffix after
// the .php script name, and inject it as PATH_INFO before the
// script runs.
//
// Example:
//   REQUEST_URI   /api/admin.php/students?limit=50
//   SCRIPT_NAME   /api/admin.php
//   PATH_INFO     /students          ← injected by this router
//   QUERY_STRING  limit=50
// ============================================================

$uri = $_SERVER['REQUEST_URI'];

// ── Serve real static files verbatim ─────────────────────────
// (e.g. assets referenced by the backend — unlikely but safe)
$docRoot = __DIR__;
$filePath = $docRoot . parse_url($uri, PHP_URL_PATH);
if (is_file($filePath)) {
    return false; // let the built-in server handle it
}

// ── Extract PATH_INFO from the URI ───────────────────────────
// Match:  /api/<script>.php[/extra/path][?query]
if (preg_match('#^(/api/[^/]+\.php)(/.*)$#', parse_url($uri, PHP_URL_PATH), $m)) {
    // $m[1] = /api/admin.php   $m[2] = /students or /students/42/status
    $_SERVER['PATH_INFO']   = $m[2];
    $_SERVER['SCRIPT_NAME'] = $m[1];
}

// ── Route to the correct PHP script ──────────────────────────
$scriptPath = parse_url($uri, PHP_URL_PATH);

// Strip the leading /api/ prefix from the path so we can map
// to the file on disk (which lives inside backend/api/).
if (preg_match('#^/api/([^/?]+\.php)#', $scriptPath, $sm)) {
    $target = __DIR__ . '/' . $sm[1];
    if (is_file($target)) {
        require $target;
        return true;
    }
}

// ── 404 fallback ─────────────────────────────────────────────
http_response_code(404);
header('Content-Type: application/json');
echo json_encode(['error' => 'Not found.']);
