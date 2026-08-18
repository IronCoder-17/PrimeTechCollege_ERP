-- ============================================================
-- Fix: Dynamic Course & Semester-Wise Fee Receipt System
-- Adds audit/sync columns to fee_structure so the Student Fee
-- Receipt page can show "as of" info and so Admin changes are
-- traceable. Safe to run multiple times (IF NOT EXISTS guards).
-- Run this AFTER schema_admission.sql / schema_fee_management.sql.
-- ============================================================

ALTER TABLE fee_structure
  ADD COLUMN IF NOT EXISTS updated_by INT NULL AFTER total_fee,
  ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP NULL
    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER updated_by;

-- Best-effort FK — ignored if it already exists or the engine/naming
-- doesn't support IF NOT EXISTS on constraints.
SET @fk_exists := (
  SELECT COUNT(*) FROM information_schema.TABLE_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE()
    AND TABLE_NAME = 'fee_structure'
    AND CONSTRAINT_NAME = 'fk_fee_structure_updated_by'
);
SET @sql := IF(@fk_exists = 0,
  'ALTER TABLE fee_structure ADD CONSTRAINT fk_fee_structure_updated_by FOREIGN KEY (updated_by) REFERENCES users(id)',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;