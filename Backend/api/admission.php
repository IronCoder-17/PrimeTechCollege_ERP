<?php
// ============================================================
// PrimeTech College — Admission API
// GET  /api/admission/courses             — list all courses
// GET  /api/admission/fee?course_id=&sem= — fee for course+sem
// GET  /api/admission/fee-structure       — full fee structure for all courses
//                                            (used by Admin Fee Management UI
//                                            and the Admission page, always
//                                            reflects latest DB values)
// PUT  /api/admission/fee-structure/{id}  — Admin: update tuition/exam fee
//                                            for one course+semester row
// POST /api/admission/register            — new student admission
//                                            (accepts transport_required +
//                                            transport_location — see
//                                            "Transportation" section below)
// POST /api/admission/payment             — save payment & create account
//
// ── Transportation (registration-time auto fee assignment) ───
// When a student submits transport_required = "Yes" along with a
// transport_location, the matching ACTIVE row in
// transportation_routes is looked up and its bus_number /
// transport_fee are copied onto the student record — so the total
// fee (course fee + transport fee) and the bus number always match
// whatever the Admin has configured in Transportation Management at
// the moment of registration. See backend/api/transportation.php
// for the Admin CRUD endpoints that manage these routes.
// ============================================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';
require_once __DIR__ . '/../config/telegram.php';
require_once __DIR__ . '/../helpers/telegram_helper.php';

setCORSHeaders();

$method = $_SERVER['REQUEST_METHOD'];
$path   = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$action = $path[0] ?? '';

// ── GET /courses ───────────────────────────────────────────
if ($method === 'GET' && $action === 'courses') {
    $db   = getDB();
    $rows = $db->query("SELECT * FROM courses ORDER BY department, course_name")->fetchAll();
    jsonResponse(['courses' => $rows]);
}

// ── GET /fee ───────────────────────────────────────────────
// Single source of truth for what a student owes for one
// course + semester. Always hits the DB directly — never cached —
// so an Admin fee change is visible on the very next request, with
// no code change or deploy required.
if ($method === 'GET' && $action === 'fee') {
    // Cache-busting: some browsers/proxies cache GET requests. This
    // endpoint must always return the live DB value.
    header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');
    header('Pragma: no-cache');

    $courseId = intval($_GET['course_id'] ?? 0);
    $semester = intval($_GET['semester']  ?? 0);

    if (!$courseId || !$semester) {
        jsonError('course_id and semester are required.', 400);
    }

    $db   = getDB();
    $stmt = $db->prepare(
        "SELECT fs.*, c.course_name, c.course_code
         FROM fee_structure fs
         JOIN courses c ON fs.course_id = c.id
         WHERE fs.course_id = ? AND fs.semester = ?"
    );
    $stmt->execute([$courseId, $semester]);
    $fee = $stmt->fetch();

    // IMPORTANT: never substitute a default/fallback amount here.
    // If no row exists for this course+semester, the frontend must
    // show an explicit "not configured" message, not a fake fee.
    if (!$fee) jsonError('Fee not found for this course and semester.', 404);

    jsonResponse(['fee' => [
        'id'          => (int)$fee['id'],
        'course_id'   => (int)$fee['course_id'],
        'course_name' => $fee['course_name'],
        'course_code' => $fee['course_code'],
        'semester'    => (int)$fee['semester'],
        'tuition_fee' => (float)$fee['tuition_fee'],
        'exam_fee'    => (float)$fee['exam_fee'],
        'total_fee'   => (float)$fee['total_fee'],
        'updated_at'  => $fee['updated_at'] ?? null,
    ]]);
}

// ── GET /fee-structure ──────────────────────────────────────
// Returns every course+semester fee row, grouped by course.
// Used by: Admin Fee Management (College Fees section) and the
// Admission/Registration page (always reflects the latest values
// — no hardcoded fee tables, no code changes needed for updates).
if ($method === 'GET' && $action === 'fee-structure') {
    header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');
    header('Pragma: no-cache');

    $db   = getDB();
    $rows = $db->query(
        "SELECT fs.id, fs.course_id, fs.semester, fs.tuition_fee, fs.exam_fee, fs.total_fee,
                c.course_name, c.course_code, c.total_semesters, c.department, c.level
         FROM fee_structure fs
         JOIN courses c ON fs.course_id = c.id
         ORDER BY c.department, c.course_name, fs.semester"
    )->fetchAll();

    $grouped = [];
    foreach ($rows as $r) {
        $cid = $r['course_id'];
        if (!isset($grouped[$cid])) {
            $grouped[$cid] = [
                'course_id'       => $cid,
                'course_name'     => $r['course_name'],
                'course_code'     => $r['course_code'],
                'department'      => $r['department'],
                'level'           => $r['level'],
                'total_semesters' => $r['total_semesters'],
                'fees'            => [],
            ];
        }
        $grouped[$cid]['fees'][] = [
            'id'          => $r['id'],
            'semester'    => $r['semester'],
            'tuition_fee' => (float)$r['tuition_fee'],
            'exam_fee'    => (float)$r['exam_fee'],
            'total_fee'   => (float)$r['total_fee'],
        ];
    }

    jsonResponse(['courses' => array_values($grouped)]);
}

