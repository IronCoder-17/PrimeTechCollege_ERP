-- ============================================================
-- Faculty ⇄ Student Messaging — Schema (corrected)
--
-- Reuses existing tables: students (course_id, semester),
-- tt_subjects (course_id, semester, faculty_id). Does not modify or
-- drop any existing table.
--
-- IMPORTANT: `faculty_id` is a plain, indexed INT column — NOT a hard
-- foreign key. This matches the convention your own project already
-- uses in Schema_timetable.sql for tt_subjects.faculty_id, because
-- this deployment does not have a `faculty` table (confirmed from
-- your phpMyAdmin table list). All faculty-identity checks are
-- enforced by the API (backend/api/messages.php) at request time,
-- not by a database-level FK.
--
-- Access rule enforced by the API:
--   student.course_id + student.semester  →  tt_subjects rows
--   →  tt_subjects.faculty_id             →  allowed faculty
--
-- A student may only message the faculty assigned (via tt_subjects)
-- to a subject in their own course + semester. A faculty member may
-- only message students who are enrolled in that same course +
-- semester for a subject actually assigned to them. Both are
-- re-validated server-side on every read and write.
-- ============================================================

-- ── Conversations ─────────────────────────────────────────────
-- One row per (student, faculty, subject) pair.
CREATE TABLE IF NOT EXISTS faculty_conversations (
  id                INT AUTO_INCREMENT PRIMARY KEY,
  student_id        INT NOT NULL,
  faculty_id        INT NOT NULL,             -- no hard FK — see note above
  subject_id        INT NOT NULL,
  course_id         INT NOT NULL,
  semester          TINYINT NOT NULL,
  last_message      TEXT,
  last_message_at   TIMESTAMP NULL,
  last_sender_role  ENUM('student','faculty'),
  student_unread    INT NOT NULL DEFAULT 0,
  faculty_unread    INT NOT NULL DEFAULT 0,
  created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_fc_pair (student_id, faculty_id, subject_id),
  FOREIGN KEY (student_id) REFERENCES students(id)    ON DELETE CASCADE,
  FOREIGN KEY (subject_id) REFERENCES tt_subjects(id) ON DELETE CASCADE,
  INDEX idx_fc_faculty (faculty_id),
  INDEX idx_fc_student (student_id, last_message_at),
  INDEX idx_fc_faculty_time (faculty_id, last_message_at)
);

-- ── Messages ─────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS faculty_messages (
  id               INT AUTO_INCREMENT PRIMARY KEY,
  conversation_id  INT NOT NULL,
  student_id       INT NOT NULL,   -- denormalized for fast/secure filtering
  faculty_id       INT NOT NULL,   -- no hard FK — see note above
  subject_id       INT NOT NULL,
  course_id        INT NOT NULL,
  semester         TINYINT NOT NULL,
  sender_role      ENUM('student','faculty') NOT NULL,
  sender_id        INT NOT NULL,   -- students.id when sender_role='student', faculty id when 'faculty'
  message          TEXT NOT NULL,
  is_read          TINYINT(1) NOT NULL DEFAULT 0,
  created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (conversation_id) REFERENCES faculty_conversations(id) ON DELETE CASCADE,
  INDEX idx_fm_conv (conversation_id, created_at),
  INDEX idx_fm_student (student_id),
  INDEX idx_fm_faculty (faculty_id)
);