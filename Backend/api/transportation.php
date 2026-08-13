<?php
// ============================================================
// College Campus Connect — Transportation Management API
//
// PUBLIC (no auth — read-only, used by the Student Registration
// form so the Location dropdown and auto-fee-assignment always
// reflect the latest Admin-configured routes):
//   GET /api/transportation.php/routes          — active routes only
//
// ADMIN ONLY (superuser — full CRUD):
//   GET    /api/transportation.php/routes/all       — every route (active + inactive)
//   GET    /api/transportation.php/routes/{id}
//   POST   /api/transportation.php/routes            — add a new route
//   PUT    /api/transportation.php/routes/{id}       — edit fee / bus number / status / location
//   DELETE /api/transportation.php/routes/{id}       — delete a route
//
// All admin writes are logged to admin_activity_log so they show
// up in the Admin Dashboard "Recent Activities" widget, and
// changes (fees, bus numbers, active/inactive) are reflected
// immediately — no caching — everywhere routes are read.
// ============================================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method   = $_SERVER['REQUEST_METHOD'];
$path     = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$resource = $path[0] ?? '';                 // 'routes'
$sub      = $path[1] ?? null;                // 'all' | numeric id | null
$id       = is_numeric($sub) ? (int)$sub : null;
$db       = getDB();

