-- ============================================
-- Seed Data — Faculty Modules 10-14
-- ============================================

USE college_campus;

-- Assume faculty user id = 2 (insert a demo faculty if not present)
INSERT IGNORE INTO users (id, name, email, password_hash, role, major)
VALUES (2, 'Dr. Priya Shah', 'faculty@primetech.edu', '$2y$10$placeholder_hash', 'faculty', 'Computer Science');

-- Matching `faculty` profile row (employee_id/department/designation) so the
-- Admin Faculty Attendance Management dashboard can display full faculty
-- details for this user (joined on email).
INSERT IGNORE INTO faculty (employee_id, first_name, last_name, email, password_hash, department, designation, status)
VALUES ('PTFAC20260001', 'Priya', 'Shah', 'faculty@primetech.edu', '$2y$10$placeholder_hash', 'Computer Science', 'Associate Professor', 'Active');

-- ── Faculty Attendance Records ───────────────────────────────
INSERT IGNORE INTO faculty_attendance (faculty_id, date, status, punch_in_time, punch_out_time, working_hours) VALUES
(2, '2026-06-01', 'Present', '09:05:00', '17:45:00', 8.67),
(2, '2026-06-02', 'Present', '08:55:00', '17:30:00', 8.58),
(2, '2026-06-03', 'Present', '09:10:00', '17:50:00', 8.67),
(2, '2026-06-04', 'Leave',   NULL,        NULL,        NULL),
(2, '2026-06-05', 'Present', '09:00:00', '17:30:00', 8.50),
(2, '2026-06-06', 'Absent',  NULL,        NULL,        NULL),
(2, '2026-06-07', 'Present', '09:15:00', '18:00:00', 8.75),
(2, '2026-06-08', 'Present', '09:00:00', NULL,        NULL);

-- ── Punch Logs ───────────────────────────────────────────────
INSERT IGNORE INTO faculty_punch_logs (faculty_id, date, punch_in_time, punch_out_time, total_working_hours) VALUES
(2, '2026-06-01', '2026-06-01 09:05:00', '2026-06-01 17:45:00', 8.67),
(2, '2026-06-02', '2026-06-02 08:55:00', '2026-06-02 17:30:00', 8.58),
(2, '2026-06-03', '2026-06-03 09:10:00', '2026-06-03 17:50:00', 8.67),
(2, '2026-06-05', '2026-06-05 09:00:00', '2026-06-05 17:30:00', 8.50),
(2, '2026-06-07', '2026-06-07 09:15:00', '2026-06-07 18:00:00', 8.75),
(2, '2026-06-08', '2026-06-08 09:00:00', NULL,                   NULL);

-- ── Faculty Notifications ─────────────────────────────────────
INSERT INTO faculty_notifications (faculty_id, title, message, type, is_read) VALUES
(2, 'Upcoming Class Reminder',     'CS401 lecture at 10:00 AM today in Block A-204.',          'class',      0),
(2, 'Pending Attendance',          'You have not submitted attendance for CS302 on Jun 7.',    'attendance', 0),
(2, 'Syllabus Update Pending',     'Unit 3 of CS501 has no lectures recorded yet.',            'syllabus',   0),
(2, 'TechFest 2026 Event',         'Annual TechFest begins on June 15. Register your students.','event',     1),
(2, 'Faculty Senate Meeting',      'Monthly meeting scheduled for Thursday, 11:00 AM.',       'meeting',    1);