// ── PUT /fee-structure/{id} ─────────────────────────────────
// Admin only: update tuition_fee and/or exam_fee for a single
// course+semester row. total_fee is a generated column and
// recalculates automatically.
if ($method === 'PUT' && $action === 'fee-structure') {
    $admin = requireAdmin();
    $id    = isset($path[1]) && is_numeric($path[1]) ? (int)$path[1] : null;
    if ($id === null) jsonError('fee_structure id is required.', 400);

    $data = json_decode(file_get_contents('php://input'), true) ?? [];

    $db   = getDB();
    $stmt = $db->prepare("SELECT * FROM fee_structure WHERE id = ?");
    $stmt->execute([$id]);
    $existing = $stmt->fetch();
    if (!$existing) jsonError('Fee structure row not found.', 404);

    $fields = [];
    $values = [];

    if (array_key_exists('tuition_fee', $data)) {
        $tuition = floatval($data['tuition_fee']);
        if ($tuition < 0) jsonError('tuition_fee cannot be negative.', 400);
        $fields[] = 'tuition_fee = ?';
        $values[] = $tuition;
    }
    if (array_key_exists('exam_fee', $data)) {
        $exam = floatval($data['exam_fee']);
        if ($exam < 0) jsonError('exam_fee cannot be negative.', 400);
        $fields[] = 'exam_fee = ?';
        $values[] = $exam;
    }
    if (!$fields) jsonError('No fields to update.', 400);

    // Track who last changed this row (updated_at auto-stamps via the
    // column's ON UPDATE CURRENT_TIMESTAMP) — see
    // schema_fee_structure_sync_fix.sql. This never touches any
    // already-generated receipt: only the live payable amount for
    // future/unpaid semesters changes.
    //
    // Falls back gracefully to plain tuition/exam-only updates on
    // databases that haven't run that migration yet, so this endpoint
    // never breaks an existing deployment.
    try {
        $fieldsWithAudit = $fields;
        $fieldsWithAudit[] = 'updated_by = ?';
        $valuesWithAudit  = $values;
        $valuesWithAudit[] = $admin['id'];
        $valuesWithAudit[] = $id;
        $db->prepare("UPDATE fee_structure SET " . implode(', ', $fieldsWithAudit) . " WHERE id = ?")->execute($valuesWithAudit);
    } catch (\Exception $e) {
        $values[] = $id;
        $db->prepare("UPDATE fee_structure SET " . implode(', ', $fields) . " WHERE id = ?")->execute($values);
    }

    try {
        $stmt = $db->prepare("INSERT INTO admin_activity_log (admin_id, action, target_type, target_id, details) VALUES (?, 'updated_fee', 'fee_structure', ?, ?)");
        $stmt->execute([$admin['id'], $id, "Updated fee structure for course_id={$existing['course_id']} semester={$existing['semester']}: tuition " .
            $existing['tuition_fee'] . " -> " . ($data['tuition_fee'] ?? $existing['tuition_fee']) .
            ", exam " . $existing['exam_fee'] . " -> " . ($data['exam_fee'] ?? $existing['exam_fee'])]);
    } catch (\Exception $e) {}

    $stmt = $db->prepare(
        "SELECT fs.*, c.course_name, c.course_code FROM fee_structure fs JOIN courses c ON fs.course_id = c.id WHERE fs.id = ?"
    );
    $stmt->execute([$id]);
    jsonResponse(['message' => 'Fee structure updated successfully.', 'fee' => $stmt->fetch()]);
}

