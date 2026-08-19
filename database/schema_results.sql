-- ============================================================
-- Student Previous Semester Results — Schema
-- College Campus Connect
--
-- Stores semester-wise results for each student, linked via
-- students.id (and therefore students.gr_number / Enrollment
-- Number). SGPA is stored per semester (computed server-side
-- from subject marks/credits); CGPA is derived on read as the
-- credit-weighted average of all stored SGPAs — never hardcoded.
-- ============================================================


-- ── Semester Result Header ──────────────────────────────────
CREATE TABLE IF NOT EXISTS student_results (
  id                     INT AUTO_INCREMENT PRIMARY KEY,
  student_id             INT NOT NULL,
  semester               TINYINT NOT NULL,
  academic_year          VARCHAR(9),                          -- e.g. "2023-2024"
  sgpa                   DECIMAL(4,2) NOT NULL DEFAULT 0,
  total_credits          INT NOT NULL DEFAULT 0,
  result_status          ENUM('Pass','Fail','ATKT','Pending') NOT NULL DEFAULT 'Pending',
  remarks                VARCHAR(255),
  result_declared_on     DATE DEFAULT NULL,                   -- explicit declaration date (falls back to published_at if null)
  published_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_student_semester (student_id, semester),
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- ── Subject-wise Marks for a Semester Result ────────────────
CREATE TABLE IF NOT EXISTS student_result_subjects (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  result_id      INT NOT NULL,
  subject_code   VARCHAR(20),
  subject_name   VARCHAR(150) NOT NULL,
  max_marks      INT NOT NULL DEFAULT 100,                    -- external max (backward compatible)
  obtained_marks DECIMAL(5,2) NOT NULL DEFAULT 0,              -- total obtained = internal + external
  internal_max   INT NOT NULL DEFAULT 0,
  internal_marks DECIMAL(5,2) NOT NULL DEFAULT 0,
  external_max   INT NOT NULL DEFAULT 100,
  external_marks DECIMAL(5,2) NOT NULL DEFAULT 0,
  credits        TINYINT NOT NULL DEFAULT 4,
  grade          VARCHAR(4),
  status         ENUM('Pass','Fail') NOT NULL DEFAULT 'Pass',
  FOREIGN KEY (result_id) REFERENCES student_results(id) ON DELETE CASCADE
);

-- Indexes (guarded manually since plain MySQL doesn't support
-- "CREATE INDEX IF NOT EXISTS" the way MariaDB does).
SET @db := DATABASE();

SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_results' AND INDEX_NAME='idx_results_student') = 0,
  'CREATE INDEX idx_results_student ON student_results(student_id)',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_results' AND INDEX_NAME='idx_results_student_sem') = 0,
  'CREATE INDEX idx_results_student_sem ON student_results(student_id, semester)',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_result_subjects' AND INDEX_NAME='idx_result_subjects') = 0,
  'CREATE INDEX idx_result_subjects ON student_result_subjects(result_id)',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ── Non-destructive migration for databases created before this update ──
-- (CREATE TABLE IF NOT EXISTS above is a no-op on existing installs, so
--  add the new columns here if they don't already exist.)
SET @db := DATABASE();

SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_results' AND COLUMN_NAME='academic_year') = 0,
  'ALTER TABLE student_results ADD COLUMN academic_year VARCHAR(9) AFTER semester',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_results' AND COLUMN_NAME='result_declared_on') = 0,
  'ALTER TABLE student_results ADD COLUMN result_declared_on DATE DEFAULT NULL AFTER remarks',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_result_subjects' AND COLUMN_NAME='internal_marks') = 0,
  'ALTER TABLE student_result_subjects ADD COLUMN internal_max INT NOT NULL DEFAULT 0, ADD COLUMN internal_marks DECIMAL(5,2) NOT NULL DEFAULT 0, ADD COLUMN external_max INT NOT NULL DEFAULT 100, ADD COLUMN external_marks DECIMAL(5,2) NOT NULL DEFAULT 0',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- Widen result_status ENUM to include ATKT/Backlog if the table pre-dates it.
ALTER TABLE student_results MODIFY COLUMN result_status ENUM('Pass','Fail','ATKT','Pending') NOT NULL DEFAULT 'Pending';