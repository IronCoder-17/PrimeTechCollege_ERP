<?php
// ============================================================
// College Campus Connect — Faculty ⇄ Student Messaging API
//
// Auto-assignment rule (server-enforced on every request):
//   student.course_id + student.semester
//     → tt_subjects (rows for that course_id + semester)
//     → tt_subjects.faculty_id  (the ONLY faculty a student may message,
//                                 one entry per subject taught to them)
//
// A student can never see or message a faculty member who isn't
// actually teaching one of their current semester's subjects. A
// faculty member can never see or message a student who isn't
// enrolled in the course + semester of a subject assigned to them.
// All ids used to read/write messages are re-derived from the
// authenticated session (email → students/faculty row) — nothing
// sent by the frontend (student_id, faculty_id, subject_id in a
// request body) is ever trusted without being checked against the
// database first.
//
// Endpoints (all require a logged-in student or faculty session):
//   GET  /api/messages.php/contacts
//        Student → list of assigned faculty (one row per subject).
//        Faculty → list of assigned students (one row per subject).
//   GET  /api/messages.php/conversation?subject_id=&with_id=
//        Full message history for one thread. Marks the other
//        party's messages as read for the caller.
//   POST /api/messages.php/send
//        Body: { subject_id, with_id, message }
//        with_id = faculty_id when sender is a student,
//                  student_id when sender is a faculty member.
//   GET  /api/messages.php/unread-count
//        Total unread messages for the badge in the nav bar.
// ============================================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method   = $_SERVER['REQUEST_METHOD'];
$path     = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$resource = $path[0] ?? '';
$db       = getDB();

// ── Resolve the students row for the logged-in student (same pattern
//    used by timetable.php / results.php: real DB identity keyed off
//    the session email, never the raw client-supplied id). ──────────
function msgGetStudent($db, $user) {
    $stmt = $db->prepare(
        "SELECT s.id, s.course_id, s.semester,
                CONCAT(s.first_name, ' ', s.last_name) AS name,
                c.course_name, c.course_code
         FROM students s
         JOIN login_credentials lc ON lc.student_id = s.id
         LEFT JOIN courses c ON c.id = s.course_id
         WHERE lc.email = ?"
    );
    $stmt->execute([$user['email']]);
    $row = $stmt->fetch();
    if (!$row) jsonError('Student record not found for this account.', 404);
    if (!$row['course_id'] || !$row['semester']) {
        jsonError('No course/semester on file for this student yet.', 404);
    }
    return $row;
}

// ── Resolve the faculty row for the logged-in faculty member. ───────
function msgGetFaculty($db, $user) {
    $stmt = $db->prepare(
        "SELECT faculty_id, CONCAT(first_name, ' ', last_name) AS name, department, designation, specialization
         FROM faculty WHERE email = ?"
    );
    $stmt->execute([$user['email']]);
    $row = $stmt->fetch();
    if (!$row) jsonError('Faculty record not found for this account.', 404);
    return $row;
}

// Does faculty_documents.profile_photo exist / any row for this faculty?
function msgFacultyPhoto($db, $facultyId) {
    static $hasTable = null;
    if ($hasTable === null) {
        try { $db->query("SELECT 1 FROM faculty_documents LIMIT 1"); $hasTable = true; }
        catch (Throwable $e) { $hasTable = false; }
    }
    if (!$hasTable) return null;
    $stmt = $db->prepare("SELECT profile_photo FROM faculty_documents WHERE faculty_id = ? ORDER BY doc_id DESC LIMIT 1");
    $stmt->execute([$facultyId]);
    $photo = $stmt->fetchColumn();
    return $photo ?: null;
}

// Does students.profile_photo exist?
function msgStudentsHavePhotoColumn($db) {
    static $has = null;
    if ($has === null) {
        try {
            $stmt = $db->prepare(
                "SELECT COUNT(*) FROM information_schema.COLUMNS
                 WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'students' AND COLUMN_NAME = 'profile_photo'"
            );
            $stmt->execute();
            $has = (int)$stmt->fetchColumn() > 0;
        } catch (Throwable $e) { $has = false; }
    }
    return $has;
}

