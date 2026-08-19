-- ============================================================
-- Predefined (Constant) Timetable System — Schema
-- Adds: classrooms, tt_subjects, timetable_slots
--
-- Reuses existing tables: courses (course_id), faculty (faculty_id)
-- Does not modify or drop any existing table.
-- ============================================================

-- ── Classrooms ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS classrooms (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  room_code   VARCHAR(20)  NOT NULL UNIQUE,   -- e.g. E101, C201, M301
  department  VARCHAR(100),
  capacity    INT DEFAULT 60,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ── Timetable Subjects ──────────────────────────────────────
-- Course + semester specific subject list. `faculty_id` is a plain
-- nullable reference (not a hard FK) to your `faculty` table's
-- primary key, since some deployments of this project don't yet
-- have a `faculty` table installed — this keeps the timetable
-- module fully self-contained either way. `faculty_name` always
-- holds a display name (falls back to an auto-generated default
-- faculty when no real faculty record has been assigned yet).
CREATE TABLE IF NOT EXISTS tt_subjects (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  course_id     INT NOT NULL,
  semester      TINYINT NOT NULL,
  subject_code  VARCHAR(30) NOT NULL UNIQUE,
  subject_name  VARCHAR(150) NOT NULL,
  faculty_id    INT NULL,                    -- optional link -> faculty.faculty_id (no hard FK)
  faculty_name  VARCHAR(150),                 -- default/display faculty name
  credits       TINYINT DEFAULT 3,
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
  INDEX idx_tts_course_sem (course_id, semester),
  INDEX idx_tts_faculty (faculty_id)
);

-- ── Timetable Slots ─────────────────────────────────────────
-- One row per (course, semester, day, period). This IS the live,
-- authoritative timetable — seeded with predefined/default data on
-- install, and updated in place by the Admin. Because there is a
-- single canonical row per slot, any Admin edit immediately replaces
-- the default everywhere (student dashboard, faculty dashboard,
-- timetable page) with no separate "override" table to sync.
CREATE TABLE IF NOT EXISTS timetable_slots (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  course_id      INT NOT NULL,
  semester       TINYINT NOT NULL,
  day_of_week    ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,
  period_no      TINYINT NOT NULL,           -- 1-6 (breaks are not stored as rows)
  start_time     TIME NOT NULL,
  end_time       TIME NOT NULL,
  subject_id     INT NULL,
  classroom_id   INT NULL,
  faculty_id     INT NULL,                   -- optional link -> faculty.faculty_id (no hard FK); overrides tt_subjects.faculty_id when set
  is_predefined  TINYINT(1) DEFAULT 1,       -- 1 = still the untouched default, 0 = admin-edited
  updated_by     VARCHAR(150) NULL,
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uniq_slot (course_id, semester, day_of_week, period_no),
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
  FOREIGN KEY (subject_id) REFERENCES tt_subjects(id) ON DELETE SET NULL,
  FOREIGN KEY (classroom_id) REFERENCES classrooms(id) ON DELETE SET NULL,
  INDEX idx_slots_course_sem (course_id, semester),
  INDEX idx_slots_faculty (faculty_id)
);

-- ── Fixed daily period timings (reference table, used by the UI to
--    render break rows and validate admin edits) ─────────────────
CREATE TABLE IF NOT EXISTS timetable_periods (
  period_no   TINYINT PRIMARY KEY,
  label       VARCHAR(30) NOT NULL,
  start_time  TIME NOT NULL,
  end_time    TIME NOT NULL,
  is_break    TINYINT(1) DEFAULT 0
);

INSERT IGNORE INTO timetable_periods (period_no, label, start_time, end_time, is_break) VALUES
(1, 'Period 1',  '09:00:00', '10:00:00', 0),
(2, 'Period 2',  '10:00:00', '11:00:00', 0),
(20,'Tea Break', '11:00:00', '11:15:00', 1),
(3, 'Period 3',  '11:15:00', '12:15:00', 0),
(4, 'Period 4',  '12:15:00', '13:15:00', 0),
(21,'Lunch Break','13:15:00','14:00:00', 1),
(5, 'Period 5',  '14:00:00', '15:00:00', 0),
(6, 'Period 6',  '15:00:00', '16:00:00', 0);