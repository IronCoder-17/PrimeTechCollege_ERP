-- ============================================================
-- Results Module Upgrade — Automatic Subject Fetching + SGPA/CGPA
-- College Campus Connect
--
-- Non-destructive migration. Adds:
--   - student_result_subjects.subject_id  -> tt_subjects(id)
--     (so subject code/name/credits are looked up from the
--      Course/Timetable module instead of being retyped by the
--      admin; existing text columns are kept for backward
--      compatibility with rows created before this upgrade)
--   - student_result_subjects.practical_max / practical_marks
--   - student_result_subjects.grade_point / credit_points
--     (stored so the marksheet/PDF never has to recompute them,
--      per the "Results table should store Grade Point / Credit
--      Points" requirement — SGPA/CGPA themselves stay derived)
--
-- Safe to run multiple times.
-- ============================================================

SET @db := DATABASE();

-- ── subject_id: link to the Course/Timetable subject master ──
SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_result_subjects' AND COLUMN_NAME='subject_id') = 0,
  'ALTER TABLE student_result_subjects ADD COLUMN subject_id INT NULL AFTER result_id',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_result_subjects' AND INDEX_NAME='idx_result_subjects_subject') = 0,
  'CREATE INDEX idx_result_subjects_subject ON student_result_subjects(subject_id)',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- Add the FK only if it doesn't already exist (older MySQL has no
-- "ADD CONSTRAINT IF NOT EXISTS", so check information_schema first).
SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_result_subjects' AND CONSTRAINT_NAME='fk_result_subjects_subject') = 0,
  'ALTER TABLE student_result_subjects ADD CONSTRAINT fk_result_subjects_subject FOREIGN KEY (subject_id) REFERENCES tt_subjects(id) ON DELETE SET NULL',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ── Practical marks (in addition to internal/external) ──
SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_result_subjects' AND COLUMN_NAME='practical_max') = 0,
  'ALTER TABLE student_result_subjects ADD COLUMN practical_max INT NOT NULL DEFAULT 0 AFTER external_marks, ADD COLUMN practical_marks DECIMAL(5,2) NOT NULL DEFAULT 0 AFTER practical_max',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ── Stored Grade Point + Credit Points per subject ──
SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_result_subjects' AND COLUMN_NAME='grade_point') = 0,
  'ALTER TABLE student_result_subjects ADD COLUMN grade_point TINYINT NOT NULL DEFAULT 0, ADD COLUMN credit_points DECIMAL(6,2) NOT NULL DEFAULT 0',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ── Prevent duplicate marks for the same student+subject+semester:
--    one row per (result_id, subject_id) when subject_id is set. ──
SET @sql := (SELECT IF(
  (SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=@db AND TABLE_NAME='student_result_subjects' AND INDEX_NAME='uq_result_subject') = 0,
  'CREATE UNIQUE INDEX uq_result_subject ON student_result_subjects(result_id, subject_id)',
  'SELECT 1'));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