function logActivity($db, $adminId, $action, $targetType, $targetId, $details) {
    try {
        $stmt = $db->prepare("INSERT INTO admin_activity_log (admin_id, action, target_type, target_id, details) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$adminId, $action, $targetType, $targetId, $details]);
    } catch (\Exception $e) {
        // Activity logging must never break the main request.
    }
}

// ── PUBLIC: GET /routes — active routes only ─────────────────
// Used by the Student Registration "Location" dropdown and the
// auto fee-assignment logic. Inactive routes never appear here.
if ($method === 'GET' && $resource === 'routes' && $sub === null) {
    $rows = $db->query(
        "SELECT id, location, bus_number, transport_fee, status, updated_at
         FROM transportation_routes WHERE status = 'active' ORDER BY location"
    )->fetchAll();
    jsonResponse(['routes' => $rows]);
}

// ── Everything below requires Admin (superuser) ──────────────
$admin = requireAdmin();

// ── ADMIN: GET /routes/all — every route, active + inactive ──
if ($method === 'GET' && $resource === 'routes' && $sub === 'all') {
    $rows = $db->query("SELECT * FROM transportation_routes ORDER BY location")->fetchAll();
    jsonResponse(['routes' => $rows]);
}

// ── ADMIN: GET /routes/{id} ───────────────────────────────────
if ($method === 'GET' && $resource === 'routes' && $id !== null) {
    $stmt = $db->prepare("SELECT * FROM transportation_routes WHERE id = ?");
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if (!$row) jsonError('Transportation route not found.', 404);
    jsonResponse($row);
}

// ── ADMIN: POST /routes — add a new route ─────────────────────
if ($method === 'POST' && $resource === 'routes' && $sub === null) {
    $data = json_decode(file_get_contents('php://input'), true) ?? [];

    $location  = sanitize($data['location']   ?? '');
    $busNumber = sanitize($data['bus_number'] ?? '');
    $fee       = floatval($data['transport_fee'] ?? -1);
    $status    = $data['status'] ?? 'active';

    if (!$location)  jsonError('Location is required.', 400);
    if (!$busNumber) jsonError('Bus Number is mandatory for every route.', 400);
    if ($fee < 0)    jsonError('Transportation Fee must be greater than or equal to 0.', 400);
    if (!in_array($status, ['active', 'inactive'], true)) jsonError('Invalid status.', 400);

    $stmt = $db->prepare(
        "INSERT INTO transportation_routes (location, bus_number, transport_fee, status) VALUES (?, ?, ?, ?)"
    );
    try {
        $stmt->execute([$location, $busNumber, $fee, $status]);
    } catch (\Exception $e) {
        jsonError('A transportation route for this location already exists.', 409);
    }

    $newId = (int)$db->lastInsertId();
    logActivity($db, $admin['id'], 'created_transport_route', 'transport_route', $newId,
        "Created route for $location (Bus $busNumber, ₹$fee)");

    $stmt = $db->prepare("SELECT * FROM transportation_routes WHERE id = ?");
    $stmt->execute([$newId]);
    jsonResponse(['message' => 'Transportation route created successfully.', 'route' => $stmt->fetch()], 201);
}

// ── ADMIN: PUT /routes/{id} — edit a route ────────────────────
if ($method === 'PUT' && $resource === 'routes' && $id !== null) {
    $data = json_decode(file_get_contents('php://input'), true) ?? [];

    $stmt = $db->prepare("SELECT * FROM transportation_routes WHERE id = ?");
    $stmt->execute([$id]);
    $existing = $stmt->fetch();
    if (!$existing) jsonError('Transportation route not found.', 404);

    $fields = [];
    $values = [];

    if (array_key_exists('location', $data)) {
        $location = sanitize($data['location']);
        if (!$location) jsonError('Location is required.', 400);
        $fields[] = 'location = ?';
        $values[] = $location;
    }
    if (array_key_exists('bus_number', $data)) {
        $busNumber = sanitize($data['bus_number']);
        if (!$busNumber) jsonError('Bus Number is mandatory for every route.', 400);
        $fields[] = 'bus_number = ?';
        $values[] = $busNumber;
    }
    if (array_key_exists('transport_fee', $data)) {
        $fee = floatval($data['transport_fee']);
        if ($fee < 0) jsonError('Transportation Fee must be greater than or equal to 0.', 400);
        $fields[] = 'transport_fee = ?';
        $values[] = $fee;
    }
    if (array_key_exists('status', $data)) {
        if (!in_array($data['status'], ['active', 'inactive'], true)) jsonError('Invalid status.', 400);
        $fields[] = 'status = ?';
        $values[] = $data['status'];
    }
    if (!$fields) jsonError('No fields to update.', 400);

    $values[] = $id;

    try {
        $db->prepare("UPDATE transportation_routes SET " . implode(', ', $fields) . " WHERE id = ?")->execute($values);
    } catch (\Exception $e) {
        jsonError('A transportation route for this location already exists.', 409);
    }

    $stmt = $db->prepare("SELECT * FROM transportation_routes WHERE id = ?");
    $stmt->execute([$id]);
    $updated = $stmt->fetch();

    // If a route is deactivated or its fee changes, keep that visible in the
    // activity log — fee changes "automatically reflect throughout the
    // system" since every read (registration form, fee receipts) queries
    // this table live, with no caching.
    $details = "Updated route for {$updated['location']}";
    if ($existing['transport_fee'] != $updated['transport_fee']) {
        $details .= " — fee {$existing['transport_fee']} → {$updated['transport_fee']}";
    }
    if ($existing['status'] !== $updated['status']) {
        $details .= " — status {$existing['status']} → {$updated['status']}";
    }
    logActivity($db, $admin['id'], 'updated_transport_route', 'transport_route', $id, $details);

    jsonResponse(['message' => 'Transportation route updated successfully.', 'route' => $updated]);
}

// ── ADMIN: DELETE /routes/{id} ────────────────────────────────
if ($method === 'DELETE' && $resource === 'routes' && $id !== null) {
    $stmt = $db->prepare("SELECT * FROM transportation_routes WHERE id = ?");
    $stmt->execute([$id]);
    $existing = $stmt->fetch();
    if (!$existing) jsonError('Transportation route not found.', 404);

    $db->prepare("DELETE FROM transportation_routes WHERE id = ?")->execute([$id]);

    logActivity($db, $admin['id'], 'deleted_transport_route', 'transport_route', $id,
        "Deleted route for {$existing['location']} (Bus {$existing['bus_number']})");

    jsonResponse(['message' => 'Transportation route deleted successfully.']);
}

jsonError('Not found.', 404);