// ── POST /verify-fee ─────────────────────────────────────────
// Server-side payment validation (Step 12 of the fee-sync fix).
// The frontend must call this immediately before recording any
// semester-fee payment/receipt, sending the course_id + semester +
// the amount it is about to charge. The backend independently
// re-reads fee_structure — the single source of truth — and only
// confirms the payment if the amount matches exactly. This prevents
// a manipulated, cached, or simply stale frontend amount from ever
// being accepted, regardless of what the UI shows.
if ($method === 'POST' && $action === 'verify-fee') {
    requireAuth(); // must be a logged-in student/admin — never anonymous
    header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');

    $data     = json_decode(file_get_contents('php://input'), true) ?? [];
    $courseId = intval($data['course_id'] ?? 0);
    $semester = intval($data['semester']  ?? 0);
    $amount   = isset($data['amount']) ? round(floatval($data['amount']), 2) : null;

    if (!$courseId || !$semester || $amount === null) {
        jsonError('course_id, semester and amount are required.', 400);
    }

    $db   = getDB();
    $stmt = $db->prepare(
        "SELECT fs.*, c.course_name, c.course_code
         FROM fee_structure fs
         JOIN courses c ON fs.course_id = c.id
         WHERE fs.course_id = ? AND fs.semester = ?"
    );
    $stmt->execute([$courseId, $semester]);
    $fee = $stmt->fetch();

    if (!$fee) jsonError('Fee not found for this course and semester.', 404);

    $dbTotal = round((float)$fee['total_fee'], 2);

    if (abs($dbTotal - $amount) > 0.01) {
        // The amount the client tried to charge does not match the
        // current database fee (e.g. Admin changed it in between, or
        // the client sent a manipulated/stale value). Reject and tell
        // the client the correct amount so it can refresh and retry —
        // never silently accept the wrong amount.
        jsonResponse([
            'valid'        => false,
            'message'      => 'The fee amount has changed. Please refresh and try again.',
            'expected_fee' => [
                'course_id'   => (int)$fee['course_id'],
                'semester'    => (int)$fee['semester'],
                'tuition_fee' => (float)$fee['tuition_fee'],
                'exam_fee'    => (float)$fee['exam_fee'],
                'total_fee'   => $dbTotal,
            ],
        ], 409);
    }

    jsonResponse([
        'valid' => true,
        'fee'   => [
            'course_id'   => (int)$fee['course_id'],
            'course_name' => $fee['course_name'],
            'semester'    => (int)$fee['semester'],
            'tuition_fee' => (float)$fee['tuition_fee'],
            'exam_fee'    => (float)$fee['exam_fee'],
            'total_fee'   => $dbTotal,
        ],
    ]);
}

// ── POST /register ─────────────────────────────────────────
if ($method === 'POST' && $action === 'register') {
    $data = json_decode(file_get_contents('php://input'), true);

    $firstName  = sanitize($data['first_name']  ?? '');
    $middleName = sanitize($data['middle_name'] ?? '');
    $lastName   = sanitize($data['last_name']   ?? '');
    $dob        = $data['dob']       ?? '';
    $gender     = $data['gender']    ?? '';
    $phone      = sanitize($data['phone'] ?? '');
    $email      = $data['email']     ?? null;
    $address    = sanitize($data['address']    ?? '');
    $courseId   = intval($data['course_id']   ?? 0);
    $semester   = intval($data['semester']    ?? 0);

    // ── Transportation ──────────────────────────────────────
    // transport_required: "Yes" | "No" (default "No"). When "Yes",
    // transport_location must match an ACTIVE row in
    // transportation_routes — its bus_number and transport_fee are
    // then auto-assigned onto the student record.
    $transportRequired = ($data['transport_required'] ?? 'No') === 'Yes' ? 'Yes' : 'No';
    $transportLocation = sanitize($data['transport_location'] ?? '');

    if (!$firstName || !$lastName || !$dob || !$gender || !$phone || !$courseId || !$semester) {
        jsonError('Required fields missing.', 400);
    }

    $db = getDB();

    // Validate course
    $cStmt = $db->prepare("SELECT * FROM courses WHERE id = ?");
    $cStmt->execute([$courseId]);
    $course = $cStmt->fetch();
    if (!$course) jsonError('Invalid course selected.', 400);

    // Validate transportation route + auto-assign fee/bus number.
    // If Transportation = No: location/bus_number = NULL, fee = 0.
    $busNumber    = null;
    $transportFee = 0;
    if ($transportRequired === 'Yes') {
        if (!$transportLocation) jsonError('Please select a transportation location.', 400);

        $tStmt = $db->prepare(
            "SELECT bus_number, transport_fee FROM transportation_routes WHERE location = ? AND status = 'active'"
        );
        $tStmt->execute([$transportLocation]);
        $route = $tStmt->fetch();
        if (!$route) jsonError('Selected transportation location is not available.', 400);

        $busNumber    = $route['bus_number'];
        $transportFee = (float)$route['transport_fee'];
    } else {
        $transportLocation = null;
    }

    // Insert student (status = pending until payment)
    $stmt = $db->prepare(
        "INSERT INTO students (first_name, middle_name, last_name, dob, gender, phone, email, address, course_id, semester, admission_year, transport_required, transport_location, bus_number, transport_fee)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, YEAR(NOW()), ?, ?, ?, ?)"
    );
    $stmt->execute([$firstName, $middleName, $lastName, $dob, $gender, $phone, $email ?: null, $address, $courseId, $semester, $transportRequired, $transportLocation, $busNumber, $transportFee]);
    $studentId = $db->lastInsertId();

    jsonResponse(['message' => 'Student registered.', 'student_id' => $studentId], 201);
}

