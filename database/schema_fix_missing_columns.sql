-- ============================================================
-- PrimeTech College — Fix: Missing Columns Migration
--
-- Compatible with MySQL 5.7 and MySQL 8.0+
-- Uses PROCEDURE workaround because ADD COLUMN IF NOT EXISTS
-- was only added in MySQL 8.0 — Laragon often ships MySQL 5.7.
--
-- Safe to run multiple times (idempotent).
-- Requires schema.sql + schema_admission.sql to have run first.
-- ============================================================

USE college_campus;

-- ── Add students.profile_photo if it doesn't exist ───────────
DROP PROCEDURE IF EXISTS _add_col_students_photo;
DELIMITER $$
CREATE PROCEDURE _add_col_students_photo()
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME   = 'students'
      AND COLUMN_NAME  = 'profile_photo'
  ) THEN
    ALTER TABLE students ADD COLUMN profile_photo VARCHAR(500) AFTER address;
  END IF;
END$$
DELIMITER ;
CALL _add_col_students_photo();
DROP PROCEDURE IF EXISTS _add_col_students_photo;

-- ── Add faculty.salary if it doesn't exist ───────────────────
DROP PROCEDURE IF EXISTS _add_col_faculty_salary;
DELIMITER $$
CREATE PROCEDURE _add_col_faculty_salary()
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME   = 'faculty'
      AND COLUMN_NAME  = 'salary'
  ) THEN
    ALTER TABLE faculty ADD COLUMN salary DECIMAL(10,2) AFTER experience;
  END IF;
END$$
DELIMITER ;
CALL _add_col_faculty_salary();
DROP PROCEDURE IF EXISTS _add_col_faculty_salary;

-- ── Ensure faculty_documents.profile_photo is large enough ───
DROP PROCEDURE IF EXISTS _mod_col_faculty_docs_photo;
DELIMITER $$
CREATE PROCEDURE _mod_col_faculty_docs_photo()
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME   = 'faculty_documents'
      AND COLUMN_NAME  = 'profile_photo'
  ) THEN
    ALTER TABLE faculty_documents MODIFY COLUMN profile_photo VARCHAR(500);
  END IF;
END$$
DELIMITER ;
CALL _mod_col_faculty_docs_photo();
DROP PROCEDURE IF EXISTS _mod_col_faculty_docs_photo;