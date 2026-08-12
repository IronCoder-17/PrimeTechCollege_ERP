<?php
// ============================================================
// College Campus Connect — Fee Management API
//
// PUBLIC (no auth — read-only, used by Registration/Admission
// page and student dashboards so fee data is always live):
//   GET /api/fees.php/settings          — all global fee settings
//   GET /api/fees.php/hostel-plans      — all active hostel fee plans
//
// ADMIN ONLY (superuser — full CRUD):
//   GET    /api/fees.php/settings/{id}
//   PUT    /api/fees.php/settings/{id}        — update amount/label/etc
//
//   GET    /api/fees.php/hostel-plans/{id}
//   POST   /api/fees.php/hostel-plans         — add a new hostel fee plan
//   PUT    /api/fees.php/hostel-plans/{id}    — edit a hostel fee plan
//   DELETE /api/fees.php/hostel-plans/{id}    — delete a hostel fee plan
//
// All admin writes are logged to admin_activity_log so they show
// up in the Admin Dashboard "Recent Activities" widget, and changes
// are reflected immediately (no caching) everywhere fees are read.
// ============================================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method   = $_SERVER['REQUEST_METHOD'];
$path     = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$resource = $path[0] ?? '';      // 'settings' | 'hostel-plans'
$id       = isset($path[1]) && is_numeric($path[1]) ? (int)$path[1] : null;
$db       = getDB();