// ── POST /payment ──────────────────────────────────────────
if ($method === 'POST' && $action === 'payment') {
    $data = json_decode(file_get_contents('php://input'), true);

    $studentId  = intval($data['student_id']          ?? 0);
    $orderId    = sanitize($data['razorpay_order_id']   ?? '');
    $paymentId  = sanitize($data['razorpay_payment_id'] ?? '');
    $amount     = floatval($data['amount']             ?? 0);

    if (!$studentId || !$orderId || !$paymentId || !$amount) {
        jsonError('Missing payment details.', 400);
    }

    $db = getDB();

    // Fetch student
    $sStmt = $db->prepare(
        "SELECT s.*, c.course_name, c.course_code, c.total_semesters
         FROM students s JOIN courses c ON s.course_id = c.id WHERE s.id = ?"
    );
    $sStmt->execute([$studentId]);
    $student = $sStmt->fetch();
    if (!$student) jsonError('Student not found.', 404);

    // Save payment
    $pStmt = $db->prepare(
        "INSERT INTO payments (student_id, razorpay_order_id, razorpay_payment_id, amount, payment_status)
         VALUES (?, ?, ?, ?, 'success')"
    );
    $pStmt->execute([$studentId, $orderId, $paymentId, $amount]);

    // Generate GR Number: PT + Year + CourseCode + Seq
    $year   = date('Y');
    $code   = strtoupper($student['course_code']);
    $seqStmt = $db->prepare(
        "SELECT COUNT(*) FROM students WHERE course_id = ? AND YEAR(created_at) = ?"
    );
    $seqStmt->execute([$student['course_id'], $year]);
    $seq    = (int)$seqStmt->fetchColumn() + 1;
    $grNum  = "PT{$year}{$code}" . str_pad($seq, 4, '0', STR_PAD_LEFT);

    // Generate student email
    $base    = strtolower($student['first_name'] . '.' . $student['last_name']);
    $base    = preg_replace('/[^a-z.]/', '', $base);
    $emailId = $base . '@primetech.edu';

    // Check uniqueness
    $eStmt = $db->prepare("SELECT COUNT(*) FROM login_credentials WHERE email = ?");
    $eStmt->execute([$emailId]);
    if ((int)$eStmt->fetchColumn() > 0) {
        $i = 1;
        while (true) {
            $candidate = $base . $i . '@primetech.edu';
            $eStmt->execute([$candidate]);
            if ((int)$eStmt->fetchColumn() === 0) { $emailId = $candidate; break; }
            $i++;
        }
    }

    // Generate secure password
    $rawPass = 'PT@' . random_int(100000, 999999);
    $passHash = password_hash($rawPass, PASSWORD_BCRYPT);

    // Update student record
    $db->prepare("UPDATE students SET gr_number = ?, status = 'active' WHERE id = ?")->execute([$grNum, $studentId]);

    // Create login credentials
    $db->prepare(
        "INSERT INTO login_credentials (student_id, email, password_hash) VALUES (?, ?, ?)"
    )->execute([$studentId, $emailId, $passHash]);

    // Also insert into users table for app login
    $fullName = trim($student['first_name'] . ' ' . $student['last_name']);
    $uStmt = $db->prepare(
        "INSERT INTO users (name, email, password_hash, major, year, role)
         VALUES (?, ?, ?, ?, 'Freshman', 'student')"
    );
    $uStmt->execute([$fullName, $emailId, $passHash, $student['course_name']]);

    // ── Telegram: send login credentials to the student ────────────────
    // Does NOT block or alter the admission response — if Telegram is
    // unreachable, unconfigured, or the student hasn't linked their chat
    // yet, sendTelegramMessage() logs the failure and we still return the
    // normal success response below exactly as before.
    try {
        // Prefer a chat_id already saved on the student row (linked via the
        // bot before or after admission); otherwise fall back to a chat_id
        // saved in telegram_chat_links (bot messaged first, admission not
        // done yet) and copy it onto the student record for next time.
        $chatId = $student['telegram_chat_id'] ?? null;
        if (!$chatId) {
            $chatId = findTelegramChatIdByPhone($student['phone']);
            if ($chatId) {
                $db->prepare("UPDATE students SET telegram_chat_id = ? WHERE id = ?")->execute([$chatId, $studentId]);
            }
        }

        if ($chatId) {
            $welcomeMsg = buildStudentWelcomeMessage([
                'name'       => $fullName,
                'enroll_no'  => $grNum,   // this project uses one identifier (gr_number) as both Enroll No and GR No
                'gr_no'      => $grNum,
                'course'     => $student['course_name'],
                'department' => $student['course_code'],
                'email'      => $emailId,
                'password'   => $rawPass,
            ]);
            sendTelegramMessage($chatId, $welcomeMsg);
        } else {
            // Not linked yet — save credentials so the bot can deliver them
            // the moment this student's phone number is linked via Telegram.
            savePendingCredentials($student['phone'], 'student', [
                'name'       => $fullName,
                'enroll_no'  => $grNum,
                'gr_no'      => $grNum,
                'course'     => $student['course_name'],
                'department' => $student['course_code'],
                'email'      => $emailId,
                'password'   => $rawPass,
            ]);
            error_log("[Telegram] No chat_id linked yet for student #$studentId (phone {$student['phone']}) - credentials saved for delivery once linked.");
        }
    } catch (\Throwable $e) {
        error_log('[Telegram] Student welcome message failed: ' . $e->getMessage());
    }

    jsonResponse([
        'message'             => 'Admission successful! Account created.',
        'gr_number'           => $grNum,
        'transport_required'  => $student['transport_required'],
        'transport_location'  => $student['transport_location'],
        'bus_number'          => $student['bus_number'],
        'transport_fee'       => (float)$student['transport_fee'],
        'email'               => $emailId,
        'password'            => $rawPass,
        'student_id'          => $studentId,
    ]);
}