// Get-or-create the conversation row for (student, faculty, subject),
// after independently re-validating that this triple is a real,
// currently-valid assignment. Returns the conversation row (array).
function msgGetOrCreateConversation($db, $studentId, $facultyId, $subjectId, $courseId, $semester) {
    $stmt = $db->prepare(
        "SELECT * FROM faculty_conversations WHERE student_id = ? AND faculty_id = ? AND subject_id = ?"
    );
    $stmt->execute([$studentId, $facultyId, $subjectId]);
    $conv = $stmt->fetch();
    if ($conv) return $conv;

    $ins = $db->prepare(
        "INSERT INTO faculty_conversations (student_id, faculty_id, subject_id, course_id, semester)
         VALUES (?, ?, ?, ?, ?)"
    );
    $ins->execute([$studentId, $facultyId, $subjectId, $courseId, $semester]);
    $convId = $db->lastInsertId();

    $stmt2 = $db->prepare("SELECT * FROM faculty_conversations WHERE id = ?");
    $stmt2->execute([$convId]);
    return $stmt2->fetch();
}

// Validate that `subjectId` is actually assigned to `facultyId` AND
// belongs to `courseId` + `semester`. Returns the tt_subjects row or
// calls jsonError(403) if the assignment doesn't hold — this is the
// single choke point that enforces "students/faculty can only message
// who they're actually assigned to" for every read and write below.
function msgValidateAssignment($db, $courseId, $semester, $subjectId, $facultyId) {
    $stmt = $db->prepare(
        "SELECT * FROM tt_subjects WHERE id = ? AND course_id = ? AND semester = ? AND faculty_id = ?"
    );
    $stmt->execute([$subjectId, $courseId, $semester, $facultyId]);
    $row = $stmt->fetch();
    if (!$row) {
        jsonError('This subject is not assigned to that faculty member for your course/semester.', 403);
    }
    return $row;
}

// ============================================================
// GET /messages.php/contacts
// ============================================================
if ($resource === 'contacts' && $method === 'GET') {
    $user = requireRole(['student', 'faculty']);

    if ($user['role'] === 'student') {
        $student = msgGetStudent($db, $user);

        $stmt = $db->prepare(
            "SELECT ts.id AS subject_id, ts.subject_code, ts.subject_name,
                    f.faculty_id, CONCAT(f.first_name, ' ', f.last_name) AS faculty_name,
                    f.department, f.designation,
                    fc.id AS conversation_id, fc.last_message, fc.last_message_at,
                    fc.last_sender_role, fc.student_unread AS unread_count
             FROM tt_subjects ts
             JOIN faculty f ON f.faculty_id = ts.faculty_id
             LEFT JOIN faculty_conversations fc
                    ON fc.student_id = ? AND fc.faculty_id = f.faculty_id AND fc.subject_id = ts.id
             WHERE ts.course_id = ? AND ts.semester = ? AND ts.faculty_id IS NOT NULL
             ORDER BY (fc.last_message_at IS NULL), fc.last_message_at DESC, ts.subject_name ASC"
        );
        $stmt->execute([$student['id'], $student['course_id'], $student['semester']]);
        $rows = $stmt->fetchAll();

        foreach ($rows as &$r) {
            $r['faculty_id']   = (int)$r['faculty_id'];
            $r['subject_id']   = (int)$r['subject_id'];
            $r['unread_count'] = (int)($r['unread_count'] ?? 0);
            $r['photo']        = msgFacultyPhoto($db, $r['faculty_id']);
        }
        unset($r);

        jsonResponse([
            'success' => true,
            'role'    => 'student',
            'course'  => ['id' => $student['course_id'], 'name' => $student['course_name'], 'code' => $student['course_code']],
            'semester' => (int)$student['semester'],
            'contacts' => $rows,
        ]);
    }

    // faculty
    $fac = msgGetFaculty($db, $user);
    $hasPhotoCol = msgStudentsHavePhotoColumn($db);
    $photoSql = $hasPhotoCol ? 's.profile_photo,' : 'NULL AS profile_photo,';

    $stmt = $db->prepare(
        "SELECT ts.id AS subject_id, ts.subject_code, ts.subject_name,
                s.id AS student_id, CONCAT(s.first_name, ' ', s.last_name) AS student_name,
                s.gr_number, c.course_name, c.course_code, s.semester,
                $photoSql
                fc.id AS conversation_id, fc.last_message, fc.last_message_at,
                fc.last_sender_role, fc.faculty_unread AS unread_count
         FROM tt_subjects ts
         JOIN courses c   ON c.id = ts.course_id
         JOIN students s  ON s.course_id = ts.course_id AND s.semester = ts.semester AND s.status != 'inactive'
         LEFT JOIN faculty_conversations fc
                ON fc.student_id = s.id AND fc.faculty_id = ts.faculty_id AND fc.subject_id = ts.id
         WHERE ts.faculty_id = ?
         ORDER BY (fc.last_message_at IS NULL), fc.last_message_at DESC, student_name ASC"
    );
    $stmt->execute([$fac['faculty_id']]);
    $rows = $stmt->fetchAll();

    foreach ($rows as &$r) {
        $r['student_id']   = (int)$r['student_id'];
        $r['subject_id']   = (int)$r['subject_id'];
        $r['semester']     = (int)$r['semester'];
        $r['unread_count'] = (int)($r['unread_count'] ?? 0);
    }
    unset($r);

    jsonResponse([
        'success'  => true,
        'role'     => 'faculty',
        'faculty'  => ['id' => $fac['faculty_id'], 'name' => $fac['name'], 'department' => $fac['department']],
        'contacts' => $rows,
    ]);
}

