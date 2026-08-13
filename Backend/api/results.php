<?php
// ============================================================
// College Campus Connect — Student Results API
//
// ── Student (own records only) ───────────────────────────────
// GET  /api/results.php/my-results
//      Returns current semester details, all previously
//      published semester results (SGPA + subject-wise marks +
//      pass/fail), and the overall CGPA (derived, never stored).
//
// ── Admin (full authority over results) ───────────────────────
// GET    /api/results.php/students?search=...
//        Search students by name / enrollment number for the
//        "Add/Upload Result" picker.
// GET    /api/results.php/student/{student_id}
//        Full result history for one student (admin view).
// GET    /api/results.php/course-subjects?course_id=&semester=
//        Subjects assigned to a course+semester, straight from the
//        Course/Timetable module (tt_subjects) — the same source
//        the "Add Student Marks" screen uses to auto-fill Subject
//        Code / Subject Name / Credit so the admin never retypes
//        them.
// POST   /api/results.php
//        Add a semester result for one student.
//        Body: { student_id, semester, subjects:[...], remarks?, sgpa?, result_status? }
//        Each subject: { subject_id, internal_marks, external_marks, practical_marks, ... }
//        subject_id is resolved against tt_subjects server-side —
//        subject_code/subject_name/credits sent by the client are
//        ignored whenever subject_id is present.
// PUT    /api/results.php/{id}
//        Edit an existing semester result (replaces subjects).
// DELETE /api/results.php/{id}
//        Delete a semester result.
// POST   /api/results.php/bulk
//        Upload marks for multiple students (same course) for the
//        same semester + subject list in one go.
//        Body: { course_id, semester, subjects:[{subject_id,...}],
//                students:[{student_id, marks_split:{<subject_id>: {internal, external, practical}}}], remarks? }
//
// SGPA is computed server-side from subject marks/credits using
// a standard 10-point grading scale. CGPA is never stored — it is
// always derived as the credit-weighted average of all of a
// student's stored SGPAs, so it reflects the latest data with no
// hardcoded values. Grade Point and Credit Points ARE stored per
// subject (alongside the raw marks) so they never have to be
// recomputed to render a marksheet.
// ============================================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method   = $_SERVER['REQUEST_METHOD'];
$path     = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$resource = $path[0] ?? '';
$db       = getDB();

const PASS_PERCENT = 40.0;

// ── Grading scale: percentage -> [grade, grade point] ─────────
// Matches the university grading table exactly (O / A+ / A / B+ / B / C / P / F).
function gradeFromPercent(float $pct): array {
    if ($pct >= 90) return ['O',  10];
    if ($pct >= 80) return ['A+',  9];
    if ($pct >= 70) return ['A',   8];
    if ($pct >= 60) return ['B+',  7];
    if ($pct >= 50) return ['B',   6];
    if ($pct >= 45) return ['C',   5];
    if ($pct >= 40) return ['P',   4];
    return ['F', 0];
}

// ── CGPA -> Classification, per the standard table ────────────
function classificationFromCgpa(float $cgpa): string {
    if ($cgpa >= 9.00) return 'Outstanding';
    if ($cgpa >= 8.00) return 'First Class with Distinction';
    if ($cgpa >= 7.00) return 'First Class';
    if ($cgpa >= 6.00) return 'Second Class';
    if ($cgpa >= 5.00) return 'Pass Class';
    return 'Fail';
}

// ── Look up a subject's authoritative Code / Name / Credits from
//    the Course/Timetable module (tt_subjects) by id. Returns null
//    if the subject doesn't exist. ──────────────────────────────
function resolveSubject($db, $subjectId) {
    if (!$subjectId) return null;
    $stmt = $db->prepare("SELECT id, course_id, semester, subject_code, subject_name, credits FROM tt_subjects WHERE id = ?");
    $stmt->execute([(int)$subjectId]);
    $row = $stmt->fetch();
    return $row ?: null;
}