function logActivity($db, $adminId, $action, $targetType, $targetId, $details) {
    try {
        $stmt = $db->prepare("INSERT INTO admin_activity_log (admin_id, action, target_type, target_id, details) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$adminId, $action, $targetType, $targetId, $details]);
    } catch (\Exception $e) {
        // Activity logging must never break the main request.
    }
}

// ── PUBLIC: GET /settings ────────────────────────────────────
if ($method === 'GET' && $resource === 'settings' && $id === null) {
    $rows = $db->query("SELECT fee_key, label, amount, category, description, updated_at FROM fee_settings ORDER BY category, label")->fetchAll();

    // Also return as a flat key => amount map for easy frontend consumption
    $map = [];
    foreach ($rows as $r) {
        $map[$r['fee_key']] = (float)$r['amount'];
    }

    jsonResponse(['settings' => $rows, 'map' => $map]);
}

// ── PUBLIC: GET /hostel-plans ────────────────────────────────
if ($method === 'GET' && $resource === 'hostel-plans' && $id === null) {
    $rows = $db->query(
        "SELECT id, hostel_type, room_type, hostel_admission_fee, security_deposit, hostel_fee, mess_fee, maintenance_fee, total_fee, is_active, updated_at
         FROM hostel_fee_plans WHERE is_active = 1 ORDER BY hostel_type, room_type"
    )->fetchAll();
    jsonResponse(['plans' => $rows]);
}

// ── Everything below requires Admin (superuser) ──────────────
$admin = requireAdmin();

// ── GET /settings/{id} ───────────────────────────────────────
if ($method === 'GET' && $resource === 'settings' && $id !== null) {
    $stmt = $db->prepare("SELECT * FROM fee_settings WHERE id = ?");
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if (!$row) jsonError('Fee setting not found.', 404);
    jsonResponse($row);
}

// ── PUT /settings/{id} ───────────────────────────────────────
if ($method === 'PUT' && $resource === 'settings' && $id !== null) {
    $data = json_decode(file_get_contents('php://input'), true) ?? [];

    $stmt = $db->prepare("SELECT * FROM fee_settings WHERE id = ?");
    $stmt->execute([$id]);
    $existing = $stmt->fetch();
    if (!$existing) jsonError('Fee setting not found.', 404);

    $fields = [];
    $values = [];

    if (array_key_exists('amount', $data)) {
        $amount = floatval($data['amount']);
        if ($amount < 0) jsonError('Amount cannot be negative.', 400);
        $fields[] = 'amount = ?';
        $values[] = $amount;
    }
    if (array_key_exists('label', $data)) {
        $fields[] = 'label = ?';
        $values[] = sanitize($data['label']);
    }
    if (array_key_exists('description', $data)) {
        $fields[] = 'description = ?';
        $values[] = sanitize($data['description']);
    }
    if (!$fields) jsonError('No fields to update.', 400);

    $fields[] = 'updated_by = ?';
    $values[] = $admin['id'];
    $values[] = $id;

    $db->prepare("UPDATE fee_settings SET " . implode(', ', $fields) . " WHERE id = ?")->execute($values);

    $stmt = $db->prepare("SELECT * FROM fee_settings WHERE id = ?");
    $stmt->execute([$id]);
    $updated = $stmt->fetch();

    logActivity($db, $admin['id'], 'updated_fee', 'fee_setting', $id,
        "Updated '{$updated['label']}' from " . $existing['amount'] . " to " . $updated['amount']);

    jsonResponse(['message' => 'Fee setting updated successfully.', 'setting' => $updated]);
}

// ── GET /hostel-plans/{id} ────────────────────────────────────
if ($method === 'GET' && $resource === 'hostel-plans' && $id !== null) {
    $stmt = $db->prepare("SELECT * FROM hostel_fee_plans WHERE id = ?");
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if (!$row) jsonError('Hostel fee plan not found.', 404);
    jsonResponse($row);
}

// ── POST /hostel-plans ────────────────────────────────────────
if ($method === 'POST' && $resource === 'hostel-plans' && $id === null) {
    $data = json_decode(file_get_contents('php://input'), true) ?? [];

    $hostelType = $data['hostel_type'] ?? '';
    $roomType   = $data['room_type']   ?? '';
    if (!in_array($hostelType, ['Boys Hostel', 'Girls Hostel'], true)) {
        jsonError('hostel_type must be "Boys Hostel" or "Girls Hostel".', 400);
    }
    if (!in_array($roomType, ['Non-AC (3 Sharing)', 'Non-AC (2 Sharing)', 'AC (2 Sharing)'], true)) {
        jsonError('Invalid room_type.', 400);
    }

    $admissionFee = floatval($data['hostel_admission_fee'] ?? 5000);
    $deposit      = floatval($data['security_deposit']     ?? 10000);
    $hostelFee    = floatval($data['hostel_fee']            ?? 0);
    $messFee      = floatval($data['mess_fee']              ?? 25000);
    $maintenance  = floatval($data['maintenance_fee']       ?? 3000);

    foreach ([$admissionFee, $deposit, $hostelFee, $messFee, $maintenance] as $amt) {
        if ($amt < 0) jsonError('Fee amounts cannot be negative.', 400);
    }

    $stmt = $db->prepare(
        "INSERT INTO hostel_fee_plans (hostel_type, room_type, hostel_admission_fee, security_deposit, hostel_fee, mess_fee, maintenance_fee, updated_by)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
    );
    try {
        $stmt->execute([$hostelType, $roomType, $admissionFee, $deposit, $hostelFee, $messFee, $maintenance, $admin['id']]);
    } catch (\Exception $e) {
        jsonError('A fee plan for this hostel type and room type already exists.', 409);
    }

    $newId = (int)$db->lastInsertId();
    logActivity($db, $admin['id'], 'created_hostel_plan', 'hostel_plan', $newId, "Created plan for $hostelType / $roomType");

    $stmt = $db->prepare("SELECT * FROM hostel_fee_plans WHERE id = ?");
    $stmt->execute([$newId]);
    jsonResponse(['message' => 'Hostel fee plan created successfully.', 'plan' => $stmt->fetch()], 201);
}

// ── PUT /hostel-plans/{id} ────────────────────────────────────
if ($method === 'PUT' && $resource === 'hostel-plans' && $id !== null) {
    $data = json_decode(file_get_contents('php://input'), true) ?? [];

    $stmt = $db->prepare("SELECT * FROM hostel_fee_plans WHERE id = ?");
    $stmt->execute([$id]);
    $existing = $stmt->fetch();
    if (!$existing) jsonError('Hostel fee plan not found.', 404);

    $fields = [];
    $values = [];

    foreach (['hostel_admission_fee', 'security_deposit', 'hostel_fee', 'mess_fee', 'maintenance_fee'] as $f) {
        if (array_key_exists($f, $data)) {
            $amt = floatval($data[$f]);
            if ($amt < 0) jsonError("$f cannot be negative.", 400);
            $fields[] = "$f = ?";
            $values[] = $amt;
        }
    }
    if (array_key_exists('hostel_type', $data)) {
        if (!in_array($data['hostel_type'], ['Boys Hostel', 'Girls Hostel'], true)) {
            jsonError('hostel_type must be "Boys Hostel" or "Girls Hostel".', 400);
        }
        $fields[] = 'hostel_type = ?';
        $values[] = $data['hostel_type'];
    }
    if (array_key_exists('room_type', $data)) {
        if (!in_array($data['room_type'], ['Non-AC (3 Sharing)', 'Non-AC (2 Sharing)', 'AC (2 Sharing)'], true)) {
            jsonError('Invalid room_type.', 400);
        }
        $fields[] = 'room_type = ?';
        $values[] = $data['room_type'];
    }
    if (array_key_exists('is_active', $data)) {
        $fields[] = 'is_active = ?';
        $values[] = (bool)$data['is_active'] ? 1 : 0;
    }
    if (!$fields) jsonError('No fields to update.', 400);

    $fields[] = 'updated_by = ?';
    $values[] = $admin['id'];
    $values[] = $id;

    try {
        $db->prepare("UPDATE hostel_fee_plans SET " . implode(', ', $fields) . " WHERE id = ?")->execute($values);
    } catch (\Exception $e) {
        jsonError('A fee plan for this hostel type and room type already exists.', 409);
    }

    logActivity($db, $admin['id'], 'updated_hostel_plan', 'hostel_plan', $id, 'Updated hostel fee plan');

    $stmt = $db->prepare("SELECT * FROM hostel_fee_plans WHERE id = ?");
    $stmt->execute([$id]);
    jsonResponse(['message' => 'Hostel fee plan updated successfully.', 'plan' => $stmt->fetch()]);
}

// ── DELETE /hostel-plans/{id} ─────────────────────────────────
if ($method === 'DELETE' && $resource === 'hostel-plans' && $id !== null) {
    $stmt = $db->prepare("SELECT * FROM hostel_fee_plans WHERE id = ?");
    $stmt->execute([$id]);
    $existing = $stmt->fetch();
    if (!$existing) jsonError('Hostel fee plan not found.', 404);

    $db->prepare("DELETE FROM hostel_fee_plans WHERE id = ?")->execute([$id]);

    logActivity($db, $admin['id'], 'deleted_hostel_plan', 'hostel_plan', $id,
        "Deleted plan for {$existing['hostel_type']} / {$existing['room_type']}");

    jsonResponse(['message' => 'Hostel fee plan deleted successfully.']);
}

jsonError('Not found.', 404);

