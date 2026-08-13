<?php
// ============================================================
// College Campus Connect — Predefined Timetable API
//
// Every course + semester ships with a complete predefined
// (default) timetable, seeded via database/seed_timetable.sql.
// `timetable_slots` is the single, live source of truth — there
// is no separate "override" table, so whenever the Admin edits a
// slot the change is instantly what students/faculty see too.
//
// ── Public / any authenticated role ────────────────────────────
// GET  /api/timetable.php/periods
//      Fixed daily period timings (incl. tea/lunch breaks).
// GET  /api/timetable.php/courses
//      Course list (id, name, code, department, total_semesters) —
//      convenience passthrough so the Admin timetable UI doesn't
//      need a second endpoint.
// GET  /api/timetable.php/grid?course_id=&semester=
//      Full weekly grid (Mon-Sat x Period1-6) for one course+semester,
//      with subject/faculty/classroom names resolved.
// GET  /api/timetable.php/my
//      Student → own course/semester grid.
//      Faculty → own weekly lecture schedule (across all courses).
//
// ── Admin only ─────────────────────────────────────────────────
// GET    /api/timetable.php/search?course_id=&semester=&faculty_id=&classroom_id=&department=
//        Flat, filterable list of slots — powers Admin search/filter UI.
// GET    /api/timetable.php/subjects?course_id=&semester=
//        Subject list for a course+semester (dropdown source).
// POST   /api/timetable.php/subjects
//        Add a new subject to a course+semester.
// GET    /api/timetable.php/classrooms
// GET    /api/timetable.php/faculty-list
//        Dropdown sources for Admin editing.
// PUT    /api/timetable.php/slot/{id}
//        Edit one lecture (subject/faculty/classroom/day/time).
// POST   /api/timetable.php/slot
//        Create a new lecture slot.
// DELETE /api/timetable.php/slot/{id}
//        Clear/delete a lecture.
// POST   /api/timetable.php/replace
//        Replace the ENTIRE timetable for one course+semester in
//        one call (bulk save from the Admin grid editor / "create a
//        completely new timetable").
// GET    /api/timetable.php/export?course_id=&semester=&format=csv|pdf
//        Export the timetable (CSV is Excel-openable; PDF returns a
//        print-ready HTML page the browser can "Save as PDF").
//
// All Admin writes stamp is_predefined = 0 and updated_by, so the UI
// can visually flag "customized" vs "default" slots without needing
// a second table.
// ============================================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method   = $_SERVER['REQUEST_METHOD'];
$path     = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$resource = $path[0] ?? '';
$db       = getDB();

const DAYS = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];

// Some deployments of this project don't have the `faculty` table
// installed. Every query below that would otherwise LEFT JOIN faculty
// checks this first and gracefully falls back to the display name
// already stored on tt_subjects (faculty_name) instead of hard-failing.
function ttFacultyTableExists($db) {
    static $exists = null;
    if ($exists === null) {
        try {
            $db->query("SELECT 1 FROM faculty LIMIT 1");
            $exists = true;
        } catch (Throwable $e) {
            $exists = false;
        }
    }
    return $exists;
}

// ── helpers ──────────────────────────────────────────────────
function ttLogActivity($db, $adminName, $action, $details) {
    try {
        $stmt = $db->prepare(
            "INSERT INTO admin_activity_log (admin_id, action, target_type, target_id, details, created_at)
             VALUES (NULL, ?, 'timetable', 0, ?, NOW())"
        );
        $stmt->execute([$action, $details . ' (by ' . $adminName . ')']);
    } catch (Throwable $e) {
        // Activity logging must never break the main request.
    }
}

// Resolve the `students` row (+ course info) for the logged-in student.
function ttGetStudentForUser($db, $user) {
    $stmt = $db->prepare(
        "SELECT s.id, s.course_id, s.semester, c.course_name, c.course_code, c.department
         FROM students s
         JOIN login_credentials lc ON lc.student_id = s.id
         LEFT JOIN courses c ON c.id = s.course_id
         WHERE lc.email = ?"
    );
    $stmt->execute([$user['email']]);
    $row = $stmt->fetch();
    if (!$row) jsonError('Student record not found for this account.', 404);
    return $row;
}

