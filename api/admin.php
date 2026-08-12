<?php
// ============================================================
// College Campus Connect — Admin API
// Admin = superuser. Full CRUD over Student and Faculty records,
// plus platform-wide dashboard stats and activity log.
//
// ── Students (operates on the `students` admission table — the
//    record created during admission, which holds enrollment
//    number, course, hostel, fees, etc.) ──────────────────────
// GET    /api/admin.php/students                — list all students
// GET    /api/admin.php/students/{id}           — get one student (full profile)
// PUT    /api/admin.php/students/{id}           — edit student profile fields
// DELETE /api/admin.php/students/{id}           — delete a student
// PUT    /api/admin.php/students/{id}/status    — activate/deactivate
// PUT    /api/admin.php/students/{id}/password  — reset student password
//
// ── Faculty (operates on the `faculty` table) ─────────────────
// GET    /api/admin.php/faculty                 — list all faculty
// GET    /api/admin.php/faculty/{id}            — get one faculty member
// PUT    /api/admin.php/faculty/{id}            — edit faculty profile fields
// DELETE /api/admin.php/faculty/{id}            — delete a faculty member
// PUT    /api/admin.php/faculty/{id}/status     — activate/deactivate
// PUT    /api/admin.php/faculty/{id}/password   — reset faculty password
//
// ── Dashboard & Activity ──────────────────────────────────────
// GET    /api/admin.php/dashboard               — summary stats for Admin overview
// GET    /api/admin.php/activity                — recent admin activity log
//
// All endpoints require an authenticated Admin (superuser).
// Non-admin users receive 403 Forbidden via requireAdmin().
// Edits made here are immediately reflected in the corresponding
// student/faculty dashboards since both read from the same tables.
// ============================================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';
require_once __DIR__ . '/../config/telegram.php';
require_once __DIR__ . '/../helpers/telegram_helper.php';

setCORSHeaders();

// RBAC: every endpoint in this file requires admin (superuser) access.
$admin = requireAdmin();

$method   = $_SERVER['REQUEST_METHOD'];
$path     = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$resource = $path[0] ?? '';      // 'students' | 'faculty' | 'dashboard' | 'activity'
$id       = isset($path[1]) && is_numeric($path[1]) ? (int)$path[1] : null;
$sub      = $path[2] ?? '';      // e.g. 'status' | 'password'
$db       = getDB();

// ── Debug logging (writes to PHP error log; safe to leave enabled) ─────────
error_log("[admin.php] METHOD={$method} PATH_INFO=" . ($_SERVER['PATH_INFO'] ?? '(empty)') .
          " resource={$resource} id=" . ($id ?? 'null') . " sub={$sub}");