// ── PUT /advance-semester ────────────────────────────────────
// Student-only. Called by the Fee Receipts page the instant the
// NEXT semester's fee payment succeeds, so `students.semester` — the
// real, authoritative value the Timetable and Results modules read
// from — advances together with the fee payment. Without this, only
// the client-side session (localStorage) knew about the new
// semester, so the Timetable kept showing the old one.
if ($method === 'PUT' && $action === 'advance-semester') {
    $user = requireAuth();
    if ($user['role'] !== 'student') jsonError('Only students can advance their own semester.', 403);

    $data = json_decode(file_get_contents('php://input'), true);
    $newSemester = intval($data['semester'] ?? 0);
    if (!$newSemester) jsonError('semester is required.', 400);

    $db = getDB();
    $stmt = $db->prepare(
        "SELECT s.id, s.semester, c.total_semesters
         FROM students s
         JOIN login_credentials lc ON lc.student_id = s.id
         LEFT JOIN courses c ON c.id = s.course_id
         WHERE lc.email = ?"
    );
    $stmt->execute([$user['email']]);
    $student = $stmt->fetch();
    if (!$student) jsonError('Student record not found for this account.', 404);

    // Only allow moving forward exactly one semester at a time, and
    // never past the course's total semester count — guards against a
    // stale or duplicate request corrupting the record.
    if ($newSemester !== (int)$student['semester'] + 1) {
        jsonError('Invalid semester transition.', 400);
    }
    if ($student['total_semesters'] && $newSemester > (int)$student['total_semesters']) {
        jsonError('This course has no further semesters.', 400);
    }

    $db->prepare("UPDATE students SET semester = ? WHERE id = ?")->execute([$newSemester, $student['id']]);

    jsonResponse(['success' => true, 'semester' => $newSemester]);
}

jsonError('Not found.', 404);