// Resolve the `faculty` table primary key for the logged-in faculty user.
function ttGetFacultyPkForUser($db, $user) {
    if (!ttFacultyTableExists($db)) {
        jsonError('Faculty module is not installed on this server.', 404);
    }
    $stmt = $db->prepare("SELECT faculty_id, CONCAT(first_name,' ',last_name) AS name FROM faculty WHERE email = ?");
    $stmt->execute([$user['email']]);
    $row = $stmt->fetch();
    if (!$row) jsonError('Faculty record not found for this account.', 404);
    return $row;
}

// Build the full week grid (6 days x fixed periods) for a course+semester,
// filling in whichever slots exist and leaving the rest blank.
function ttBuildGrid($db, $courseId, $semester) {
    $periodsStmt = $db->query("SELECT * FROM timetable_periods ORDER BY period_no");
    $allPeriods  = $periodsStmt->fetchAll();

    $hasFaculty = ttFacultyTableExists($db);
    $facultySelect = $hasFaculty
        ? "COALESCE(fac.faculty_id, sub.faculty_id) AS faculty_id,
           COALESCE(CONCAT(fac.first_name,' ',fac.last_name), sub.faculty_name) AS faculty_name,"
        : "sub.faculty_id AS faculty_id,
           sub.faculty_name AS faculty_name,";
    $facultyJoin = $hasFaculty ? "LEFT JOIN faculty fac ON fac.faculty_id = ts.faculty_id" : "";

    $stmt = $db->prepare(
        "SELECT ts.id, ts.day_of_week, ts.period_no, ts.start_time, ts.end_time,
                ts.is_predefined, ts.updated_at,
                sub.id AS subject_id, sub.subject_code, sub.subject_name,
                $facultySelect
                cr.id AS classroom_id, cr.room_code
         FROM timetable_slots ts
         LEFT JOIN tt_subjects sub ON sub.id = ts.subject_id
         $facultyJoin
         LEFT JOIN classrooms cr ON cr.id = ts.classroom_id
         WHERE ts.course_id = ? AND ts.semester = ?"
    );
    $stmt->execute([$courseId, $semester]);
    $slots = $stmt->fetchAll();

    $byDayPeriod = [];
    foreach ($slots as $s) {
        $byDayPeriod[$s['day_of_week']][$s['period_no']] = $s;
    }

    $grid = [];
    foreach (DAYS as $day) {
        $row = ['day' => $day, 'periods' => []];
        foreach ($allPeriods as $p) {
            if ((int)$p['is_break'] === 1) {
                $row['periods'][] = [
                    'period_no' => (int)$p['period_no'], 'label' => $p['label'],
                    'start_time' => $p['start_time'], 'end_time' => $p['end_time'],
                    'is_break' => true,
                ];
                continue;
            }
            $slot = $byDayPeriod[$day][(int)$p['period_no']] ?? null;
            $row['periods'][] = [
                'slot_id'      => $slot['id'] ?? null,
                'period_no'    => (int)$p['period_no'],
                'label'        => $p['label'],
                'start_time'   => $slot['start_time'] ?? $p['start_time'],
                'end_time'     => $slot['end_time'] ?? $p['end_time'],
                'is_break'     => false,
                'subject_id'   => $slot['subject_id'] ?? null,
                'subject_code' => $slot['subject_code'] ?? null,
                'subject_name' => $slot['subject_name'] ?? null,
                'faculty_id'   => $slot['faculty_id'] ?? null,
                'faculty_name' => $slot['faculty_name'] ?? null,
                'classroom_id' => $slot['classroom_id'] ?? null,
                'room_code'    => $slot['room_code'] ?? null,
                'is_predefined' => $slot ? (bool)$slot['is_predefined'] : true,
                'updated_at'   => $slot['updated_at'] ?? null,
            ];
        }
        $grid[] = $row;
    }
    return $grid;
}