// ============================================================
// GET /messages.php/conversation?subject_id=&with_id=
// ============================================================
if ($resource === 'conversation' && $method === 'GET') {
    $user = requireRole(['student', 'faculty']);
    $subjectId = (int)($_GET['subject_id'] ?? 0);
    $withId    = (int)($_GET['with_id'] ?? 0);
    if (!$subjectId || !$withId) jsonError('subject_id and with_id are required.');

    if ($user['role'] === 'student') {
        $student   = msgGetStudent($db, $user);
        $facultyId = $withId;
        msgValidateAssignment($db, $student['course_id'], $student['semester'], $subjectId, $facultyId);
        $conv = msgGetOrCreateConversation($db, $student['id'], $facultyId, $subjectId, $student['course_id'], $student['semester']);

        $msgs = $db->prepare("SELECT id, sender_role, message, is_read, created_at FROM faculty_messages WHERE conversation_id = ? ORDER BY created_at ASC, id ASC");
        $msgs->execute([$conv['id']]);
        $rows = $msgs->fetchAll();

        // Mark faculty's messages as read, reset the student's unread counter.
        $db->prepare("UPDATE faculty_messages SET is_read = 1 WHERE conversation_id = ? AND sender_role = 'faculty' AND is_read = 0")->execute([$conv['id']]);
        $db->prepare("UPDATE faculty_conversations SET student_unread = 0 WHERE id = ?")->execute([$conv['id']]);

        // Who are we talking to?
        $fstmt = $db->prepare("SELECT faculty_id, CONCAT(first_name,' ',last_name) AS name, department, designation FROM faculty WHERE faculty_id = ?");
        $fstmt->execute([$facultyId]);
        $peer = $fstmt->fetch();
        $sstmt = $db->prepare("SELECT subject_code, subject_name FROM tt_subjects WHERE id = ?");
        $sstmt->execute([$subjectId]);
        $subj = $sstmt->fetch();

        jsonResponse(['success' => true, 'conversation_id' => (int)$conv['id'], 'peer' => $peer, 'subject' => $subj, 'messages' => $rows]);
    }

    $fac       = msgGetFaculty($db, $user);
    $studentId = $withId;

    $sstmt = $db->prepare("SELECT id, course_id, semester, CONCAT(first_name,' ',last_name) AS name, gr_number FROM students WHERE id = ?");
    $sstmt->execute([$studentId]);
    $student = $sstmt->fetch();
    if (!$student) jsonError('Student not found.', 404);

    msgValidateAssignment($db, $student['course_id'], $student['semester'], $subjectId, $fac['faculty_id']);
    $conv = msgGetOrCreateConversation($db, $studentId, $fac['faculty_id'], $subjectId, $student['course_id'], $student['semester']);

    $msgs = $db->prepare("SELECT id, sender_role, message, is_read, created_at FROM faculty_messages WHERE conversation_id = ? ORDER BY created_at ASC, id ASC");
    $msgs->execute([$conv['id']]);
    $rows = $msgs->fetchAll();

    $db->prepare("UPDATE faculty_messages SET is_read = 1 WHERE conversation_id = ? AND sender_role = 'student' AND is_read = 0")->execute([$conv['id']]);
    $db->prepare("UPDATE faculty_conversations SET faculty_unread = 0 WHERE id = ?")->execute([$conv['id']]);

    $subjStmt = $db->prepare("SELECT subject_code, subject_name FROM tt_subjects WHERE id = ?");
    $subjStmt->execute([$subjectId]);
    $subj = $subjStmt->fetch();

    jsonResponse(['success' => true, 'conversation_id' => (int)$conv['id'], 'peer' => $student, 'subject' => $subj, 'messages' => $rows]);
}