// ── Compute SGPA + processed subject rows from raw subject input ──
// Each subject may include internal_marks/internal_max, external_marks/
// external_max, and practical_marks/practical_max (practical is optional
// — subjects without a practical component simply have max 0).
// If `subject_id` resolves to a real tt_subjects row, subject_code /
// subject_name / credits are taken from THAT row, never from the client,
// so the admin can never retype or mismatch subject details.
function computeSemester($db, array $subjects): array {
    $totalPoints  = 0.0;
    $totalCredits = 0;
    $failCount    = 0;
    $processed    = [];
    $seenSubjects = [];

    foreach ($subjects as $s) {
        $master = resolveSubject($db, $s['subject_id'] ?? null);

        $intMax  = max(0, (float)($s['internal_max'] ?? 0));
        $intObt  = (float)($s['internal_marks'] ?? 0);
        $extMax  = max(0, (float)($s['external_max'] ?? ($s['max_marks'] ?? 100)));
        $extObt  = (float)($s['external_marks'] ?? ($s['obtained_marks'] ?? 0));
        $pracMax = max(0, (float)($s['practical_max'] ?? 0));
        $pracObt = (float)($s['practical_marks'] ?? 0);

        // Legacy combined max/obtained sent without a split -> external only.
        if (!isset($s['internal_marks']) && !isset($s['external_marks']) && isset($s['obtained_marks'])) {
            $extMax = (float)($s['max_marks'] ?? 100);
            $extObt = (float)($s['obtained_marks'] ?? 0);
        }

        // Validation: marks cannot exceed the allowed maximum for that component.
        if ($intObt > $intMax)  jsonError("Internal marks ({$intObt}) exceed the maximum ({$intMax}) for " . ($master['subject_name'] ?? ($s['subject_name'] ?? 'a subject')) . '.', 400);
        if ($extObt > $extMax)  jsonError("External marks ({$extObt}) exceed the maximum ({$extMax}) for " . ($master['subject_name'] ?? ($s['subject_name'] ?? 'a subject')) . '.', 400);
        if ($pracObt > $pracMax) jsonError("Practical marks ({$pracObt}) exceed the maximum ({$pracMax}) for " . ($master['subject_name'] ?? ($s['subject_name'] ?? 'a subject')) . '.', 400);
        if ($intObt < 0 || $extObt < 0 || $pracObt < 0) jsonError('Marks cannot be negative.', 400);

        $max = $intMax + $extMax + $pracMax;
        $obt = $intObt + $extObt + $pracObt;
        if ($max <= 0) $max = (float)($s['max_marks'] ?? 100);

        $subjectId = $master['id'] ?? (isset($s['subject_id']) ? (int)$s['subject_id'] : null);
        if ($subjectId) {
            if (isset($seenSubjects[$subjectId])) {
                jsonError('Duplicate subject in submission: ' . ($master['subject_name'] ?? $subjectId) . '. Each subject can only appear once per semester result.', 400);
            }
            $seenSubjects[$subjectId] = true;
        }

        $credits = $master['credits'] ?? max(0, (int)($s['credits'] ?? 4));
        $pct     = $max > 0 ? ($obt / $max) * 100 : 0;
        [$grade, $points] = gradeFromPercent($pct);
        $status  = $pct >= PASS_PERCENT ? 'Pass' : 'Fail';
        if ($status === 'Fail') $failCount++;

        $creditPoints = $points * $credits;
        $totalPoints  += $creditPoints;
        $totalCredits += $credits;

        $processed[] = [
            'subject_id'      => $subjectId,
            'subject_code'    => $master['subject_code'] ?? ($s['subject_code'] ?? null),
            'subject_name'    => $master['subject_name'] ?? ($s['subject_name'] ?? 'Subject'),
            'max_marks'       => $max,
            'obtained_marks'  => $obt,
            'internal_max'    => $intMax,
            'internal_marks'  => $intObt,
            'external_max'    => $extMax,
            'external_marks'  => $extObt,
            'practical_max'   => $pracMax,
            'practical_marks' => $pracObt,
            'credits'         => $credits,
            'grade'           => $grade,
            'grade_point'     => $points,
            'credit_points'   => $creditPoints,
            'status'          => $status,
        ];
    }

    $sgpa = $totalCredits > 0 ? round($totalPoints / $totalCredits, 2) : 0.0;

    // Overall semester status: all pass -> Pass; a small number of fails on
    // an otherwise-clear semester -> ATKT/Backlog; many fails -> Fail.
    $subjectCount = count($processed);
    if ($failCount === 0) {
        $overall = 'Pass';
    } elseif ($subjectCount > 0 && $failCount <= max(1, (int)ceil($subjectCount / 3))) {
        $overall = 'ATKT';
    } else {
        $overall = 'Fail';
    }

    return [$sgpa, $totalCredits, $overall, $processed];
}