// ============================================================
// GET /timetable.php/periods  (public reference data)
// ============================================================
if ($resource === 'periods' && $method === 'GET') {
    $rows = $db->query("SELECT * FROM timetable_periods ORDER BY period_no")->fetchAll();
    jsonResponse(['success' => true, 'periods' => $rows]);
}

// ============================================================
// GET /timetable.php/courses  (passthrough convenience list)
// ============================================================
if ($resource === 'courses' && $method === 'GET') {
    requireAuth();
    $rows = $db->query("SELECT id, course_name, course_code, department, level, total_semesters FROM courses ORDER BY department, course_name")->fetchAll();
    jsonResponse(['success' => true, 'courses' => $rows]);
}

// ============================================================
// GET /timetable.php/grid?course_id=&semester=
// ============================================================
if ($resource === 'grid' && $method === 'GET') {
    requireAuth();
    $courseId = (int)($_GET['course_id'] ?? 0);
    $semester = (int)($_GET['semester'] ?? 0);
    if (!$courseId || !$semester) jsonError('course_id and semester are required.');

    $courseStmt = $db->prepare("SELECT id, course_name, course_code, department, total_semesters FROM courses WHERE id = ?");
    $courseStmt->execute([$courseId]);
    $course = $courseStmt->fetch();
    if (!$course) jsonError('Course not found.', 404);

    jsonResponse([
        'success' => true,
        'course'  => $course,
        'semester' => $semester,
        'grid'    => ttBuildGrid($db, $courseId, $semester),
    ]);
}

// ============================================================
// GET /timetable.php/my
// ============================================================
if ($resource === 'my' && $method === 'GET') {
    $user = requireAuth();

    if ($user['role'] === 'student') {
        $student = ttGetStudentForUser($db, $user);
        if (!$student['course_id'] || !$student['semester']) {
            jsonError('No course/semester on file for this student yet.', 404);
        }
        jsonResponse([
            'success'  => true,
            'course'   => [
                'id' => $student['course_id'], 'course_name' => $student['course_name'],
                'course_code' => $student['course_code'], 'department' => $student['department'],
            ],
            'semester' => (int)$student['semester'],
            'grid'     => ttBuildGrid($db, $student['course_id'], $student['semester']),
        ]);
    }

    if ($user['role'] === 'faculty') {
        $fac = ttGetFacultyPkForUser($db, $user);
        $stmt = $db->prepare(
            "SELECT ts.day_of_week, ts.period_no, ts.start_time, ts.end_time,
                    c.course_name, c.course_code, ts.semester,
                    sub.subject_name, sub.subject_code,
                    cr.room_code
             FROM timetable_slots ts
             JOIN courses c ON c.id = ts.course_id
             LEFT JOIN tt_subjects sub ON sub.id = ts.subject_id
             LEFT JOIN classrooms cr ON cr.id = ts.classroom_id
             WHERE ts.faculty_id = ?
                OR ts.subject_id IN (SELECT id FROM tt_subjects WHERE faculty_id = ?)
             ORDER BY FIELD(ts.day_of_week,'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'), ts.period_no"
        );
        $stmt->execute([$fac['faculty_id'], $fac['faculty_id']]);
        $rows = $stmt->fetchAll();

        $byDay = [];
        foreach (DAYS as $d) $byDay[$d] = [];
        foreach ($rows as $r) $byDay[$r['day_of_week']][] = $r;

        jsonResponse(['success' => true, 'faculty_name' => $fac['name'], 'weekly_schedule' => $byDay]);
    }

    jsonError('This endpoint is only for students and faculty. Admin should use /grid.', 403);
}

// ── Everything below is Admin-only ──────────────────────────
$admin = requireAdmin();
$adminName = $admin['name'] ?? 'Administrator';

