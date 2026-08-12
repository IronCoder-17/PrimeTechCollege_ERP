<?php
// ============================================
// Faculty API — Modules 10-14
// Endpoints: attendance, punch, syllabus, notifications
// ============================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

// SECURITY: this endpoint previously sent `Access-Control-Allow-Origin: *`,
// which — since faculty data (attendance, syllabus, etc.) is fetched with
// an Authorization header — allowed any website on the internet to make
// authenticated cross-origin requests here. Use the same allow-listed
// origin check as every other API file instead.
setCORSHeaders();

$pdo = getDB();

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? '';

// ── Auth helper ──────────────────────────────────────────────
// RBAC: returns the faculty id (users.id) whose data should be operated on.
// - Faculty role: always their own id (from the authenticated session) —
//   faculty can only ever view/punch their own attendance.
// - Admin (superuser): may override via ?faculty_id= to manage any
//   faculty member's records, since admin has full access to all
//   faculty modules (attendance, syllabus, notifications, etc.).
function getFacultyId(): int {
    $user = requireRole('faculty'); // admin passes any role check (superuser bypass)
    $fid  = (int)$user['id'];

    if ($user['role'] === 'admin' && isset($_GET['faculty_id']) && is_numeric($_GET['faculty_id'])) {
        $fid = (int)$_GET['faculty_id'];
    }
    return $fid;
}