function logActivity($db, $adminId, $action, $targetType, $targetId, $details) {
    try {
        $stmt = $db->prepare("INSERT INTO admin_activity_log (admin_id, action, target_type, target_id, details) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$adminId, $action, $targetType, $targetId, $details]);
    } catch (\Exception $e) {
        // Activity logging must never break the main request.
    }
}

// ── Faculty Attendance: shared filtered-row builder (list + export) ──────────
// Supports filtering by ?date=YYYY-MM-DD, ?month=YYYY-MM, ?faculty_id=
// (faculty.faculty_id) and ?department=. Always reads live from the
// faculty_attendance table — no hardcoded values.
function getFilteredAttendanceRows($db) {
    $sql = "
        SELECT fa.id, fa.faculty_id AS user_id, fa.date, fa.status,
               fa.punch_in_time, fa.punch_out_time, fa.working_hours,
               f.faculty_id AS faculty_pk,
               COALESCE(f.employee_id, CONCAT('USR', fa.faculty_id)) AS employee_id,
               COALESCE(CONCAT(f.first_name, ' ', f.last_name), u.name) AS faculty_name,
               f.department, f.designation
        FROM faculty_attendance fa
        JOIN users        u ON u.id = fa.faculty_id
        LEFT JOIN faculty f ON f.email = u.email
        WHERE 1 = 1
    ";
    $params = [];

    if (!empty($_GET['date'])) {
        $sql .= " AND fa.date = ?";
        $params[] = $_GET['date'];
    }
    if (!empty($_GET['month'])) {
        $sql .= " AND DATE_FORMAT(fa.date, '%Y-%m') = ?";
        $params[] = $_GET['month'];
    }
    if (!empty($_GET['faculty_id'])) {
        $sql .= " AND f.faculty_id = ?";
        $params[] = (int)$_GET['faculty_id'];
    }
    if (!empty($_GET['department'])) {
        $sql .= " AND f.department = ?";
        $params[] = $_GET['department'];
    }

    $sql .= " ORDER BY fa.date DESC, faculty_name ASC";

    $stmt = $db->prepare($sql);
    $stmt->execute($params);
    return $stmt->fetchAll();
}

// ============================================================
// DASHBOARD — summary stats for Admin Overview tab
// ============================================================
if ($resource === 'dashboard' && $method === 'GET') {
    $stats = [];

    $stats['total_students']  = (int)$db->query("SELECT COUNT(*) FROM students")->fetchColumn();
    $stats['total_faculty']   = (int)$db->query("SELECT COUNT(*) FROM faculty")->fetchColumn();
    $stats['total_departments'] = (int)$db->query("SELECT COUNT(DISTINCT department) FROM courses WHERE department IS NOT NULL AND department <> ''")->fetchColumn();
    $stats['total_courses']   = (int)$db->query("SELECT COUNT(*) FROM courses")->fetchColumn();

    $stats['total_hostel_residents'] = (int)$db->query(
        "SELECT COUNT(*) FROM hostel_students WHERE status = 'Active'"
    )->fetchColumn();

    // Fee collections vs pending — based on payments table (collected)
    // and students' expected total (tuition + exam fee for their semester).
    $stats['total_fee_collected'] = (float)$db->query(
        "SELECT COALESCE(SUM(amount),0) FROM payments WHERE payment_status = 'success'"
    )->fetchColumn();

    $expectedTotal = (float)$db->query(
        "SELECT COALESCE(SUM(fs.total_fee),0)
         FROM students s
         JOIN fee_structure fs ON fs.course_id = s.course_id AND fs.semester = s.semester
         WHERE s.status = 'active'"
    )->fetchColumn();

    $stats['total_fee_expected'] = $expectedTotal;
    $stats['pending_fees'] = max(0, $expectedTotal - $stats['total_fee_collected']);

    // Recent registrations (last 10 students)
    $stats['recent_registrations'] = $db->query(
        "SELECT s.id, CONCAT(s.first_name, ' ', s.last_name) AS name, s.gr_number, s.email,
                c.course_name, s.semester, s.status, s.created_at
         FROM students s
         LEFT JOIN courses c ON c.id = s.course_id
         ORDER BY s.created_at DESC LIMIT 10"
    )->fetchAll();

    // Recent activities (from admin_activity_log, joined with admin name)
    $stats['recent_activities'] = $db->query(
        "SELECT al.id, al.action, al.target_type, al.target_id, al.details, al.created_at,
                u.name AS admin_name
         FROM admin_activity_log al
         LEFT JOIN users u ON u.id = al.admin_id
         ORDER BY al.created_at DESC LIMIT 15"
    )->fetchAll();

    jsonResponse($stats);
}

// ============================================================
// ACTIVITY LOG
// ============================================================
if ($resource === 'activity' && $method === 'GET') {
    $limit = max(1, min(100, intval($_GET['limit'] ?? 30)));
    $stmt = $db->prepare(
        "SELECT al.id, al.action, al.target_type, al.target_id, al.details, al.created_at,
                u.name AS admin_name
         FROM admin_activity_log al
         LEFT JOIN users u ON u.id = al.admin_id
         ORDER BY al.created_at DESC LIMIT ?"
    );
    $stmt->execute([$limit]);
    jsonResponse(['activities' => $stmt->fetchAll()]);
}

if (!in_array($resource, ['students', 'faculty', 'attendance'], true)) {
    jsonError('Not found.', 404);
}

// ============================================================
// FACULTY ATTENDANCE MANAGEMENT (Admin)
//
// GET    /admin.php/attendance                — list (filters: date, month, faculty_id, department)
// GET    /admin.php/attendance/dashboard      — summary stats + monthly statistics
// GET    /admin.php/attendance/export         — CSV export (same filters as list)
// PUT    /admin.php/attendance/{id}           — edit a single attendance record
//
// Reads/writes the same `faculty_attendance` (+ `faculty_punch_logs`)
// tables used by the Faculty self-service API, so edits made here are
// reflected immediately on the Faculty "My Attendance" / "Punch In/Out"
// dashboards (and vice-versa) — no caching, no hardcoded values.
// ============================================================
if ($resource === 'attendance') {
    $attSub = $path[1] ?? '';
    $attId  = (isset($path[1]) && is_numeric($path[1])) ? (int)$path[1] : null;

    // ── DASHBOARD SUMMARY ────────────────────────────────────
    if ($attSub === 'dashboard' && $method === 'GET') {
        $today = date('Y-m-d');
        $month = $_GET['month'] ?? date('Y-m');

        $totalActive = (int)$db->query("SELECT COUNT(*) FROM faculty WHERE status = 'Active'")->fetchColumn();

        $stmt = $db->prepare("SELECT COUNT(*) FROM faculty_attendance WHERE date = ? AND status = 'Present'");
        $stmt->execute([$today]);
        $presentToday = (int)$stmt->fetchColumn();

        $stmt = $db->prepare("SELECT COUNT(*) FROM faculty_attendance WHERE date = ? AND status = 'Leave'");
        $stmt->execute([$today]);
        $leaveToday = (int)$stmt->fetchColumn();

        $absentToday = max(0, $totalActive - $presentToday - $leaveToday);

        $stmt = $db->prepare("SELECT ROUND(AVG(working_hours), 2) FROM faculty_attendance WHERE date = ? AND working_hours IS NOT NULL");
        $stmt->execute([$today]);
        $avgHoursToday = (float)($stmt->fetchColumn() ?: 0);

        $stmt = $db->prepare("SELECT ROUND(AVG(working_hours), 2) FROM faculty_attendance WHERE DATE_FORMAT(date, '%Y-%m') = ? AND working_hours IS NOT NULL");
        $stmt->execute([$month]);
        $avgHoursMonth = (float)($stmt->fetchColumn() ?: 0);

        $stmt = $db->prepare("
            SELECT date,
                   SUM(status = 'Present') AS present_count,
                   SUM(status = 'Absent')  AS absent_count,
                   SUM(status = 'Leave')   AS leave_count
            FROM faculty_attendance
            WHERE DATE_FORMAT(date, '%Y-%m') = ?
            GROUP BY date
            ORDER BY date ASC
        ");
        $stmt->execute([$month]);
        $monthlyStats = $stmt->fetchAll();

        $departments = $db->query(
            "SELECT DISTINCT department FROM faculty WHERE department IS NOT NULL AND department <> '' ORDER BY department"
        )->fetchAll(PDO::FETCH_COLUMN);

        $facultyList = $db->query(
            "SELECT faculty_id, employee_id, CONCAT(first_name, ' ', last_name) AS name, department
             FROM faculty ORDER BY first_name"
        )->fetchAll();

        jsonResponse([
            'date'                     => $today,
            'month'                    => $month,
            'total_faculty'            => $totalActive,
            'present_today'            => $presentToday,
            'absent_today'             => $absentToday,
            'on_leave_today'           => $leaveToday,
            'avg_working_hours_today'  => $avgHoursToday,
            'avg_working_hours_month'  => $avgHoursMonth,
            'monthly_stats'            => $monthlyStats,
            'departments'              => $departments,
            'faculty'                  => $facultyList,
        ]);
    }

    // ── EXPORT (CSV — opens in Excel; same filters as list) ───
    if ($attSub === 'export' && $method === 'GET') {
        $rows = getFilteredAttendanceRows($db);

        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="faculty_attendance_' . date('Ymd_His') . '.csv"');

        $out = fopen('php://output', 'w');
        fputcsv($out, ['Employee ID', 'Faculty Name', 'Department', 'Designation', 'Date', 'Punch In', 'Punch Out', 'Working Hours (hrs)', 'Status']);
        foreach ($rows as $r) {
            fputcsv($out, [
                $r['employee_id'],
                $r['faculty_name'],
                $r['department'],
                $r['designation'],
                $r['date'],
                $r['punch_in_time']  ?: '-',
                $r['punch_out_time'] ?: '-',
                $r['working_hours'] !== null ? $r['working_hours'] : '-',
                $r['status'],
            ]);
        }
        fclose($out);
        exit;
    }

    // ── EDIT a single attendance record ───────────────────────
    if ($attId !== null && $method === 'PUT') {
        $stmt = $db->prepare("SELECT * FROM faculty_attendance WHERE id = ?");
        $stmt->execute([$attId]);
        $existing = $stmt->fetch();
        if (!$existing) jsonError('Attendance record not found.', 404);

        $data = json_decode(file_get_contents('php://input'), true) ?? [];

        $status = $data['status'] ?? $existing['status'];
        if (!in_array($status, ['Present', 'Absent', 'Leave'], true)) {
            jsonError('Invalid status. Must be Present, Absent, or Leave.', 400);
        }

        $normalizeTime = function ($t) {
            if ($t === null || $t === '') return null;
            return strlen($t) === 5 ? "$t:00" : $t; // "HH:MM" -> "HH:MM:SS"
        };

        $punchIn  = array_key_exists('punch_in_time', $data)  ? $normalizeTime($data['punch_in_time'])  : $existing['punch_in_time'];
        $punchOut = array_key_exists('punch_out_time', $data) ? $normalizeTime($data['punch_out_time']) : $existing['punch_out_time'];

        // Recompute working hours unless an explicit override was sent
        if (array_key_exists('working_hours', $data) && $data['working_hours'] !== '' && $data['working_hours'] !== null) {
            $workingHours = round((float)$data['working_hours'], 2);
        } elseif ($punchIn && $punchOut) {
            $in  = DateTime::createFromFormat('H:i:s', $punchIn);
            $out = DateTime::createFromFormat('H:i:s', $punchOut);
            $workingHours = ($in && $out && $out > $in) ? round(($out->getTimestamp() - $in->getTimestamp()) / 3600, 2) : 0;
        } else {
            $workingHours = null;
        }

        $db->prepare(
            "UPDATE faculty_attendance SET status = ?, punch_in_time = ?, punch_out_time = ?, working_hours = ? WHERE id = ?"
        )->execute([$status, $punchIn, $punchOut, $workingHours, $attId]);

        // Keep faculty_punch_logs (raw datetime punch log) in sync
        $date  = $existing['date'];
        $inDt  = $punchIn  ? "$date $punchIn"  : null;
        $outDt = $punchOut ? "$date $punchOut" : null;
        $db->prepare("
            INSERT INTO faculty_punch_logs (faculty_id, date, punch_in_time, punch_out_time, total_working_hours)
            VALUES (?, ?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE
              punch_in_time = VALUES(punch_in_time),
              punch_out_time = VALUES(punch_out_time),
              total_working_hours = VALUES(total_working_hours)
        ")->execute([$existing['faculty_id'], $date, $inDt, $outDt, $workingHours]);

        logActivity($db, $admin['id'], 'edited_attendance', 'faculty_attendance', $attId,
            "Updated attendance for faculty user #{$existing['faculty_id']} on $date (status: $status)");

        $stmt = $db->prepare("SELECT * FROM faculty_attendance WHERE id = ?");
        $stmt->execute([$attId]);
        jsonResponse(['message' => 'Attendance record updated successfully.', 'record' => $stmt->fetch()]);
    }

    // ── LIST (with filters: date, month, faculty_id, department) ──
    if ($attSub === '' && $attId === null && $method === 'GET') {
        $rows = getFilteredAttendanceRows($db);

        $present = count(array_filter($rows, fn($r) => $r['status'] === 'Present'));
        $absent  = count(array_filter($rows, fn($r) => $r['status'] === 'Absent'));
        $leave   = count(array_filter($rows, fn($r) => $r['status'] === 'Leave'));

        $departments = $db->query(
            "SELECT DISTINCT department FROM faculty WHERE department IS NOT NULL AND department <> '' ORDER BY department"
        )->fetchAll(PDO::FETCH_COLUMN);

        $facultyList = $db->query(
            "SELECT faculty_id, employee_id, CONCAT(first_name, ' ', last_name) AS name, department
             FROM faculty ORDER BY first_name"
        )->fetchAll();

        jsonResponse([
            'records'     => $rows,
            'summary'     => ['total' => count($rows), 'present' => $present, 'absent' => $absent, 'leave' => $leave],
            'departments' => $departments,
            'faculty'     => $facultyList,
        ]);
    }

    jsonError('Not found.', 404);
}

if (!in_array($resource, ['students', 'faculty'], true)) {
    jsonError('Not found.', 404);
}

// ============================================================
// STUDENTS — backed by the `students` admission table
// ============================================================
if ($resource === 'students') {

    // ── LIST ─────────────────────────────────────────────────
    if ($method === 'GET' && $id === null) {
        // Check if profile_photo column exists (may be absent if
        // schema_fix_missing_columns.sql hasn't been applied yet).
        // We query information_schema once and adjust the SELECT accordingly
        // so the list always loads, even on a partially-migrated database.
        $hasProfilePhoto = false;
        try {
            $colCheck = $db->prepare(
                "SELECT COUNT(*) FROM information_schema.COLUMNS
                 WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'students' AND COLUMN_NAME = 'profile_photo'"
            );
            $colCheck->execute();
            $hasProfilePhoto = (int)$colCheck->fetchColumn() > 0;
        } catch (\Exception $ignored) {}

        $photoSql = $hasProfilePhoto ? 's.profile_photo,' : "NULL AS profile_photo,";

        try {
            $rows = $db->query(
                "SELECT s.id, s.first_name, s.middle_name, s.last_name, s.email, s.phone, s.gender, s.dob,
                        s.address, s.gr_number, s.course_id, s.semester, s.admission_year, s.status,
                        {$photoSql} c.course_name, c.course_code,
                        lc.email AS login_email,
                        s.created_at, s.updated_at
                 FROM students s
                 LEFT JOIN courses c ON c.id = s.course_id
                 LEFT JOIN login_credentials lc ON lc.student_id = s.id
                 ORDER BY s.created_at DESC"
            )->fetchAll();
        } catch (\PDOException $e) {
            error_log("[admin.php] students LIST error: " . $e->getMessage());
            jsonError('Failed to load students: ' . $e->getMessage(), 500);
        }

        error_log("[admin.php] students LIST returned " . count($rows) . " row(s)");
        jsonResponse(['students' => $rows]);
    }

    // ── GET ONE (full profile incl. hostel + fee status) ──────
    if ($method === 'GET' && $id !== null && !$sub) {
        $stmt = $db->prepare(
            "SELECT s.*, c.course_name, c.course_code, c.total_semesters, c.department,
                    lc.email AS login_email
             FROM students s
             LEFT JOIN courses c ON c.id = s.course_id
             LEFT JOIN login_credentials lc ON lc.student_id = s.id
             WHERE s.id = ?"
        );
        $stmt->execute([$id]);
        $row = $stmt->fetch();
        if (!$row) jsonError('Student not found.', 404);

        // Hostel details
        $hStmt = $db->prepare("SELECT * FROM hostel_students WHERE student_id = ? ORDER BY id DESC LIMIT 1");
        $hStmt->execute([$id]);
        $row['hostel'] = $hStmt->fetch() ?: null;

        // Fee status: expected (from fee_structure) vs paid (from payments)
        $feeStmt = $db->prepare("SELECT total_fee FROM fee_structure WHERE course_id = ? AND semester = ?");
        $feeStmt->execute([$row['course_id'], $row['semester']]);
        $expected = (float)($feeStmt->fetchColumn() ?: 0);

        $paidStmt = $db->prepare("SELECT COALESCE(SUM(amount),0) FROM payments WHERE student_id = ? AND payment_status = 'success'");
        $paidStmt->execute([$id]);
        $paid = (float)$paidStmt->fetchColumn();

        $row['fee_status'] = [
            'expected' => $expected,
            'paid'     => $paid,
            'pending'  => max(0, $expected - $paid),
            'status'   => $paid >= $expected && $expected > 0 ? 'Paid' : ($paid > 0 ? 'Partial' : 'Pending'),
        ];

        jsonResponse($row);
    }

    // ── UPDATE PROFILE ─────────────────────────────────────────
    // Editable fields: Name, Email, Mobile, Address, Department(course),
    // Semester, Enrollment Number (gr_number), Hostel Details, Fee Status,
    // Profile Photo.
    if ($method === 'PUT' && $id !== null && !$sub) {
        $stmt = $db->prepare("SELECT * FROM students WHERE id = ?");
        $stmt->execute([$id]);
        $existing = $stmt->fetch();
        if (!$existing) jsonError('Student not found.', 404);

        $data = json_decode(file_get_contents('php://input'), true) ?? [];

        $fields = [];
        $values = [];

        // Name (split into first/middle/last if a single `name` is sent)
        if (array_key_exists('name', $data) && !array_key_exists('first_name', $data)) {
            $parts = preg_split('/\s+/', trim($data['name']));
            $data['first_name']  = $parts[0] ?? '';
            $data['last_name']   = count($parts) > 1 ? array_pop($parts) : '';
            $data['middle_name'] = count($parts) > 1 ? implode(' ', array_slice($parts, 1)) : '';
        }

        foreach (['first_name', 'middle_name', 'last_name', 'address'] as $f) {
            if (array_key_exists($f, $data)) {
                $fields[] = "$f = ?";
                $values[] = sanitize($data[$f]);
            }
        }
        if (array_key_exists('phone', $data)) {
            $phone = sanitize($data['phone']);
            if ($phone !== '' && !preg_match('/^[0-9+\-\s]{7,15}$/', $phone)) {
                jsonError('Invalid mobile number format.', 400);
            }
            $fields[] = 'phone = ?';
            $values[] = $phone;
        }
        if (array_key_exists('email', $data)) {
            $email = filter_var($data['email'], FILTER_VALIDATE_EMAIL);
            if ($data['email'] && !$email) jsonError('Invalid email address.', 400);
            $fields[] = 'email = ?';
            $values[] = $email ?: null;
        }
        if (array_key_exists('gr_number', $data)) {
            $fields[] = 'gr_number = ?';
            $values[] = sanitize($data['gr_number']) ?: null;
        }
        if (array_key_exists('profile_photo', $data)) {
            $fields[] = 'profile_photo = ?';
            $values[] = sanitize($data['profile_photo']);
        }
        if (array_key_exists('semester', $data)) {
            $sem = intval($data['semester']);
            if ($sem < 1 || $sem > 12) jsonError('Invalid semester.', 400);
            $fields[] = 'semester = ?';
            $values[] = $sem;
        }
        // "Department" — admin edits the student's course (which carries the department)
        if (array_key_exists('course_id', $data)) {
            $courseId = intval($data['course_id']);
            $cStmt = $db->prepare("SELECT id FROM courses WHERE id = ?");
            $cStmt->execute([$courseId]);
            if (!$cStmt->fetch()) jsonError('Invalid course_id.', 400);
            $fields[] = 'course_id = ?';
            $values[] = $courseId;
        }

        // ── Transportation ──────────────────────────────────────
        // Admin can change a student's transport selection here too.
        // Setting transport_required = "No" clears location/bus/fee.
        // Setting transport_required = "Yes" with a transport_location
        // re-resolves bus_number/transport_fee from the live
        // transportation_routes table (must be an ACTIVE route).
        if (array_key_exists('transport_required', $data)) {
            $transportRequired = $data['transport_required'] === 'Yes' ? 'Yes' : 'No';
            $fields[] = 'transport_required = ?';
            $values[] = $transportRequired;

            if ($transportRequired === 'No') {
                $fields[] = 'transport_location = NULL, bus_number = NULL, transport_fee = 0';
            } elseif (array_key_exists('transport_location', $data)) {
                $location = sanitize($data['transport_location']);
                $tStmt = $db->prepare(
                    "SELECT bus_number, transport_fee FROM transportation_routes WHERE location = ? AND status = 'active'"
                );
                $tStmt->execute([$location]);
                $route = $tStmt->fetch();
                if (!$route) jsonError('Selected transportation location is not available.', 400);

                $fields[] = 'transport_location = ?';
                $values[] = $location;
                $fields[] = 'bus_number = ?';
                $values[] = $route['bus_number'];
                $fields[] = 'transport_fee = ?';
                $values[] = (float)$route['transport_fee'];
            }
        }

        if ($fields) {
            $values[] = $id;
            $db->prepare("UPDATE students SET " . implode(', ', $fields) . " WHERE id = ?")->execute($values);

            // Keep the social `users` table (used for app login/feed) in sync for name/email
            if (array_key_exists('email', $data) || array_key_exists('first_name', $data) || array_key_exists('last_name', $data)) {
                $newStmt = $db->prepare("SELECT * FROM students WHERE id = ?");
                $newStmt->execute([$id]);
                $updated = $newStmt->fetch();
                $fullName = trim($updated['first_name'] . ' ' . $updated['last_name']);

                $lcStmt = $db->prepare("SELECT email FROM login_credentials WHERE student_id = ?");
                $lcStmt->execute([$id]);
                $loginEmail = $lcStmt->fetchColumn();
                if ($loginEmail) {
                    $db->prepare("UPDATE users SET name = ? WHERE email = ?")->execute([$fullName, $loginEmail]);
                }
            }
        }

        // ── Hostel Details (Admin can edit hostel allocation) ────
        if (array_key_exists('hostel', $data) && is_array($data['hostel'])) {
            $h = $data['hostel'];
            $hStmt = $db->prepare("SELECT id FROM hostel_students WHERE student_id = ? ORDER BY id DESC LIMIT 1");
            $hStmt->execute([$id]);
            $hostelRow = $hStmt->fetch();

            $hostelType   = $h['hostel_type']   ?? null;
            $roomType     = $h['room_type']     ?? null;
            $roomNumber   = $h['room_number']   ?? 'Pending Allocation';
            $allocStatus  = $h['allocation_status'] ?? 'Pending';
            $status       = $h['status']        ?? 'Active';

            if ($hostelRow) {
                $db->prepare(
                    "UPDATE hostel_students SET hostel_type = ?, room_type = ?, room_number = ?, allocation_status = ?, status = ? WHERE id = ?"
                )->execute([$hostelType, $roomType, $roomNumber, $allocStatus, $status, $hostelRow['id']]);
            } else {
                $db->prepare(
                    "INSERT INTO hostel_students (student_id, hostel_type, room_type, room_number, allocation_status, status, admission_date)
                     VALUES (?, ?, ?, ?, ?, ?, CURDATE())"
                )->execute([$id, $hostelType, $roomType, $roomNumber, $allocStatus, $status]);
            }
        }

        // ── Fee Status (Admin can record a manual payment / mark paid) ──
        if (array_key_exists('fee_status', $data) && is_array($data['fee_status'])) {
            $fs = $data['fee_status'];
            if (array_key_exists('record_payment', $fs)) {
                $amount = floatval($fs['record_payment']);
                if ($amount < 0) jsonError('Payment amount cannot be negative.', 400);
                if ($amount > 0) {
                    $db->prepare(
                        "INSERT INTO payments (student_id, amount, payment_status, razorpay_order_id, razorpay_payment_id)
                         VALUES (?, ?, 'success', ?, ?)"
                    )->execute([$id, $amount, 'ADMIN-' . time(), 'ADMIN-ADJ-' . time()]);
                }
            }
        }

        logActivity($db, $admin['id'], 'edited_student', 'student', $id, "Updated profile for student #$id");

        // Return the fresh profile
        $stmt = $db->prepare(
            "SELECT s.*, c.course_name, c.course_code, lc.email AS login_email
             FROM students s
             LEFT JOIN courses c ON c.id = s.course_id
             LEFT JOIN login_credentials lc ON lc.student_id = s.id
             WHERE s.id = ?"
        );
        $stmt->execute([$id]);
        jsonResponse(['message' => 'Student profile updated successfully.', 'student' => $stmt->fetch()]);
    }

    // ── ACTIVATE / DEACTIVATE ────────────────────────────────
    if ($method === 'PUT' && $id !== null && $sub === 'status') {
        $data   = json_decode(file_get_contents('php://input'), true) ?? [];
        $active = isset($data['active']) ? (bool)$data['active'] : null;
        if ($active === null) jsonError('active (true|false) is required.', 400);

        $newStatus = $active ? 'active' : 'inactive';

        $check = $db->prepare("SELECT id FROM students WHERE id = ?");
        $check->execute([$id]);
        if (!$check->fetch()) jsonError('Student not found.', 404);

        $db->prepare("UPDATE students SET status = ? WHERE id = ?")->execute([$newStatus, $id]);

        logActivity($db, $admin['id'], $active ? 'activated_student' : 'deactivated_student', 'student', $id, "Set status to $newStatus");

        jsonResponse(['message' => 'Student ' . ($active ? 'activated.' : 'deactivated.')]);
    }

    // ── PASSWORD RESET ────────────────────────────────────────
    if ($method === 'PUT' && $id !== null && $sub === 'password') {
        $data = json_decode(file_get_contents('php://input'), true) ?? [];

        $newPassword = $data['password'] ?? null;
        $generated   = false;
        if (!$newPassword) {
            $newPassword = 'PT@' . random_int(100000, 999999);
            $generated   = true;
        }
        if (strlen($newPassword) < 6) jsonError('Password must be at least 6 characters.', 400);

        $hash = password_hash($newPassword, PASSWORD_BCRYPT);

        $stmt = $db->prepare("UPDATE login_credentials SET password_hash = ? WHERE student_id = ?");
        $stmt->execute([$hash, $id]);
        if ($stmt->rowCount() === 0) jsonError('No login credentials found for this student.', 404);

        // Keep `users` table in sync for app login
        $lcStmt = $db->prepare("SELECT email FROM login_credentials WHERE student_id = ?");
        $lcStmt->execute([$id]);
        $loginEmail = $lcStmt->fetchColumn();
        if ($loginEmail) {
            $db->prepare("UPDATE users SET password_hash = ? WHERE email = ?")->execute([$hash, $loginEmail]);
        }

        logActivity($db, $admin['id'], 'reset_password', 'student', $id, 'Admin reset student password');

        $response = ['message' => 'Password reset successfully.'];
        if ($generated) $response['new_password'] = $newPassword;
        jsonResponse($response);
    }

    // ── DELETE ───────────────────────────────────────────────
    if ($method === 'DELETE' && $id !== null && !$sub) {
        $stmt = $db->prepare("SELECT * FROM students WHERE id = ?");
        $stmt->execute([$id]);
        $existing = $stmt->fetch();
        if (!$existing) jsonError('Student not found.', 404);

        // Remove from social `users` table too, if present
        $lcStmt = $db->prepare("SELECT email FROM login_credentials WHERE student_id = ?");
        $lcStmt->execute([$id]);
        $loginEmail = $lcStmt->fetchColumn();
        if ($loginEmail) {
            $db->prepare("DELETE FROM users WHERE email = ?")->execute([$loginEmail]);
        }

        $db->prepare("DELETE FROM students WHERE id = ?")->execute([$id]);

        logActivity($db, $admin['id'], 'deleted_student', 'student', $id,
            "Deleted student {$existing['first_name']} {$existing['last_name']} (GR: {$existing['gr_number']})");

        jsonResponse(['message' => 'Student deleted successfully.']);
    }

    jsonError('Not found.', 404);
}

// ============================================================
// FACULTY — backed by the `faculty` table
// ============================================================
if ($resource === 'faculty') {

    // ── CREATE (Faculty Admission) ──────────────────────────────
    // POST /api/admin.php/faculty
    // Body: { first_name, last_name, middle_name?, phone, department,
    //         designation, qualification?, specialization?, dob?, gender?,
    //         address?, experience? }
    // Generates employee_id, college email, and a login password exactly
    // the way student admission (admission.php /payment) generates
    // gr_number/email/password, creates the `users` row for app login,
    // and — new — sends the credentials to the faculty member's Telegram
    // chat if they've already linked one via the bot.
    if ($method === 'POST' && $id === null) {
        $data = json_decode(file_get_contents('php://input'), true) ?? [];

        $firstName  = sanitize($data['first_name'] ?? '');
        $middleName = sanitize($data['middle_name'] ?? '');
        $lastName   = sanitize($data['last_name'] ?? '');
        $phone      = sanitize($data['phone'] ?? '');
        $department = sanitize($data['department'] ?? '');
        $designation = $data['designation'] ?? '';
        $qualification = sanitize($data['qualification'] ?? '');
        $specialization = sanitize($data['specialization'] ?? '');
        $dob        = $data['dob'] ?? null;
        $gender     = $data['gender'] ?? null;
        $address    = sanitize($data['address'] ?? '');
        $experience = isset($data['experience']) ? intval($data['experience']) : null;

        if (!$firstName || !$lastName || !$phone || !$department) {
            jsonError('first_name, last_name, phone and department are required.', 400);
        }
        $validDesignations = ['Professor','Assistant Professor','Associate Professor','HOD','Lab Assistant','Lecturer','Visiting Faculty'];
        if ($designation && !in_array($designation, $validDesignations, true)) {
            jsonError('Invalid designation.', 400);
        }

        // Generate Employee ID: PTFAC + Year + sequence, e.g. PTFAC20260007
        $year = date('Y');
        $seqStmt = $db->prepare("SELECT COUNT(*) FROM faculty WHERE YEAR(registration_date) = ?");
        $seqStmt->execute([$year]);
        $seq = (int)$seqStmt->fetchColumn() + 1;
        $employeeId = "PTFAC{$year}" . str_pad($seq, 4, '0', STR_PAD_LEFT);

        // Generate college email: firstname.lastname@primetech.ac.in (uniqueness-checked)
        $base = strtolower($firstName . '.' . $lastName);
        $base = preg_replace('/[^a-z.]/', '', $base);
        $email = $base . '@primetech.ac.in';
        $eStmt = $db->prepare("SELECT COUNT(*) FROM faculty WHERE email = ?");
        $eStmt->execute([$email]);
        if ((int)$eStmt->fetchColumn() > 0) {
            $i = 1;
            while (true) {
                $candidate = $base . $i . '@primetech.ac.in';
                $eStmt->execute([$candidate]);
                if ((int)$eStmt->fetchColumn() === 0) { $email = $candidate; break; }
                $i++;
            }
        }

        // Generate secure password
        $rawPass  = 'PT@' . random_int(100000, 999999);
        $passHash = password_hash($rawPass, PASSWORD_BCRYPT);

        try {
            $stmt = $db->prepare(
                "INSERT INTO faculty
                    (employee_id, first_name, middle_name, last_name, email, password_hash,
                     dob, gender, phone, address, department, designation, qualification,
                     specialization, experience, joining_date, status)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURDATE(), 'Active')"
            );
            $stmt->execute([
                $employeeId, $firstName, $middleName, $lastName, $email, $passHash,
                $dob ?: null, $gender ?: null, $phone, $address, $department,
                $designation ?: null, $qualification, $specialization, $experience,
            ]);
            $facultyId = $db->lastInsertId();
        } catch (\Exception $e) {
            jsonError('Could not create faculty. Email or Employee ID may already be in use.', 409);
        }

        // Also insert into `users` for app login, same pattern as student admission
        $fullName = trim($firstName . ' ' . $lastName);
        $db->prepare(
            "INSERT INTO users (name, email, password_hash, major, year, role) VALUES (?, ?, ?, ?, NULL, 'faculty')"
        )->execute([$fullName, $email, $passHash, $department]);

        logActivity($db, $admin['id'], 'created_faculty', 'faculty', $facultyId, "Created faculty {$fullName} (Employee ID: {$employeeId})");

        // ── Telegram: send login credentials to the faculty member ─────
        // Never blocks or alters the API response — failures are logged
        // by sendTelegramMessage() and swallowed here.
        try {
            $chatId = findTelegramChatIdByPhone($phone);
            if ($chatId) {
                $db->prepare("UPDATE faculty SET telegram_chat_id = ? WHERE faculty_id = ?")->execute([$chatId, $facultyId]);
                $welcomeMsg = buildFacultyWelcomeMessage([
                    'name'        => "Mr./Ms. {$fullName}",
                    'employee_id' => $employeeId,
                    'department'  => $department,
                    'email'       => $email,
                    'password'    => $rawPass,
                ]);
                sendTelegramMessage($chatId, $welcomeMsg);
            } else {
                savePendingCredentials($phone, 'faculty', [
                    'name'        => "Mr./Ms. {$fullName}",
                    'employee_id' => $employeeId,
                    'department'  => $department,
                    'email'       => $email,
                    'password'    => $rawPass,
                ]);
                error_log("[Telegram] No chat_id linked yet for faculty #$facultyId (phone $phone) - credentials saved for delivery once linked.");
            }
        } catch (\Throwable $e) {
            error_log('[Telegram] Faculty welcome message failed: ' . $e->getMessage());
        }

        jsonResponse([
            'message'     => 'Faculty account created successfully.',
            'faculty_id'  => $facultyId,
            'employee_id' => $employeeId,
            'email'       => $email,
            'password'    => $rawPass,
        ], 201);
    }

    // ── LIST ─────────────────────────────────────────────────
    if ($method === 'GET' && $id === null) {
        // Check if salary column exists (added by schema_fee_management.sql /
        // schema_fix_missing_columns.sql — may be absent on partial migrations).
        $hasSalary = false;
        try {
            $colCheck = $db->prepare(
                "SELECT COUNT(*) FROM information_schema.COLUMNS
                 WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'faculty' AND COLUMN_NAME = 'salary'"
            );
            $colCheck->execute();
            $hasSalary = (int)$colCheck->fetchColumn() > 0;
        } catch (\Exception $ignored) {}

        $salarySql = $hasSalary ? ', salary' : '';

        try {
            $rows = $db->query(
                "SELECT faculty_id, employee_id, first_name, middle_name, last_name, email, phone,
                        department, designation, qualification, status, registration_date, last_login
                        {$salarySql}
                 FROM faculty ORDER BY registration_date DESC"
            )->fetchAll();
        } catch (\PDOException $e) {
            error_log("[admin.php] faculty LIST error: " . $e->getMessage());
            jsonError('Failed to load faculty: ' . $e->getMessage(), 500);
        }

        error_log("[admin.php] faculty LIST returned " . count($rows) . " row(s)");
        jsonResponse(['faculty' => $rows]);
    }

    // ── GET ONE ──────────────────────────────────────────────
    if ($method === 'GET' && $id !== null && !$sub) {
        $stmt = $db->prepare("SELECT * FROM faculty WHERE faculty_id = ?");
        $stmt->execute([$id]);
        $row = $stmt->fetch();
        if (!$row) jsonError('Faculty member not found.', 404);
        unset($row['password_hash']);

        $docStmt = $db->prepare("SELECT profile_photo, resume, qualification_certificate, id_proof FROM faculty_documents WHERE faculty_id = ? ORDER BY doc_id DESC LIMIT 1");
        $docStmt->execute([$id]);
        $row['documents'] = $docStmt->fetch() ?: null;

        jsonResponse($row);
    }

    // ── UPDATE PROFILE ─────────────────────────────────────────
    // Editable fields: Name, Email, Mobile, Department, Designation,
    // Qualification, Salary Details, Profile Photo.
    if ($method === 'PUT' && $id !== null && !$sub) {
        $stmt = $db->prepare("SELECT * FROM faculty WHERE faculty_id = ?");
        $stmt->execute([$id]);
        $existing = $stmt->fetch();
        if (!$existing) jsonError('Faculty member not found.', 404);

        $data = json_decode(file_get_contents('php://input'), true) ?? [];

        if (array_key_exists('name', $data) && !array_key_exists('first_name', $data)) {
            $parts = preg_split('/\s+/', trim($data['name']));
            $data['first_name']  = $parts[0] ?? '';
            $data['last_name']   = count($parts) > 1 ? array_pop($parts) : '';
            $data['middle_name'] = count($parts) > 1 ? implode(' ', array_slice($parts, 1)) : '';
        }

        $fields = [];
        $values = [];

        foreach (['first_name', 'middle_name', 'last_name', 'department', 'qualification', 'specialization', 'address'] as $f) {
            if (array_key_exists($f, $data)) {
                $fields[] = "$f = ?";
                $values[] = sanitize($data[$f]);
            }
        }
        if (array_key_exists('phone', $data)) {
            $phone = sanitize($data['phone']);
            if ($phone !== '' && !preg_match('/^[0-9+\-\s]{7,15}$/', $phone)) {
                jsonError('Invalid mobile number format.', 400);
            }
            $fields[] = 'phone = ?';
            $values[] = $phone;
        }
        if (array_key_exists('email', $data)) {
            $email = filter_var($data['email'], FILTER_VALIDATE_EMAIL);
            if (!$email) jsonError('Invalid email address.', 400);
            $fields[] = 'email = ?';
            $values[] = $email;
        }
        if (array_key_exists('designation', $data)) {
            $valid = ['Professor','Assistant Professor','Associate Professor','HOD','Lab Assistant','Lecturer','Visiting Faculty'];
            if (!in_array($data['designation'], $valid, true)) jsonError('Invalid designation.', 400);
            $fields[] = 'designation = ?';
            $values[] = $data['designation'];
        }
        // Salary Details — admin only, sensitive field
        if (array_key_exists('salary', $data)) {
            $salary = $data['salary'] === null || $data['salary'] === '' ? null : floatval($data['salary']);
            if ($salary !== null && $salary < 0) jsonError('Salary cannot be negative.', 400);
            $fields[] = 'salary = ?';
            $values[] = $salary;
        }
        if (array_key_exists('experience', $data)) {
            $exp = intval($data['experience']);
            if ($exp < 0 || $exp > 60) jsonError('Invalid experience value.', 400);
            $fields[] = 'experience = ?';
            $values[] = $exp;
        }

        if ($fields) {
            $values[] = $id;
            try {
                $db->prepare("UPDATE faculty SET " . implode(', ', $fields) . " WHERE faculty_id = ?")->execute($values);
            } catch (\Exception $e) {
                jsonError('Could not update faculty. Email may already be in use.', 409);
            }
        }

        // Profile Photo — stored in faculty_documents
        if (array_key_exists('profile_photo', $data)) {
            $photo = sanitize($data['profile_photo']);
            $docStmt = $db->prepare("SELECT doc_id FROM faculty_documents WHERE faculty_id = ?");
            $docStmt->execute([$id]);
            $docRow = $docStmt->fetch();
            if ($docRow) {
                $db->prepare("UPDATE faculty_documents SET profile_photo = ? WHERE faculty_id = ?")->execute([$photo, $id]);
            } else {
                $db->prepare("INSERT INTO faculty_documents (faculty_id, profile_photo) VALUES (?, ?)")->execute([$id, $photo]);
            }
        }

        // Sync name/email into `users` table for app login (faculty also have a users row)
        if (array_key_exists('email', $data) || array_key_exists('first_name', $data) || array_key_exists('last_name', $data)) {
            $newStmt = $db->prepare("SELECT * FROM faculty WHERE faculty_id = ?");
            $newStmt->execute([$id]);
            $updated  = $newStmt->fetch();
            $fullName = trim($updated['first_name'] . ' ' . $updated['last_name']);
            $db->prepare("UPDATE users SET name = ?, email = ? WHERE email = ?")
               ->execute([$fullName, $updated['email'], $existing['email']]);
        }

        logActivity($db, $admin['id'], 'edited_faculty', 'faculty', $id, "Updated profile for faculty #$id");

        $stmt = $db->prepare("SELECT * FROM faculty WHERE faculty_id = ?");
        $stmt->execute([$id]);
        $row = $stmt->fetch();
        unset($row['password_hash']);
        jsonResponse(['message' => 'Faculty profile updated successfully.', 'faculty' => $row]);
    }

    // ── ACTIVATE / DEACTIVATE ────────────────────────────────
    if ($method === 'PUT' && $id !== null && $sub === 'status') {
        $data   = json_decode(file_get_contents('php://input'), true) ?? [];
        $active = isset($data['active']) ? (bool)$data['active'] : null;
        if ($active === null) jsonError('active (true|false) is required.', 400);

        $newStatus = $active ? 'Active' : 'Inactive';

        $check = $db->prepare("SELECT faculty_id FROM faculty WHERE faculty_id = ?");
        $check->execute([$id]);
        if (!$check->fetch()) jsonError('Faculty member not found.', 404);

        $db->prepare("UPDATE faculty SET status = ? WHERE faculty_id = ?")->execute([$newStatus, $id]);

        logActivity($db, $admin['id'], $active ? 'activated_faculty' : 'deactivated_faculty', 'faculty', $id, "Set status to $newStatus");

        jsonResponse(['message' => 'Faculty ' . ($active ? 'activated.' : 'deactivated.')]);
    }

    // ── PASSWORD RESET ────────────────────────────────────────
    if ($method === 'PUT' && $id !== null && $sub === 'password') {
        $data = json_decode(file_get_contents('php://input'), true) ?? [];

        $newPassword = $data['password'] ?? null;
        $generated   = false;
        if (!$newPassword) {
            $newPassword = 'PT@' . random_int(100000, 999999);
            $generated   = true;
        }
        if (strlen($newPassword) < 6) jsonError('Password must be at least 6 characters.', 400);

        $hash = password_hash($newPassword, PASSWORD_BCRYPT);

        $stmt = $db->prepare("SELECT email FROM faculty WHERE faculty_id = ?");
        $stmt->execute([$id]);
        $facultyEmail = $stmt->fetchColumn();
        if (!$facultyEmail) jsonError('Faculty member not found.', 404);

        $db->prepare("UPDATE faculty SET password_hash = ? WHERE faculty_id = ?")->execute([$hash, $id]);
        $db->prepare("UPDATE users SET password_hash = ? WHERE email = ?")->execute([$hash, $facultyEmail]);

        logActivity($db, $admin['id'], 'reset_password', 'faculty', $id, 'Admin reset faculty password');

        $response = ['message' => 'Password reset successfully.'];
        if ($generated) $response['new_password'] = $newPassword;
        jsonResponse($response);
    }

    // ── DELETE ───────────────────────────────────────────────
    if ($method === 'DELETE' && $id !== null && !$sub) {
        $stmt = $db->prepare("SELECT * FROM faculty WHERE faculty_id = ?");
        $stmt->execute([$id]);
        $existing = $stmt->fetch();
        if (!$existing) jsonError('Faculty member not found.', 404);

        $db->prepare("DELETE FROM users WHERE email = ?")->execute([$existing['email']]);
        $db->prepare("DELETE FROM faculty WHERE faculty_id = ?")->execute([$id]);

        logActivity($db, $admin['id'], 'deleted_faculty', 'faculty', $id,
            "Deleted faculty {$existing['first_name']} {$existing['last_name']} (Employee ID: {$existing['employee_id']})");

        jsonResponse(['message' => 'Faculty member deleted successfully.']);
    }

    jsonError('Not found.', 404);
}

jsonError('Not found.', 404);