// ============================================================
// GET /timetable.php/search  (filterable flat list)
// ============================================================
if ($resource === 'search' && $method === 'GET') {
    $where = ['1=1'];
    $params = [];

    if (!empty($_GET['course_id'])) { $where[] = 'ts.course_id = ?'; $params[] = (int)$_GET['course_id']; }
    if (!empty($_GET['semester'])) { $where[] = 'ts.semester = ?'; $params[] = (int)$_GET['semester']; }
    if (!empty($_GET['faculty_id'])) { $where[] = '(ts.faculty_id = ? OR sub.faculty_id = ?)'; $params[] = (int)$_GET['faculty_id']; $params[] = (int)$_GET['faculty_id']; }
    if (!empty($_GET['classroom_id'])) { $where[] = 'ts.classroom_id = ?'; $params[] = (int)$_GET['classroom_id']; }
    if (!empty($_GET['department'])) { $where[] = 'c.department = ?'; $params[] = $_GET['department']; }
    if (!empty($_GET['day'])) { $where[] = 'ts.day_of_week = ?'; $params[] = $_GET['day']; }

    $hasFaculty = ttFacultyTableExists($db);
    $facultySelect = $hasFaculty
        ? "COALESCE(fac.faculty_id, sub.faculty_id) AS faculty_id,
           COALESCE(CONCAT(fac.first_name,' ',fac.last_name), sub.faculty_name) AS faculty_name,"
        : "sub.faculty_id AS faculty_id,
           sub.faculty_name AS faculty_name,";
    $facultyJoin = $hasFaculty ? "LEFT JOIN faculty fac ON fac.faculty_id = ts.faculty_id" : "";

    $sql = "SELECT ts.id, ts.course_id, c.course_name, c.department, ts.semester,
                   ts.day_of_week, ts.period_no, ts.start_time, ts.end_time,
                   sub.subject_name, sub.subject_code,
                   $facultySelect
                   cr.room_code, ts.is_predefined
            FROM timetable_slots ts
            JOIN courses c ON c.id = ts.course_id
            LEFT JOIN tt_subjects sub ON sub.id = ts.subject_id
            $facultyJoin
            LEFT JOIN classrooms cr ON cr.id = ts.classroom_id
            WHERE " . implode(' AND ', $where) . "
            ORDER BY c.course_name, ts.semester, FIELD(ts.day_of_week,'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'), ts.period_no
            LIMIT 1000";
    $stmt = $db->prepare($sql);
    $stmt->execute($params);
    jsonResponse(['success' => true, 'results' => $stmt->fetchAll()]);
}

// ============================================================
// GET/POST /timetable.php/subjects
// ============================================================
if ($resource === 'subjects') {
    if ($method === 'GET') {
        $courseId = (int)($_GET['course_id'] ?? 0);
        $semester = (int)($_GET['semester'] ?? 0);
        $sql = "SELECT id, course_id, semester, subject_code, subject_name, faculty_id, faculty_name, credits FROM tt_subjects WHERE 1=1";
        $params = [];
        if ($courseId) { $sql .= " AND course_id = ?"; $params[] = $courseId; }
        if ($semester) { $sql .= " AND semester = ?"; $params[] = $semester; }
        $sql .= " ORDER BY subject_name";
        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        jsonResponse(['success' => true, 'subjects' => $stmt->fetchAll()]);
    }
    if ($method === 'POST') {
        $data = json_decode(file_get_contents('php://input'), true);
        $courseId = (int)($data['course_id'] ?? 0);
        $semester = (int)($data['semester'] ?? 0);
        $name     = sanitize($data['subject_name'] ?? '');
        $code     = sanitize($data['subject_code'] ?? '');
        $facId    = !empty($data['faculty_id']) ? (int)$data['faculty_id'] : null;
        $facName  = sanitize($data['faculty_name'] ?? '');
        $credits  = (int)($data['credits'] ?? 3);
        if (!$courseId || !$semester || !$name) jsonError('course_id, semester and subject_name are required.');
        if (!$code) $code = 'SUB' . strtoupper(substr(md5($name . microtime()), 0, 8));

        if ($facId && !$facName && ttFacultyTableExists($db)) {
            $f = $db->prepare("SELECT CONCAT(first_name,' ',last_name) AS n FROM faculty WHERE faculty_id = ?");
            $f->execute([$facId]);
            $facName = $f->fetchColumn() ?: null;
        }

        $stmt = $db->prepare(
            "INSERT INTO tt_subjects (course_id, semester, subject_code, subject_name, faculty_id, faculty_name, credits)
             VALUES (?,?,?,?,?,?,?)"
        );
        $stmt->execute([$courseId, $semester, $code, $name, $facId, $facName ?: null, $credits]);
        ttLogActivity($db, $adminName, 'timetable_subject_add', "Added subject '$name' ($code)");
        jsonResponse(['success' => true, 'id' => $db->lastInsertId()], 201);
    }
}

