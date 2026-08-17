-- ============================================
-- Faculty Modules 10-14 — Schema Migration
-- College Campus Connect
-- ============================================

USE college_campus;

-- ── Module 10: Faculty Self Attendance ──────────────────────

CREATE TABLE IF NOT EXISTS faculty_attendance (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  faculty_id      INT NOT NULL,
  date            DATE NOT NULL,
  status          ENUM('Present','Absent','Leave') NOT NULL,
  punch_in_time   TIME,
  punch_out_time  TIME,
  working_hours   DECIMAL(4,2),          -- stored as decimal hours e.g. 8.50
  created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_faculty_date (faculty_id, date),
  FOREIGN KEY (faculty_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_faculty_att_faculty ON faculty_attendance(faculty_id);
CREATE INDEX IF NOT EXISTS idx_faculty_att_date    ON faculty_attendance(date);

-- ── Module 11: Faculty Punch Logs ───────────────────────────

CREATE TABLE IF NOT EXISTS faculty_punch_logs (
  id                  INT AUTO_INCREMENT PRIMARY KEY,
  faculty_id          INT NOT NULL,
  date                DATE NOT NULL,
  punch_in_time       DATETIME,
  punch_out_time      DATETIME,
  total_working_hours DECIMAL(4,2),      -- decimal hours
  location            VARCHAR(200),      -- optional GPS / building name
  device_info         VARCHAR(300),      -- optional user-agent / device
  created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_punch_faculty_date (faculty_id, date),
  FOREIGN KEY (faculty_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_punch_faculty ON faculty_punch_logs(faculty_id);
CREATE INDEX IF NOT EXISTS idx_punch_date    ON faculty_punch_logs(date);

-- ── Module 12: Syllabus Mapping ─────────────────────────────

-- Subjects table (if not already present)
CREATE TABLE IF NOT EXISTS subjects (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  code          VARCHAR(20) UNIQUE NOT NULL,
  name          VARCHAR(150) NOT NULL,
  department    VARCHAR(80),
  semester      TINYINT,
  credits       TINYINT DEFAULT 3,
  faculty_id    INT,
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (faculty_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS syllabus (
  id                    INT AUTO_INCREMENT PRIMARY KEY,
  subject_id            INT NOT NULL,
  unit_no               TINYINT NOT NULL,
  topic_name            VARCHAR(200) NOT NULL,
  total_lectures        TINYINT NOT NULL DEFAULT 0,
  completed_lectures    TINYINT NOT NULL DEFAULT 0,
  completion_percentage DECIMAL(5,2) GENERATED ALWAYS AS (
    CASE WHEN total_lectures = 0 THEN 0
         ELSE ROUND((completed_lectures / total_lectures) * 100, 2)
    END
  ) STORED,
  updated_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_syllabus_unit (subject_id, unit_no),
  FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_syllabus_subject ON syllabus(subject_id);

-- ── Student Attendance (faculty marks for students) ─────────

CREATE TABLE IF NOT EXISTS student_attendance (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  student_id  INT NOT NULL,
  subject_id  INT NOT NULL,
  faculty_id  INT NOT NULL,
  date        DATE NOT NULL,
  status      ENUM('Present','Absent','Leave') NOT NULL,
  remarks     VARCHAR(200),
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_student_att (student_id, subject_id, date),
  FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (subject_id) REFERENCES subjects(id),
  FOREIGN KEY (faculty_id) REFERENCES users(id)
);

CREATE INDEX IF NOT EXISTS idx_student_att_student  ON student_attendance(student_id);
CREATE INDEX IF NOT EXISTS idx_student_att_subject  ON student_attendance(subject_id);
CREATE INDEX IF NOT EXISTS idx_student_att_date     ON student_attendance(date);

-- ── Module 14: Faculty Notifications ────────────────────────

CREATE TABLE IF NOT EXISTS faculty_notifications (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  faculty_id  INT NOT NULL,
  title       VARCHAR(200) NOT NULL,
  message     TEXT NOT NULL,
  type        ENUM('class','attendance','syllabus','event','meeting','general') NOT NULL DEFAULT 'general',
  is_read     TINYINT(1) DEFAULT 0,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (faculty_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_fac_notif_faculty ON faculty_notifications(faculty_id, is_read);
CREATE INDEX IF NOT EXISTS idx_fac_notif_created ON faculty_notifications(created_at DESC);

-- ── Seed: Sample Subjects ────────────────────────────────────

INSERT IGNORE INTO subjects (code, name, department, semester, credits) VALUES
  ('CS401', 'Advanced Algorithms',  'CS', 7, 4),
  ('CS302', 'Database Systems',     'CS', 5, 3),
  ('CS501', 'Machine Learning',     'CS', 8, 4);

-- ── Seed: Syllabus Units ─────────────────────────────────────

INSERT IGNORE INTO syllabus (subject_id, unit_no, topic_name, total_lectures, completed_lectures)
SELECT s.id, u.unit_no, u.topic_name, u.total_lectures, u.completed_lectures
FROM subjects s
JOIN (
  SELECT 'CS401' AS code, 1 AS unit_no, 'Algorithm Analysis & Complexity' AS topic_name, 8 AS total_lectures, 8 AS completed_lectures UNION ALL
  SELECT 'CS401', 2, 'Divide & Conquer',          6, 5 UNION ALL
  SELECT 'CS401', 3, 'Dynamic Programming',        8, 4 UNION ALL
  SELECT 'CS401', 4, 'Graph Algorithms',           10, 2 UNION ALL
  SELECT 'CS302', 1, 'Introduction to DBMS',       6, 6 UNION ALL
  SELECT 'CS302', 2, 'ER Model & Relational Model',8, 6 UNION ALL
  SELECT 'CS302', 3, 'SQL Queries',                10, 5 UNION ALL
  SELECT 'CS302', 4, 'Normalization',              8, 0 UNION ALL
  SELECT 'CS501', 1, 'Introduction & Math Foundations', 6, 4 UNION ALL
  SELECT 'CS501', 2, 'Supervised Learning',        8, 2 UNION ALL
  SELECT 'CS501', 3, 'Unsupervised Learning',      8, 0 UNION ALL
  SELECT 'CS501', 4, 'Neural Networks & Deep Learning', 10, 0
) u ON s.code = u.code;