// ── Router ───────────────────────────────────────────────────
switch ($action) {

    // ── MODULE 10: Faculty Self Attendance ───────────────────
    case 'my_attendance':
        if ($method === 'GET') {
            $fid   = getFacultyId();
            $month = $_GET['month'] ?? date('Y-m');

            $stmt = $pdo->prepare("
                SELECT id, date, status, punch_in_time, punch_out_time,
                       working_hours, created_at
                FROM   faculty_attendance
                WHERE  faculty_id = ?
                  AND  DATE_FORMAT(date,'%Y-%m') = ?
                ORDER  BY date DESC
            ");
            $stmt->execute([$fid, $month]);
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Summary
            $total   = count($rows);
            $present = count(array_filter($rows, fn($r) => $r['status'] === 'Present'));
            $absent  = count(array_filter($rows, fn($r) => $r['status'] === 'Absent'));
            $leave   = count(array_filter($rows, fn($r) => $r['status'] === 'Leave'));
            $pct     = $total > 0 ? round(($present / $total) * 100, 1) : 0;

            echo json_encode([
                'success'  => true,
                'summary'  => compact('total','present','absent','leave','pct'),
                'records'  => $rows,
            ]);
        }
        break;

    // ── MODULE 11: Punch In / Punch Out ─────────────────────
    case 'punch_in':
        if ($method === 'POST') {
            $fid  = getFacultyId();
            $now  = new DateTime();
            $date = $now->format('Y-m-d');
            $time = $now->format('Y-m-d H:i:s');
            $body = json_decode(file_get_contents('php://input'), true);

            // Check already punched in today
            $stmt = $pdo->prepare("SELECT id, punch_in_time FROM faculty_punch_logs WHERE faculty_id = ? AND date = ?");
            $stmt->execute([$fid, $date]);
            if ($stmt->rowCount() > 0) {
                http_response_code(409);
                echo json_encode(['success' => false, 'message' => 'Already punched in today']);
                break;
            }

            $stmt = $pdo->prepare("
                INSERT INTO faculty_punch_logs (faculty_id, date, punch_in_time, location, device_info)
                VALUES (?, ?, ?, ?, ?)
            ");
            $stmt->execute([
                $fid, $date, $time,
                $body['location']    ?? null,
                $body['device_info'] ?? null,
            ]);

            // Also upsert attendance record
            $pdo->prepare("
                INSERT INTO faculty_attendance (faculty_id, date, status, punch_in_time)
                VALUES (?, ?, 'Present', ?)
                ON DUPLICATE KEY UPDATE status = 'Present', punch_in_time = ?
            ")->execute([$fid, $date, $now->format('H:i:s'), $now->format('H:i:s')]);

            echo json_encode(['success' => true, 'punch_in' => $time, 'message' => 'Punched in successfully']);
        }
        break;

    case 'punch_out':
        if ($method === 'POST') {
            $fid  = getFacultyId();
            $now  = new DateTime();
            $date = $now->format('Y-m-d');
            $time = $now->format('Y-m-d H:i:s');

            $stmt = $pdo->prepare("SELECT id, punch_in_time FROM faculty_punch_logs WHERE faculty_id = ? AND date = ?");
            $stmt->execute([$fid, $date]);
            $log = $stmt->fetch(PDO::FETCH_ASSOC);

            if (!$log) {
                http_response_code(400);
                echo json_encode(['success' => false, 'message' => 'No punch-in found for today']);
                break;
            }
            if ($log['punch_out_time']) {
                http_response_code(409);
                echo json_encode(['success' => false, 'message' => 'Already punched out today']);
                break;
            }

            $inDt  = new DateTime($log['punch_in_time']);
            $diff  = $now->diff($inDt);
            $hours = round($diff->h + $diff->i / 60 + $diff->s / 3600, 2);

            $pdo->prepare("
                UPDATE faculty_punch_logs
                SET punch_out_time = ?, total_working_hours = ?
                WHERE id = ?
            ")->execute([$time, $hours, $log['id']]);

            // Sync to attendance
            $pdo->prepare("
                UPDATE faculty_attendance
                SET punch_out_time = ?, working_hours = ?
                WHERE faculty_id = ? AND date = ?
            ")->execute([$now->format('H:i:s'), $hours, $fid, $date]);

            echo json_encode([
                'success'       => true,
                'punch_out'     => $time,
                'working_hours' => $hours,
                'message'       => 'Punched out successfully',
            ]);
        }
        break;

    case 'punch_logs':
        if ($method === 'GET') {
            $fid   = getFacultyId();
            $limit = intval($_GET['limit'] ?? 30);

            $stmt = $pdo->prepare("
                SELECT id, date, punch_in_time, punch_out_time, total_working_hours, location
                FROM   faculty_punch_logs
                WHERE  faculty_id = ?
                ORDER  BY date DESC
                LIMIT  ?
            ");
            $stmt->execute([$fid, $limit]);
            echo json_encode(['success' => true, 'logs' => $stmt->fetchAll(PDO::FETCH_ASSOC)]);
        }
        break;

    // ── MODULE 12: Syllabus Mapping ─────────────────────────
    case 'syllabus':
        if ($method === 'GET') {
            $fid = getFacultyId();

            $stmt = $pdo->prepare("
                SELECT sub.id AS subject_id, sub.code, sub.name AS subject,
                       syl.id, syl.unit_no, syl.topic_name,
                       syl.total_lectures, syl.completed_lectures, syl.completion_percentage
                FROM   subjects sub
                JOIN   syllabus  syl ON syl.subject_id = sub.id
                WHERE  sub.faculty_id = ?
                ORDER  BY sub.id, syl.unit_no
            ");
            $stmt->execute([$fid]);
            $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Group by subject
            $grouped = [];
            foreach ($rows as $r) {
                $sid = $r['subject_id'];
                if (!isset($grouped[$sid])) {
                    $grouped[$sid] = [
                        'subject_id' => $sid,
                        'code'       => $r['code'],
                        'subject'    => $r['subject'],
                        'units'      => [],
                    ];
                }
                $grouped[$sid]['units'][] = [
                    'id'                  => $r['id'],
                    'unit_no'             => $r['unit_no'],
                    'topic_name'          => $r['topic_name'],
                    'total_lectures'      => $r['total_lectures'],
                    'completed_lectures'  => $r['completed_lectures'],
                    'completion_percentage' => $r['completion_percentage'],
                ];
            }

            echo json_encode(['success' => true, 'subjects' => array_values($grouped)]);
        }

        if ($method === 'PUT') {
            // Update completed lectures for a unit
            $body    = json_decode(file_get_contents('php://input'), true);
            $unit_id = intval($body['unit_id'] ?? 0);
            $done    = intval($body['completed_lectures'] ?? 0);

            if (!$unit_id) { http_response_code(400); echo json_encode(['error' => 'unit_id required']); break; }

            $pdo->prepare("
                UPDATE syllabus
                SET completed_lectures = LEAST(?, total_lectures)
                WHERE id = ?
            ")->execute([$done, $unit_id]);

            // Fetch updated row
            $stmt = $pdo->prepare("SELECT * FROM syllabus WHERE id = ?");
            $stmt->execute([$unit_id]);
            echo json_encode(['success' => true, 'unit' => $stmt->fetch(PDO::FETCH_ASSOC)]);
        }

        if ($method === 'POST') {
            // Add a new unit
            $body = json_decode(file_get_contents('php://input'), true);
            $stmt = $pdo->prepare("
                INSERT INTO syllabus (subject_id, unit_no, topic_name, total_lectures, completed_lectures)
                VALUES (?, ?, ?, ?, 0)
            ");
            $stmt->execute([
                intval($body['subject_id']),
                intval($body['unit_no']),
                $body['topic_name'],
                intval($body['total_lectures']),
            ]);
            echo json_encode(['success' => true, 'id' => $pdo->lastInsertId()]);
        }
        break;

    // ── Student Attendance (faculty marks students) ──────────
    case 'student_attendance':
        if ($method === 'GET') {
            $fid       = getFacultyId();
            $subject_id = intval($_GET['subject_id'] ?? 0);
            $date       = $_GET['date'] ?? date('Y-m-d');

            $stmt = $pdo->prepare("
                SELECT u.id, u.name, u.email,
                       COALESCE(sa.status, 'Absent') AS status
                FROM   users u
                LEFT JOIN student_attendance sa
                       ON sa.student_id  = u.id
                      AND sa.subject_id  = ?
                      AND sa.date        = ?
                WHERE  u.role = 'student'
                ORDER  BY u.name
            ");
            $stmt->execute([$subject_id, $date]);
            echo json_encode(['success' => true, 'students' => $stmt->fetchAll(PDO::FETCH_ASSOC)]);
        }

        if ($method === 'POST') {
            // Batch save attendance { subject_id, date, records: [{student_id, status}] }
            $fid  = getFacultyId();
            $body = json_decode(file_get_contents('php://input'), true);
            $sid  = intval($body['subject_id']);
            $date = $body['date'];

            $stmt = $pdo->prepare("
                INSERT INTO student_attendance (student_id, subject_id, faculty_id, date, status)
                VALUES (?, ?, ?, ?, ?)
                ON DUPLICATE KEY UPDATE status = VALUES(status)
            ");

            $pdo->beginTransaction();
            foreach (($body['records'] ?? []) as $rec) {
                $stmt->execute([intval($rec['student_id']), $sid, $fid, $date, $rec['status']]);
            }
            $pdo->commit();

            echo json_encode(['success' => true, 'saved' => count($body['records'] ?? [])]);
        }
        break;

    // ── MODULE 14: Faculty Notifications ────────────────────
    case 'notifications':
        if ($method === 'GET') {
            $fid    = getFacultyId();
            $unread = isset($_GET['unread_only']);

            $sql  = "SELECT * FROM faculty_notifications WHERE faculty_id = ?";
            if ($unread) $sql .= " AND is_read = 0";
            $sql .= " ORDER BY created_at DESC LIMIT 50";

            $stmt = $pdo->prepare($sql);
            $stmt->execute([$fid]);
            $rows     = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $unreadCt = count(array_filter($rows, fn($r) => !$r['is_read']));

            echo json_encode(['success' => true, 'notifications' => $rows, 'unread_count' => $unreadCt]);
        }

        if ($method === 'PUT') {
            // Mark notifications as read
            $fid  = getFacultyId();
            $body = json_decode(file_get_contents('php://input'), true);
            $ids  = $body['ids'] ?? [];   // empty = mark all

            if (empty($ids)) {
                $pdo->prepare("UPDATE faculty_notifications SET is_read = 1 WHERE faculty_id = ?")
                    ->execute([$fid]);
            } else {
                $placeholders = implode(',', array_fill(0, count($ids), '?'));
                $pdo->prepare("UPDATE faculty_notifications SET is_read = 1 WHERE id IN ($placeholders) AND faculty_id = ?")
                    ->execute([...$ids, $fid]);
            }
            echo json_encode(['success' => true]);
        }
        break;

    // ── Faculty Dashboard Summary ────────────────────────────
    case 'dashboard_summary':
        if ($method === 'GET') {
            $fid  = getFacultyId();
            $date = date('Y-m-d');

            // Today's punch
            $punch = $pdo->prepare("SELECT punch_in_time, punch_out_time, total_working_hours FROM faculty_punch_logs WHERE faculty_id = ? AND date = ?");
            $punch->execute([$fid, $date]);
            $todayPunch = $punch->fetch(PDO::FETCH_ASSOC);

            // Unread notifications
            $notifStmt = $pdo->prepare("SELECT COUNT(*) FROM faculty_notifications WHERE faculty_id = ? AND is_read = 0");
            $notifStmt->execute([$fid]);
            $unreadNotif = $notifStmt->fetchColumn();

            // Monthly attendance
            $attStmt = $pdo->prepare("
                SELECT status, COUNT(*) AS cnt
                FROM faculty_attendance
                WHERE faculty_id = ? AND DATE_FORMAT(date,'%Y-%m') = ?
                GROUP BY status
            ");
            $attStmt->execute([$fid, date('Y-m')]);
            $attRows = $attStmt->fetchAll(PDO::FETCH_KEY_PAIR);

            $present = $attRows['Present'] ?? 0;
            $total   = array_sum($attRows);
            $attPct  = $total > 0 ? round(($present / $total) * 100, 1) : 0;

            echo json_encode([
                'success'          => true,
                'today_punch'      => $todayPunch,
                'unread_notif'     => $unreadNotif,
                'monthly_att_pct'  => $attPct,
                'monthly_present'  => $present,
                'monthly_total'    => $total,
            ]);
        }
        break;

    default:
        http_response_code(404);
        echo json_encode(['error' => "Unknown action: $action"]);
}