// ============================================================
// GET /timetable.php/classrooms
// ============================================================
if ($resource === 'classrooms' && $method === 'GET') {
    $rows = $db->query("SELECT id, room_code, department, capacity FROM classrooms ORDER BY room_code")->fetchAll();
    jsonResponse(['success' => true, 'classrooms' => $rows]);
}

// ============================================================
// GET /timetable.php/faculty-list
// ============================================================
if ($resource === 'faculty-list' && $method === 'GET') {
    if (!ttFacultyTableExists($db)) {
        jsonResponse(['success' => true, 'faculty' => []]);
    }
    $rows = $db->query("SELECT faculty_id, CONCAT(first_name,' ',last_name) AS name, department, designation FROM faculty ORDER BY first_name")->fetchAll();
    jsonResponse(['success' => true, 'faculty' => $rows]);
}

// ============================================================
// POST /timetable.php/slot   (create)
// PUT  /timetable.php/slot/{id}   (edit)
// DELETE /timetable.php/slot/{id} (clear/remove)
// ============================================================
if ($resource === 'slot') {
    $id = isset($path[1]) ? (int)$path[1] : null;

    if ($method === 'POST') {
        $data = json_decode(file_get_contents('php://input'), true);
        $courseId = (int)($data['course_id'] ?? 0);
        $semester = (int)($data['semester'] ?? 0);
        $day      = $data['day_of_week'] ?? '';
        $periodNo = (int)($data['period_no'] ?? 0);
        if (!$courseId || !$semester || !in_array($day, DAYS, true) || !$periodNo) {
            jsonError('course_id, semester, day_of_week and period_no are required.');
        }

        $pStmt = $db->prepare("SELECT start_time, end_time FROM timetable_periods WHERE period_no = ? AND is_break = 0");
        $pStmt->execute([$periodNo]);
        $period = $pStmt->fetch();
        if (!$period) jsonError('Invalid period_no.');

        $subjectId   = !empty($data['subject_id']) ? (int)$data['subject_id'] : null;
        $classroomId = !empty($data['classroom_id']) ? (int)$data['classroom_id'] : null;
        $facultyId   = !empty($data['faculty_id']) ? (int)$data['faculty_id'] : null;

        $stmt = $db->prepare(
            "INSERT INTO timetable_slots
                (course_id, semester, day_of_week, period_no, start_time, end_time, subject_id, classroom_id, faculty_id, is_predefined, updated_by)
             VALUES (?,?,?,?,?,?,?,?,?,0,?)
             ON DUPLICATE KEY UPDATE
                subject_id = VALUES(subject_id), classroom_id = VALUES(classroom_id),
                faculty_id = VALUES(faculty_id), is_predefined = 0, updated_by = VALUES(updated_by)"
        );
        $stmt->execute([$courseId, $semester, $day, $periodNo, $period['start_time'], $period['end_time'], $subjectId, $classroomId, $facultyId, $adminName]);
        ttLogActivity($db, $adminName, 'timetable_slot_create', "Created/updated slot for course #$courseId sem $semester ($day, period $periodNo)");
        jsonResponse(['success' => true], 201);
    }

    if ($method === 'PUT') {
        if (!$id) jsonError('Slot id is required.');
        $data = json_decode(file_get_contents('php://input'), true);

        $fields = [];
        $params = [];
        foreach ([
            'subject_id' => 'subject_id', 'classroom_id' => 'classroom_id', 'faculty_id' => 'faculty_id',
        ] as $k => $col) {
            if (array_key_exists($k, $data)) {
                $fields[] = "$col = ?";
                $params[] = $data[$k] !== null && $data[$k] !== '' ? (int)$data[$k] : null;
            }
        }
        if (!empty($data['day_of_week'])) {
            if (!in_array($data['day_of_week'], DAYS, true)) jsonError('Invalid day_of_week.');
            $fields[] = "day_of_week = ?";
            $params[] = $data['day_of_week'];
        }
        if (!empty($data['period_no'])) {
            $pStmt = $db->prepare("SELECT start_time, end_time FROM timetable_periods WHERE period_no = ? AND is_break = 0");
            $pStmt->execute([(int)$data['period_no']]);
            $period = $pStmt->fetch();
            if (!$period) jsonError('Invalid period_no.');
            $fields[] = "period_no = ?"; $params[] = (int)$data['period_no'];
            $fields[] = "start_time = ?"; $params[] = $period['start_time'];
            $fields[] = "end_time = ?"; $params[] = $period['end_time'];
        }
        if (!$fields) jsonError('No fields to update.');

        $fields[] = "is_predefined = 0";
        $fields[] = "updated_by = ?";
        $params[] = $adminName;
        $params[] = $id;

        $sql = "UPDATE timetable_slots SET " . implode(', ', $fields) . " WHERE id = ?";
        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        if ($stmt->rowCount() === 0) {
            $check = $db->prepare("SELECT id FROM timetable_slots WHERE id = ?");
            $check->execute([$id]);
            if (!$check->fetch()) jsonError('Slot not found.', 404);
        }
        ttLogActivity($db, $adminName, 'timetable_slot_edit', "Edited timetable slot #$id");
        jsonResponse(['success' => true]);
    }

    if ($method === 'DELETE') {
        if (!$id) jsonError('Slot id is required.');
        $stmt = $db->prepare("DELETE FROM timetable_slots WHERE id = ?");
        $stmt->execute([$id]);
        if ($stmt->rowCount() === 0) jsonError('Slot not found.', 404);
        ttLogActivity($db, $adminName, 'timetable_slot_delete', "Deleted timetable slot #$id");
        jsonResponse(['success' => true]);
    }
}