function logActivity($db, $adminId, $action, $targetType, $targetId, $details) {
    try {
        $stmt = $db->prepare("INSERT INTO admin_activity_log (admin_id, action, target_type, target_id, details) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$adminId, $action, $targetType, $targetId, $details]);
    } catch (\Throwable $e) {
        // Activity logging must never break the main request.
    }
}

// Resolve the `students` row for the currently authenticated student.
function getStudentForUser($db, $user) {
    $stmt = $db->prepare(
        "SELECT s.*, c.course_name, c.course_code, c.total_semesters, c.department
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

const RESULT_SUBJECT_COLUMNS =
    "id, subject_id, subject_code, subject_name, max_marks, obtained_marks,
     internal_max, internal_marks, external_max, external_marks,
     practical_max, practical_marks, credits, grade, grade_point, credit_points, status";

// Fetch all published results (+ subjects) for a student, plus derived CGPA + classification.
// Every published result is returned regardless of the student's current
// semester value — a result being "published" is what makes it visible,
// not where the student's semester counter happens to sit (that counter is
// set independently in Student Management and is not auto-advanced here).
function getResultsForStudent($db, $studentId) {
    $stmt = $db->prepare("SELECT * FROM student_results WHERE student_id = ? ORDER BY semester ASC");
    $stmt->execute([$studentId]);
    $results = $stmt->fetchAll();

    $semesters    = [];
    $progress     = [];
    $cgpaPoints   = 0.0;
    $cgpaCredits  = 0;

    foreach ($results as $r) {
        $subStmt = $db->prepare("SELECT " . RESULT_SUBJECT_COLUMNS . " FROM student_result_subjects WHERE result_id = ? ORDER BY id ASC");
        $subStmt->execute([$r['id']]);
        $subjects = $subStmt->fetchAll();

        $totalMax = 0.0;
        $totalObt = 0.0;
        foreach ($subjects as $s) {
            $totalMax += (float)$s['max_marks'];
            $totalObt += (float)$s['obtained_marks'];
        }
        $percentage = $totalMax > 0 ? round(($totalObt / $totalMax) * 100, 2) : 0.0;

        $semesters[] = [
            'id'                 => (int)$r['id'],
            'semester'           => (int)$r['semester'],
            'academic_year'      => $r['academic_year'] ?? null,
            'sgpa'               => (float)$r['sgpa'],
            'total_credits'      => (int)$r['total_credits'],
            'total_max_marks'    => $totalMax,
            'total_obtained_marks' => $totalObt,
            'percentage'         => $percentage,
            'result_status'      => $r['result_status'],
            'remarks'            => $r['remarks'],
            'result_declared_on' => $r['result_declared_on'] ?? $r['published_at'],
            'published_at'       => $r['published_at'],
            'updated_at'         => $r['updated_at'],
            'subjects'           => $subjects,
        ];

        $progress[] = ['semester' => (int)$r['semester'], 'sgpa' => (float)$r['sgpa']];

        $cgpaPoints  += (float)$r['sgpa'] * (int)$r['total_credits'];
        $cgpaCredits += (int)$r['total_credits'];
    }

    $cgpa = $cgpaCredits > 0 ? round($cgpaPoints / $cgpaCredits, 2) : 0.0;
    $classification = $cgpaCredits > 0 ? classificationFromCgpa($cgpa) : null;
    return [$semesters, $progress, $cgpa, $classification];
}

// ============================================================
// STUDENT: GET /results.php/my-results
// ============================================================
if ($resource === 'my-results' && $method === 'GET') {
    $user = requireAuth();
    if ($user['role'] !== 'student') {
        jsonError('Forbidden: this endpoint is for students only.', 403);
    }

    $student    = getStudentForUser($db, $user);
    $currentSem = (int)($student['semester'] ?? 0);

    [$semesters, $progress, $cgpa, $classification] = getResultsForStudent($db, $student['id']);
    $overallResult = $semesters ? (end($semesters)['result_status']) : null;

    jsonResponse([
        'student' => [
            'id'                => (int)$student['id'],
            'name'              => trim(($student['first_name'] ?? '') . ' ' . ($student['last_name'] ?? '')),
            'enrollment_number' => $student['gr_number'],
            'roll_number'       => $student['gr_number'],
            'course_id'         => $student['course_id'] !== null ? (int)$student['course_id'] : null,
            'course_name'       => $student['course_name'],
            'course_code'       => $student['course_code'],
            'department'        => $student['department'],
            'current_semester'  => $currentSem,
            'total_semesters'   => (int)($student['total_semesters'] ?? 0),
            'academic_year'     => $student['admission_year'] ?? null,
        ],
        'cgpa'           => $cgpa,
        'classification' => $classification,
        'final_result'   => $overallResult,
        'semesters'      => $semesters,
        'progress'       => $progress,
    ]);
}

// ============================================================
// ADMIN: GET /results.php/students?search=...
// ============================================================
if ($resource === 'students' && $method === 'GET') {
    requireAdmin();

    $search = trim($_GET['search'] ?? '');
    $sql = "SELECT s.id, CONCAT(s.first_name, ' ', s.last_name) AS name, s.gr_number, s.semester, s.course_id,
                   c.course_name, c.course_code, c.total_semesters
            FROM students s
            LEFT JOIN courses c ON c.id = s.course_id";
    $params = [];
    if ($search !== '') {
        $sql .= " WHERE s.first_name LIKE ? OR s.last_name LIKE ? OR s.gr_number LIKE ? OR CONCAT(s.first_name,' ',s.last_name) LIKE ?";
        $like = "%$search%";
        $params = [$like, $like, $like, $like];
    }
    $sql .= " ORDER BY s.created_at DESC LIMIT 50";

    $stmt = $db->prepare($sql);
    $stmt->execute($params);
    jsonResponse(['students' => $stmt->fetchAll()]);
}

// ============================================================
// ADMIN: GET /results.php/course-subjects?course_id=&semester=
// Auto-fetch subjects for the "Add Student Marks" screen, straight
// from the Course/Timetable module — nothing is retyped.
// ============================================================
if ($resource === 'course-subjects' && $method === 'GET') {
    requireAdmin();

    $courseId = (int)($_GET['course_id'] ?? 0);
    $semester = (int)($_GET['semester'] ?? 0);
    if (!$courseId || !$semester) jsonError('course_id and semester are required.', 400);

    $stmt = $db->prepare(
        "SELECT id AS subject_id, subject_code, subject_name, credits
         FROM tt_subjects WHERE course_id = ? AND semester = ? ORDER BY subject_name"
    );
    $stmt->execute([$courseId, $semester]);
    $subjects = $stmt->fetchAll();

    jsonResponse([
        'course_id' => $courseId,
        'semester'  => $semester,
        'subjects'  => $subjects,
        'note'      => count($subjects) === 0
            ? 'No subjects are assigned to this course/semester yet. Add them from Timetable Management → Subjects first.'
            : null,
    ]);
}

// ============================================================
// ADMIN: GET /results.php/student/{id}
// ============================================================
if ($resource === 'student' && $method === 'GET') {
    requireAdmin();

    $studentId = isset($path[1]) ? (int)$path[1] : 0;
    if (!$studentId) jsonError('student_id is required.', 400);

    $stmt = $db->prepare(
        "SELECT s.id, CONCAT(s.first_name,' ',s.last_name) AS name, s.gr_number, s.semester, s.course_id,
                c.course_name, c.course_code, c.total_semesters, c.department
         FROM students s
         LEFT JOIN courses c ON c.id = s.course_id
         WHERE s.id = ?"
    );
    $stmt->execute([$studentId]);
    $student = $stmt->fetch();
    if (!$student) jsonError('Student not found.', 404);

    [$semesters, $progress, $cgpa, $classification] = getResultsForStudent($db, $studentId);

    jsonResponse([
        'student' => [
            'id'                => (int)$student['id'],
            'name'              => $student['name'],
            'enrollment_number' => $student['gr_number'],
            'course_id'         => $student['course_id'] !== null ? (int)$student['course_id'] : null,
            'course_name'       => $student['course_name'],
            'course_code'       => $student['course_code'],
            'department'        => $student['department'],
            'current_semester'  => (int)$student['semester'],
            'total_semesters'   => (int)($student['total_semesters'] ?? 0),
        ],
        'cgpa'           => $cgpa,
        'classification' => $classification,
        'semesters'      => $semesters,
        'progress'       => $progress,
    ]);
}

// ============================================================
// ADMIN: POST /results.php  — add a semester result
// ============================================================
if ($resource === '' && $method === 'POST') {
    $admin = requireAdmin();

    $data          = json_decode(file_get_contents('php://input'), true) ?? [];
    $studentId     = intval($data['student_id'] ?? 0);
    $semester      = intval($data['semester'] ?? 0);
    $subjects      = $data['subjects'] ?? [];
    $remarks       = sanitize($data['remarks'] ?? '');
    $academicYear  = sanitize($data['academic_year'] ?? '');
    $declaredOn    = sanitize($data['result_declared_on'] ?? '');

    if (!$studentId)            jsonError('student_id is required.', 400);
    if ($semester < 1 || $semester > 12) jsonError('A valid semester (1-12) is required.', 400);
    if (!is_array($subjects) || count($subjects) === 0) jsonError('At least one subject with marks is required.', 400);

    $chk = $db->prepare("SELECT gr_number, course_id FROM students WHERE id = ?");
    $chk->execute([$studentId]);
    $studentRow = $chk->fetch();
    if (!$studentRow) jsonError('Student not found.', 404);
    $grNumber = $studentRow['gr_number'];

    // Validation: only subjects assigned to the student's own course
    // (and this semester) may be used — never subjects from another course.
    foreach ($subjects as $s) {
        if (empty($s['subject_id'])) continue;
        $master = resolveSubject($db, $s['subject_id']);
        if (!$master) jsonError('One of the selected subjects no longer exists in the Course/Timetable module.', 400);
        if ($studentRow['course_id'] && (int)$master['course_id'] !== (int)$studentRow['course_id']) {
            jsonError("Subject \"{$master['subject_name']}\" does not belong to this student's course.", 400);
        }
        if ((int)$master['semester'] !== $semester) {
            jsonError("Subject \"{$master['subject_name']}\" belongs to semester {$master['semester']}, not semester $semester.", 400);
        }
    }

    [$sgpa, $totalCredits, $status, $processed] = computeSemester($db, $subjects);

    if (isset($data['sgpa']) && is_numeric($data['sgpa'])) {
        $sgpa = round((float)$data['sgpa'], 2);
    }
    if (isset($data['result_status']) && in_array($data['result_status'], ['Pass', 'Fail', 'ATKT', 'Pending'], true)) {
        $status = $data['result_status'];
    }

    try {
        $db->beginTransaction();

        $stmt = $db->prepare(
            "INSERT INTO student_results (student_id, semester, academic_year, sgpa, total_credits, result_status, remarks, result_declared_on)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        );
        $stmt->execute([$studentId, $semester, $academicYear ?: null, $sgpa, $totalCredits, $status, $remarks, $declaredOn ?: null]);
        $resultId = (int)$db->lastInsertId();

        $subStmt = $db->prepare(
            "INSERT INTO student_result_subjects
                (result_id, subject_id, subject_code, subject_name, max_marks, obtained_marks,
                 internal_max, internal_marks, external_max, external_marks,
                 practical_max, practical_marks, credits, grade, grade_point, credit_points, status)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );
        foreach ($processed as $p) {
            $subStmt->execute([
                $resultId, $p['subject_id'], $p['subject_code'], $p['subject_name'], $p['max_marks'], $p['obtained_marks'],
                $p['internal_max'], $p['internal_marks'], $p['external_max'], $p['external_marks'],
                $p['practical_max'], $p['practical_marks'], $p['credits'], $p['grade'], $p['grade_point'], $p['credit_points'], $p['status'],
            ]);
        }

        $db->commit();
    } catch (\Throwable $e) {
        if ($db->inTransaction()) $db->rollBack();
        error_log('[results.php add] ' . $e->getMessage());
        if (str_contains($e->getMessage(), 'uq_student_semester')) {
            jsonError('A result for this student and semester already exists. Edit it instead.', 409);
        }
        jsonError('Failed to save result: ' . $e->getMessage(), 500);
    }

    logActivity($db, $admin['id'], 'added_result', 'student_result', $resultId,
        "Added semester $semester result for student #$studentId (GR: $grNumber) — SGPA $sgpa");

    [$semesters, , $cgpa, $classification] = getResultsForStudent($db, $studentId);
    $added = null;
    foreach ($semesters as $s) if ($s['id'] === $resultId) $added = $s;

    jsonResponse(['message' => 'Result added successfully.', 'result' => $added, 'cgpa' => $cgpa, 'classification' => $classification], 201);
}

// ============================================================
// ADMIN: POST /results.php/bulk — upload marks for many students
// (all from the same course, since subjects are course-specific)
// ============================================================
if ($resource === 'bulk' && $method === 'POST') {
    $admin = requireAdmin();

    $data         = json_decode(file_get_contents('php://input'), true) ?? [];
    $courseId     = intval($data['course_id'] ?? 0);
    $semester     = intval($data['semester'] ?? 0);
    $subjects     = $data['subjects'] ?? [];     // [{subject_id, ...}] — resolved from tt_subjects
    $students     = $data['students'] ?? [];     // [{student_id, marks_split:{subject_id:{internal,external,practical}}}] (or legacy marks:{code:val})
    $remarks      = sanitize($data['remarks'] ?? '');
    $academicYear = sanitize($data['academic_year'] ?? '');
    $declaredOn   = sanitize($data['result_declared_on'] ?? '');

    if ($semester < 1 || $semester > 12) jsonError('A valid semester (1-12) is required.', 400);
    if (!is_array($subjects) || count($subjects) === 0) jsonError('At least one subject is required.', 400);
    if (!is_array($students) || count($students) === 0) jsonError('At least one student is required.', 400);

    // Validate every subject belongs to the declared course + semester.
    foreach ($subjects as $subj) {
        if (empty($subj['subject_id'])) continue;
        $master = resolveSubject($db, $subj['subject_id']);
        if (!$master) jsonError('One of the selected subjects no longer exists.', 400);
        if ($courseId && (int)$master['course_id'] !== $courseId) jsonError("Subject \"{$master['subject_name']}\" does not belong to the selected course.", 400);
        if ((int)$master['semester'] !== $semester) jsonError("Subject \"{$master['subject_name']}\" belongs to semester {$master['semester']}, not semester $semester.", 400);
    }

    $saved  = [];
    $failed = [];

    foreach ($students as $entry) {
        $studentId  = intval($entry['student_id'] ?? 0);
        $marks      = $entry['marks'] ?? [];        // {code: obtained} — legacy combined
        $marksSplit = $entry['marks_split'] ?? [];  // {subject_id: {internal, external, practical}} — preferred
        if (!$studentId) continue;

        $chk = $db->prepare("SELECT gr_number, course_id FROM students WHERE id = ?");
        $chk->execute([$studentId]);
        $studentRow = $chk->fetch();
        if (!$studentRow) { $failed[] = ['student_id' => $studentId, 'reason' => 'Student not found']; continue; }
        if ($courseId && $studentRow['course_id'] && (int)$studentRow['course_id'] !== $courseId) {
            $failed[] = ['student_id' => $studentId, 'reason' => 'Student is not enrolled in the selected course']; continue;
        }
        $grNumber = $studentRow['gr_number'];

        // Build per-student subject rows from the shared subject definitions
        $studentSubjects = [];
        foreach ($subjects as $subj) {
            $sid  = $subj['subject_id'] ?? null;
            $code = $subj['subject_code'] ?? '';
            $key  = $sid ?: $code;
            $split = $marksSplit[$key] ?? $marksSplit[(string)$key] ?? null;

            $row = ['subject_id' => $sid, 'subject_code' => $code, 'subject_name' => $subj['subject_name'] ?? $code, 'credits' => $subj['credits'] ?? 4];
            if ($split) {
                $row['internal_max']    = $subj['internal_max'] ?? 0;
                $row['internal_marks']  = $split['internal'] ?? 0;
                $row['external_max']    = $subj['external_max'] ?? ($subj['max_marks'] ?? 100);
                $row['external_marks']  = $split['external'] ?? 0;
                $row['practical_max']   = $subj['practical_max'] ?? 0;
                $row['practical_marks'] = $split['practical'] ?? 0;
            } else {
                $row['max_marks']      = $subj['max_marks'] ?? 100;
                $row['obtained_marks'] = $marks[$code] ?? 0;
            }
            $studentSubjects[] = $row;
        }

        [$sgpa, $totalCredits, $status, $processed] = computeSemester($db, $studentSubjects);

        try {
            $db->beginTransaction();

            // Remove any previous result for this student+semester (re-upload = overwrite)
            $del = $db->prepare("DELETE FROM student_results WHERE student_id = ? AND semester = ?");
            $del->execute([$studentId, $semester]);

            $stmt = $db->prepare(
                "INSERT INTO student_results (student_id, semester, academic_year, sgpa, total_credits, result_status, remarks, result_declared_on)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
            );
            $stmt->execute([$studentId, $semester, $academicYear ?: null, $sgpa, $totalCredits, $status, $remarks, $declaredOn ?: null]);
            $resultId = (int)$db->lastInsertId();

            $subStmt = $db->prepare(
                "INSERT INTO student_result_subjects
                    (result_id, subject_id, subject_code, subject_name, max_marks, obtained_marks,
                     internal_max, internal_marks, external_max, external_marks,
                     practical_max, practical_marks, credits, grade, grade_point, credit_points, status)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );
            foreach ($processed as $p) {
                $subStmt->execute([
                    $resultId, $p['subject_id'], $p['subject_code'], $p['subject_name'], $p['max_marks'], $p['obtained_marks'],
                    $p['internal_max'], $p['internal_marks'], $p['external_max'], $p['external_marks'],
                    $p['practical_max'], $p['practical_marks'], $p['credits'], $p['grade'], $p['grade_point'], $p['credit_points'], $p['status'],
                ]);
            }

            $db->commit();
            $saved[] = ['student_id' => $studentId, 'gr_number' => $grNumber, 'result_id' => $resultId, 'sgpa' => $sgpa, 'result_status' => $status];
        } catch (\Throwable $e) {
            if ($db->inTransaction()) $db->rollBack();
            error_log('[results.php bulk] student ' . $studentId . ': ' . $e->getMessage());
            $failed[] = ['student_id' => $studentId, 'reason' => $e->getMessage()];
        }
    }

    logActivity($db, $admin['id'], 'bulk_uploaded_results', 'student_result', null,
        "Bulk-uploaded semester $semester results for " . count($saved) . " student(s)");

    jsonResponse(['message' => 'Bulk upload complete.', 'saved' => $saved, 'failed' => $failed]);
}

// ============================================================
// ADMIN: PUT /results.php/{id} — edit a result
// ============================================================
if ($method === 'PUT' && is_numeric($resource)) {
    $admin    = requireAdmin();
    $resultId = (int)$resource;

    $stmt = $db->prepare("SELECT * FROM student_results WHERE id = ?");
    $stmt->execute([$resultId]);
    $existing = $stmt->fetch();
    if (!$existing) jsonError('Result not found.', 404);

    $data = json_decode(file_get_contents('php://input'), true) ?? [];

    $semester = isset($data['semester']) ? intval($data['semester']) : (int)$existing['semester'];
    if ($semester < 1 || $semester > 12) jsonError('A valid semester (1-12) is required.', 400);

    $remarks       = array_key_exists('remarks', $data) ? sanitize($data['remarks']) : $existing['remarks'];
    $academicYear  = array_key_exists('academic_year', $data) ? sanitize($data['academic_year']) : $existing['academic_year'];
    $declaredOn    = array_key_exists('result_declared_on', $data) ? sanitize($data['result_declared_on']) : $existing['result_declared_on'];

    if (isset($data['subjects']) && is_array($data['subjects']) && count($data['subjects']) > 0) {
        [$sgpa, $totalCredits, $status, $processed] = computeSemester($db, $data['subjects']);
    } else {
        // Keep existing subjects, just possibly relabel/recalc
        $subStmt = $db->prepare("SELECT " . RESULT_SUBJECT_COLUMNS . " FROM student_result_subjects WHERE result_id = ?");
        $subStmt->execute([$resultId]);
        [$sgpa, $totalCredits, $status, $processed] = computeSemester($db, $subStmt->fetchAll());
    }

    if (isset($data['sgpa']) && is_numeric($data['sgpa'])) {
        $sgpa = round((float)$data['sgpa'], 2);
    }
    if (isset($data['result_status']) && in_array($data['result_status'], ['Pass', 'Fail', 'ATKT', 'Pending'], true)) {
        $status = $data['result_status'];
    }

    try {
        $db->beginTransaction();

        $db->prepare(
            "UPDATE student_results SET semester = ?, academic_year = ?, sgpa = ?, total_credits = ?, result_status = ?, remarks = ?, result_declared_on = ? WHERE id = ?"
        )->execute([$semester, $academicYear ?: null, $sgpa, $totalCredits, $status, $remarks, $declaredOn ?: null, $resultId]);

        // Replace subject rows
        $db->prepare("DELETE FROM student_result_subjects WHERE result_id = ?")->execute([$resultId]);
        $subStmt = $db->prepare(
            "INSERT INTO student_result_subjects
                (result_id, subject_id, subject_code, subject_name, max_marks, obtained_marks,
                 internal_max, internal_marks, external_max, external_marks,
                 practical_max, practical_marks, credits, grade, grade_point, credit_points, status)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );
        foreach ($processed as $p) {
            $subStmt->execute([
                $resultId, $p['subject_id'], $p['subject_code'], $p['subject_name'], $p['max_marks'], $p['obtained_marks'],
                $p['internal_max'], $p['internal_marks'], $p['external_max'], $p['external_marks'],
                $p['practical_max'], $p['practical_marks'], $p['credits'], $p['grade'], $p['grade_point'], $p['credit_points'], $p['status'],
            ]);
        }

        $db->commit();
    } catch (\Throwable $e) {
        if ($db->inTransaction()) $db->rollBack();
        error_log('[results.php edit] ' . $e->getMessage());
        if (str_contains($e->getMessage(), 'uq_student_semester')) {
            jsonError('Another result for this student already exists for that semester.', 409);
        }
        jsonError('Failed to update result: ' . $e->getMessage(), 500);
    }

    logActivity($db, $admin['id'], 'edited_result', 'student_result', $resultId,
        "Updated semester $semester result for student #{$existing['student_id']} — SGPA $sgpa");

    [$semesters, , $cgpa, $classification] = getResultsForStudent($db, (int)$existing['student_id']);
    $updated = null;
    foreach ($semesters as $s) if ($s['id'] === $resultId) $updated = $s;

    jsonResponse(['message' => 'Result updated successfully.', 'result' => $updated, 'cgpa' => $cgpa, 'classification' => $classification]);
}

// ============================================================
// ADMIN: DELETE /results.php/{id} — delete a result
// ============================================================
if ($method === 'DELETE' && is_numeric($resource)) {
    $admin    = requireAdmin();
    $resultId = (int)$resource;

    $stmt = $db->prepare("SELECT * FROM student_results WHERE id = ?");
    $stmt->execute([$resultId]);
    $existing = $stmt->fetch();
    if (!$existing) jsonError('Result not found.', 404);

    $db->prepare("DELETE FROM student_results WHERE id = ?")->execute([$resultId]);

    logActivity($db, $admin['id'], 'deleted_result', 'student_result', $resultId,
        "Deleted semester {$existing['semester']} result for student #{$existing['student_id']}");

    [, , $cgpa, $classification] = getResultsForStudent($db, (int)$existing['student_id']);
    jsonResponse(['message' => 'Result deleted successfully.', 'cgpa' => $cgpa, 'classification' => $classification]);
}

jsonError('Not found.', 404);