// ============================================================
// POST /messages.php/send   { subject_id, with_id, message }
// ============================================================
if ($resource === 'send' && $method === 'POST') {
    $user = requireRole(['student', 'faculty']);
    $data = json_decode(file_get_contents('php://input'), true) ?: [];

    $subjectId = (int)($data['subject_id'] ?? 0);
    $withId    = (int)($data['with_id'] ?? 0);
    $message   = sanitize($data['message'] ?? '');

    if (!$subjectId || !$withId) jsonError('subject_id and with_id are required.');
    if ($message === '') jsonError('Message cannot be empty.');
    $msgLen = function_exists('mb_strlen') ? mb_strlen($message) : strlen($message);
    if ($msgLen > 4000) jsonError('Message is too long (max 4000 characters).');

    if ($user['role'] === 'student') {
        $student   = msgGetStudent($db, $user);
        $facultyId = $withId;
        msgValidateAssignment($db, $student['course_id'], $student['semester'], $subjectId, $facultyId);
        $conv = msgGetOrCreateConversation($db, $student['id'], $facultyId, $subjectId, $student['course_id'], $student['semester']);

        $db->beginTransaction();
        $newId = null;
        try {
            $ins = $db->prepare(
                "INSERT INTO faculty_messages (conversation_id, student_id, faculty_id, subject_id, course_id, semester, sender_role, sender_id, message, is_read)
                 VALUES (?, ?, ?, ?, ?, ?, 'student', ?, ?, 0)"
            );
            $ins->execute([$conv['id'], $student['id'], $facultyId, $subjectId, $student['course_id'], $student['semester'], $student['id'], $message]);
            // NOTE: must capture lastInsertId() before commit() — some PDO/MySQL
            // driver combinations reset it to 0 once the transaction is committed.
            $newId = $db->lastInsertId();

            $db->prepare(
                "UPDATE faculty_conversations
                 SET last_message = ?, last_message_at = NOW(), last_sender_role = 'student', faculty_unread = faculty_unread + 1
                 WHERE id = ?"
            )->execute([$message, $conv['id']]);

            $db->commit();
        } catch (Throwable $e) {
            $db->rollBack();
            jsonError('Failed to send message.', 500);
        }

        $row = $db->prepare("SELECT id, sender_role, message, is_read, created_at FROM faculty_messages WHERE id = ?");
        $row->execute([$newId]);
        jsonResponse(['success' => true, 'message_row' => $row->fetch()], 201);
    }

    $fac       = msgGetFaculty($db, $user);
    $studentId = $withId;

    $sstmt = $db->prepare("SELECT id, course_id, semester FROM students WHERE id = ?");
    $sstmt->execute([$studentId]);
    $student = $sstmt->fetch();
    if (!$student) jsonError('Student not found.', 404);

    msgValidateAssignment($db, $student['course_id'], $student['semester'], $subjectId, $fac['faculty_id']);
    $conv = msgGetOrCreateConversation($db, $studentId, $fac['faculty_id'], $subjectId, $student['course_id'], $student['semester']);

    $db->beginTransaction();
    $newId = null;
    try {
        $ins = $db->prepare(
            "INSERT INTO faculty_messages (conversation_id, student_id, faculty_id, subject_id, course_id, semester, sender_role, sender_id, message, is_read)
             VALUES (?, ?, ?, ?, ?, ?, 'faculty', ?, ?, 0)"
        );
        $ins->execute([$conv['id'], $studentId, $fac['faculty_id'], $subjectId, $student['course_id'], $student['semester'], $fac['faculty_id'], $message]);
        // NOTE: must capture lastInsertId() before commit() — see note above.
        $newId = $db->lastInsertId();

        $db->prepare(
            "UPDATE faculty_conversations
             SET last_message = ?, last_message_at = NOW(), last_sender_role = 'faculty', student_unread = student_unread + 1
             WHERE id = ?"
        )->execute([$message, $conv['id']]);

        $db->commit();
    } catch (Throwable $e) {
        $db->rollBack();
        jsonError('Failed to send message.', 500);
    }

    $row = $db->prepare("SELECT id, sender_role, message, is_read, created_at FROM faculty_messages WHERE id = ?");
    $row->execute([$newId]);
    jsonResponse(['success' => true, 'message_row' => $row->fetch()], 201);
}

// ============================================================
// GET /messages.php/unread-count
// ============================================================
if ($resource === 'unread-count' && $method === 'GET') {
    $user = requireRole(['student', 'faculty']);

    if ($user['role'] === 'student') {
        $student = msgGetStudent($db, $user);
        $stmt = $db->prepare("SELECT COALESCE(SUM(student_unread), 0) FROM faculty_conversations WHERE student_id = ?");
        $stmt->execute([$student['id']]);
    } else {
        $fac = msgGetFaculty($db, $user);
        $stmt = $db->prepare("SELECT COALESCE(SUM(faculty_unread), 0) FROM faculty_conversations WHERE faculty_id = ?");
        $stmt->execute([$fac['faculty_id']]);
    }

    jsonResponse(['success' => true, 'unread' => (int)$stmt->fetchColumn()]);
}

jsonError('Not found.', 404);