// ============================================================
// POST /timetable.php/replace
// Bulk-replace the whole grid for one course+semester.
// Body: { course_id, semester, slots: [{day_of_week, period_no, subject_id?, classroom_id?, faculty_id?}, ...] }
// Any period not present in `slots` is cleared.
// ============================================================
if ($resource === 'replace' && $method === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $courseId = (int)($data['course_id'] ?? 0);
    $semester = (int)($data['semester'] ?? 0);
    $slots    = $data['slots'] ?? [];
    if (!$courseId || !$semester || !is_array($slots)) {
        jsonError('course_id, semester and slots[] are required.');
    }

    $periodsStmt = $db->query("SELECT period_no, start_time, end_time FROM timetable_periods WHERE is_break = 0");
    $periodTimes = [];
    foreach ($periodsStmt->fetchAll() as $p) $periodTimes[(int)$p['period_no']] = $p;

    $db->beginTransaction();
    try {
        $del = $db->prepare("DELETE FROM timetable_slots WHERE course_id = ? AND semester = ?");
        $del->execute([$courseId, $semester]);

        $ins = $db->prepare(
            "INSERT INTO timetable_slots
                (course_id, semester, day_of_week, period_no, start_time, end_time, subject_id, classroom_id, faculty_id, is_predefined, updated_by)
             VALUES (?,?,?,?,?,?,?,?,?,0,?)"
        );
        foreach ($slots as $s) {
            $day = $s['day_of_week'] ?? '';
            $pno = (int)($s['period_no'] ?? 0);
            if (!in_array($day, DAYS, true) || !isset($periodTimes[$pno])) continue;
            if (empty($s['subject_id']) && empty($s['classroom_id']) && empty($s['faculty_id'])) continue; // skip empty cells

            $pt = $periodTimes[$pno];
            $ins->execute([
                $courseId, $semester, $day, $pno, $pt['start_time'], $pt['end_time'],
                !empty($s['subject_id']) ? (int)$s['subject_id'] : null,
                !empty($s['classroom_id']) ? (int)$s['classroom_id'] : null,
                !empty($s['faculty_id']) ? (int)$s['faculty_id'] : null,
                $adminName,
            ]);
        }
        $db->commit();
    } catch (Throwable $e) {
        $db->rollBack();
        jsonError('Failed to replace timetable: ' . $e->getMessage(), 500);
    }

    ttLogActivity($db, $adminName, 'timetable_replace', "Replaced full timetable for course #$courseId semester $semester");
    jsonResponse(['success' => true, 'grid' => ttBuildGrid($db, $courseId, $semester)]);
}

// ============================================================
// GET /timetable.php/export?course_id=&semester=&format=csv|pdf
// ============================================================
if ($resource === 'export' && $method === 'GET') {
    $courseId = (int)($_GET['course_id'] ?? 0);
    $semester = (int)($_GET['semester'] ?? 0);
    $format   = $_GET['format'] ?? 'csv';
    if (!$courseId || !$semester) jsonError('course_id and semester are required.');

    $courseStmt = $db->prepare("SELECT course_name, course_code FROM courses WHERE id = ?");
    $courseStmt->execute([$courseId]);
    $course = $courseStmt->fetch();
    if (!$course) jsonError('Course not found.', 404);

    $grid = ttBuildGrid($db, $courseId, $semester);

    if ($format === 'pdf') {
        header('Content-Type: text/html; charset=utf-8');
        echo "<html><head><title>Timetable</title><style>
            body{font-family:Arial,sans-serif;} table{border-collapse:collapse;width:100%;}
            td,th{border:1px solid #999;padding:6px;font-size:12px;text-align:center;}
            th{background:#eee;} .brk{background:#f5f0e6;color:#888;}
            @media print{ .noprint{display:none;} }
        </style></head><body onload=\"window.print()\">";
        echo "<h2>" . htmlspecialchars($course['course_name']) . " — Semester $semester Timetable</h2>";
        echo "<table><tr><th>Day</th>";
        foreach ($grid[0]['periods'] as $p) echo "<th>" . htmlspecialchars($p['label']) . "<br>" . $p['start_time'] . "-" . $p['end_time'] . "</th>";
        echo "</tr>";
        foreach ($grid as $row) {
            echo "<tr><td><b>" . $row['day'] . "</b></td>";
            foreach ($row['periods'] as $p) {
                if ($p['is_break']) { echo "<td class='brk'>Break</td>"; continue; }
                $label = $p['subject_name'] ? htmlspecialchars($p['subject_name']) . "<br><small>" . htmlspecialchars($p['faculty_name'] ?? '') . " · " . htmlspecialchars($p['room_code'] ?? '') . "</small>" : '-';
                echo "<td>$label</td>";
            }
            echo "</tr>";
        }
        echo "</table></body></html>";
        exit();
    }

    // CSV (Excel-compatible)
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="timetable_' . $course['course_code'] . '_sem' . $semester . '.csv"');
    $out = fopen('php://output', 'w');
    $header = ['Day'];
    foreach ($grid[0]['periods'] as $p) $header[] = $p['is_break'] ? $p['label'] : ($p['label'] . ' (' . $p['start_time'] . '-' . $p['end_time'] . ')');
    fputcsv($out, $header);
    foreach ($grid as $row) {
        $line = [$row['day']];
        foreach ($row['periods'] as $p) {
            if ($p['is_break']) { $line[] = 'Break'; continue; }
            $line[] = $p['subject_name'] ? ($p['subject_name'] . ' | ' . ($p['faculty_name'] ?? '') . ' | ' . ($p['room_code'] ?? '')) : '';
        }
        fputcsv($out, $line);
    }
    fclose($out);
    exit();
}

jsonError('Not found.', 404);