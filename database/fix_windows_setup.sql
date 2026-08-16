-- ============================================================
-- PrimeTech College — Windows/XAMPP Repair Migration
-- Fixes syntax errors from schema_admission.sql / schema_transportation.sql
-- (older MySQL doesn't support "CREATE INDEX IF NOT EXISTS" or
-- "ADD COLUMN IF NOT EXISTS") and finishes seeding all 20 courses
-- + their fee_structure rows, regardless of what already exists.
--
-- 100% SAFE TO RUN — every step checks before acting, so running
-- this multiple times will never error or duplicate data.
-- ============================================================


-- ── 1. Make sure all 20 courses exist (skips any already present) ──
INSERT IGNORE INTO courses (course_name, course_code, duration_years, total_semesters, department, level) VALUES
('B.Tech Computer Engineering',         'BTCE',  4, 8, 'Engineering', 'UG'),
('B.Tech Information Technology',       'BTIT',  4, 8, 'Engineering', 'UG'),
('B.Tech Mechanical Engineering',       'BTME',  4, 8, 'Engineering', 'UG'),
('B.Tech Civil Engineering',            'BTCV',  4, 8, 'Engineering', 'UG'),
('B.Tech Electronics & Communication',  'BTEC',  4, 8, 'Engineering', 'UG'),
('M.Tech Computer Engineering',         'MTCE',  2, 4, 'Engineering', 'PG'),
('M.Tech Structural Engineering',       'MTSE',  2, 4, 'Engineering', 'PG'),
('BCA',                                 'BCA',   3, 6, 'Computer & IT','UG'),
('MCA',                                 'MCA',   2, 4, 'Computer & IT','PG'),
('B.Sc Information Technology',         'BSCIT', 3, 6, 'Computer & IT','UG'),
('BBA',                                 'BBA',   3, 6, 'Management',  'UG'),
('MBA',                                 'MBA',   2, 4, 'Management',  'PG'),
('B.Com Business Analytics',            'BCBA',  3, 6, 'Management',  'UG'),
('B.Sc Mathematics',                    'BSCMA', 3, 6, 'Science',     'UG'),
('B.Sc Physics',                        'BSCPH', 3, 6, 'Science',     'UG'),
('M.Sc Data Science',                   'MSCDS', 2, 4, 'Science',     'PG'),
('B.Com',                               'BCOM',  3, 6, 'Commerce',    'UG'),
('M.Com',                               'MCOM',  2, 4, 'Commerce',    'PG'),
('BA English',                          'BAEN',  3, 6, 'Arts',        'UG'),
('Bachelor of Multimedia & Animation',  'BMMA',  3, 6, 'Design',      'UG')
ON DUPLICATE KEY UPDATE course_name = VALUES(course_name);

-- ── 2. Make sure every course has all its fee_structure rows ──
-- Looked up by course_code (not hardcoded IDs), so this works no
-- matter what auto-increment IDs your courses ended up with.
INSERT IGNORE INTO fee_structure (course_id, semester, tuition_fee)
SELECT c.id, f.semester, f.tuition_fee
FROM courses c
JOIN (
  SELECT 'BTCE' AS course_code, 1 AS semester, 75000 AS tuition_fee
UNION ALL
  SELECT 'BTCE' AS course_code, 2 AS semester, 75000 AS tuition_fee
UNION ALL
  SELECT 'BTCE' AS course_code, 3 AS semester, 80000 AS tuition_fee
UNION ALL
  SELECT 'BTCE' AS course_code, 4 AS semester, 80000 AS tuition_fee
UNION ALL
  SELECT 'BTCE' AS course_code, 5 AS semester, 85000 AS tuition_fee
UNION ALL
  SELECT 'BTCE' AS course_code, 6 AS semester, 85000 AS tuition_fee
UNION ALL
  SELECT 'BTCE' AS course_code, 7 AS semester, 90000 AS tuition_fee
UNION ALL
  SELECT 'BTCE' AS course_code, 8 AS semester, 90000 AS tuition_fee
UNION ALL
  SELECT 'BTIT' AS course_code, 1 AS semester, 72000 AS tuition_fee
UNION ALL
  SELECT 'BTIT' AS course_code, 2 AS semester, 72000 AS tuition_fee
UNION ALL
  SELECT 'BTIT' AS course_code, 3 AS semester, 77000 AS tuition_fee
UNION ALL
  SELECT 'BTIT' AS course_code, 4 AS semester, 77000 AS tuition_fee
UNION ALL
  SELECT 'BTIT' AS course_code, 5 AS semester, 82000 AS tuition_fee
UNION ALL
  SELECT 'BTIT' AS course_code, 6 AS semester, 82000 AS tuition_fee
UNION ALL
  SELECT 'BTIT' AS course_code, 7 AS semester, 87000 AS tuition_fee
UNION ALL
  SELECT 'BTIT' AS course_code, 8 AS semester, 87000 AS tuition_fee
UNION ALL
  SELECT 'BTME' AS course_code, 1 AS semester, 68000 AS tuition_fee
UNION ALL
  SELECT 'BTME' AS course_code, 2 AS semester, 68000 AS tuition_fee
UNION ALL
  SELECT 'BTME' AS course_code, 3 AS semester, 72000 AS tuition_fee
UNION ALL
  SELECT 'BTME' AS course_code, 4 AS semester, 72000 AS tuition_fee
UNION ALL
  SELECT 'BTME' AS course_code, 5 AS semester, 76000 AS tuition_fee
UNION ALL
  SELECT 'BTME' AS course_code, 6 AS semester, 76000 AS tuition_fee
UNION ALL
  SELECT 'BTME' AS course_code, 7 AS semester, 80000 AS tuition_fee
UNION ALL
  SELECT 'BTME' AS course_code, 8 AS semester, 80000 AS tuition_fee
UNION ALL
  SELECT 'BTCV' AS course_code, 1 AS semester, 65000 AS tuition_fee
UNION ALL
  SELECT 'BTCV' AS course_code, 2 AS semester, 65000 AS tuition_fee
UNION ALL
  SELECT 'BTCV' AS course_code, 3 AS semester, 69000 AS tuition_fee
UNION ALL
  SELECT 'BTCV' AS course_code, 4 AS semester, 69000 AS tuition_fee
UNION ALL
  SELECT 'BTCV' AS course_code, 5 AS semester, 73000 AS tuition_fee
UNION ALL
  SELECT 'BTCV' AS course_code, 6 AS semester, 73000 AS tuition_fee
UNION ALL
  SELECT 'BTCV' AS course_code, 7 AS semester, 77000 AS tuition_fee
UNION ALL
  SELECT 'BTCV' AS course_code, 8 AS semester, 77000 AS tuition_fee
UNION ALL
  SELECT 'BTEC' AS course_code, 1 AS semester, 70000 AS tuition_fee
UNION ALL
  SELECT 'BTEC' AS course_code, 2 AS semester, 70000 AS tuition_fee
UNION ALL
  SELECT 'BTEC' AS course_code, 3 AS semester, 75000 AS tuition_fee
UNION ALL
  SELECT 'BTEC' AS course_code, 4 AS semester, 75000 AS tuition_fee
UNION ALL
  SELECT 'BTEC' AS course_code, 5 AS semester, 80000 AS tuition_fee
UNION ALL
  SELECT 'BTEC' AS course_code, 6 AS semester, 80000 AS tuition_fee
UNION ALL
  SELECT 'BTEC' AS course_code, 7 AS semester, 85000 AS tuition_fee
UNION ALL
  SELECT 'BTEC' AS course_code, 8 AS semester, 85000 AS tuition_fee
UNION ALL
  SELECT 'MTCE' AS course_code, 1 AS semester, 85000 AS tuition_fee
UNION ALL
  SELECT 'MTCE' AS course_code, 2 AS semester, 85000 AS tuition_fee
UNION ALL
  SELECT 'MTCE' AS course_code, 3 AS semester, 90000 AS tuition_fee
UNION ALL
  SELECT 'MTCE' AS course_code, 4 AS semester, 90000 AS tuition_fee
UNION ALL
  SELECT 'MTSE' AS course_code, 1 AS semester, 80000 AS tuition_fee
UNION ALL
  SELECT 'MTSE' AS course_code, 2 AS semester, 80000 AS tuition_fee
UNION ALL
  SELECT 'MTSE' AS course_code, 3 AS semester, 85000 AS tuition_fee
UNION ALL
  SELECT 'MTSE' AS course_code, 4 AS semester, 85000 AS tuition_fee
UNION ALL
  SELECT 'BCA' AS course_code, 1 AS semester, 40000 AS tuition_fee
UNION ALL
  SELECT 'BCA' AS course_code, 2 AS semester, 40000 AS tuition_fee
UNION ALL
  SELECT 'BCA' AS course_code, 3 AS semester, 44000 AS tuition_fee
UNION ALL
  SELECT 'BCA' AS course_code, 4 AS semester, 44000 AS tuition_fee
UNION ALL
  SELECT 'BCA' AS course_code, 5 AS semester, 48000 AS tuition_fee
UNION ALL
  SELECT 'BCA' AS course_code, 6 AS semester, 48000 AS tuition_fee
UNION ALL
  SELECT 'MCA' AS course_code, 1 AS semester, 55000 AS tuition_fee
UNION ALL
  SELECT 'MCA' AS course_code, 2 AS semester, 55000 AS tuition_fee
UNION ALL
  SELECT 'MCA' AS course_code, 3 AS semester, 60000 AS tuition_fee
UNION ALL
  SELECT 'MCA' AS course_code, 4 AS semester, 60000 AS tuition_fee
UNION ALL
  SELECT 'BSCIT' AS course_code, 1 AS semester, 35000 AS tuition_fee
UNION ALL
  SELECT 'BSCIT' AS course_code, 2 AS semester, 35000 AS tuition_fee
UNION ALL
  SELECT 'BSCIT' AS course_code, 3 AS semester, 38000 AS tuition_fee
UNION ALL
  SELECT 'BSCIT' AS course_code, 4 AS semester, 38000 AS tuition_fee
UNION ALL
  SELECT 'BSCIT' AS course_code, 5 AS semester, 42000 AS tuition_fee
UNION ALL
  SELECT 'BSCIT' AS course_code, 6 AS semester, 42000 AS tuition_fee
UNION ALL
  SELECT 'BBA' AS course_code, 1 AS semester, 38000 AS tuition_fee
UNION ALL
  SELECT 'BBA' AS course_code, 2 AS semester, 38000 AS tuition_fee
UNION ALL
  SELECT 'BBA' AS course_code, 3 AS semester, 42000 AS tuition_fee
UNION ALL
  SELECT 'BBA' AS course_code, 4 AS semester, 42000 AS tuition_fee
UNION ALL
  SELECT 'BBA' AS course_code, 5 AS semester, 46000 AS tuition_fee
UNION ALL
  SELECT 'BBA' AS course_code, 6 AS semester, 46000 AS tuition_fee
UNION ALL
  SELECT 'MBA' AS course_code, 1 AS semester, 65000 AS tuition_fee
UNION ALL
  SELECT 'MBA' AS course_code, 2 AS semester, 65000 AS tuition_fee
UNION ALL
  SELECT 'MBA' AS course_code, 3 AS semester, 72000 AS tuition_fee
UNION ALL
  SELECT 'MBA' AS course_code, 4 AS semester, 72000 AS tuition_fee
UNION ALL
  SELECT 'BCBA' AS course_code, 1 AS semester, 42000 AS tuition_fee
UNION ALL
  SELECT 'BCBA' AS course_code, 2 AS semester, 42000 AS tuition_fee
UNION ALL
  SELECT 'BCBA' AS course_code, 3 AS semester, 46000 AS tuition_fee
UNION ALL
  SELECT 'BCBA' AS course_code, 4 AS semester, 46000 AS tuition_fee
UNION ALL
  SELECT 'BCBA' AS course_code, 5 AS semester, 50000 AS tuition_fee
UNION ALL
  SELECT 'BCBA' AS course_code, 6 AS semester, 50000 AS tuition_fee
UNION ALL
  SELECT 'BSCMA' AS course_code, 1 AS semester, 30000 AS tuition_fee
UNION ALL
  SELECT 'BSCMA' AS course_code, 2 AS semester, 30000 AS tuition_fee
UNION ALL
  SELECT 'BSCMA' AS course_code, 3 AS semester, 33000 AS tuition_fee
UNION ALL
  SELECT 'BSCMA' AS course_code, 4 AS semester, 33000 AS tuition_fee
UNION ALL
  SELECT 'BSCMA' AS course_code, 5 AS semester, 36000 AS tuition_fee
UNION ALL
  SELECT 'BSCMA' AS course_code, 6 AS semester, 36000 AS tuition_fee
UNION ALL
  SELECT 'BSCPH' AS course_code, 1 AS semester, 32000 AS tuition_fee
UNION ALL
  SELECT 'BSCPH' AS course_code, 2 AS semester, 32000 AS tuition_fee
UNION ALL
  SELECT 'BSCPH' AS course_code, 3 AS semester, 35000 AS tuition_fee
UNION ALL
  SELECT 'BSCPH' AS course_code, 4 AS semester, 35000 AS tuition_fee
UNION ALL
  SELECT 'BSCPH' AS course_code, 5 AS semester, 38000 AS tuition_fee
UNION ALL
  SELECT 'BSCPH' AS course_code, 6 AS semester, 38000 AS tuition_fee
UNION ALL
  SELECT 'MSCDS' AS course_code, 1 AS semester, 60000 AS tuition_fee
UNION ALL
  SELECT 'MSCDS' AS course_code, 2 AS semester, 60000 AS tuition_fee
UNION ALL
  SELECT 'MSCDS' AS course_code, 3 AS semester, 65000 AS tuition_fee
UNION ALL
  SELECT 'MSCDS' AS course_code, 4 AS semester, 65000 AS tuition_fee
UNION ALL
  SELECT 'BCOM' AS course_code, 1 AS semester, 28000 AS tuition_fee
UNION ALL
  SELECT 'BCOM' AS course_code, 2 AS semester, 28000 AS tuition_fee
UNION ALL
  SELECT 'BCOM' AS course_code, 3 AS semester, 31000 AS tuition_fee
UNION ALL
  SELECT 'BCOM' AS course_code, 4 AS semester, 31000 AS tuition_fee
UNION ALL
  SELECT 'BCOM' AS course_code, 5 AS semester, 34000 AS tuition_fee
UNION ALL
  SELECT 'BCOM' AS course_code, 6 AS semester, 34000 AS tuition_fee
UNION ALL
  SELECT 'MCOM' AS course_code, 1 AS semester, 40000 AS tuition_fee
UNION ALL
  SELECT 'MCOM' AS course_code, 2 AS semester, 40000 AS tuition_fee
UNION ALL
  SELECT 'MCOM' AS course_code, 3 AS semester, 45000 AS tuition_fee
UNION ALL
  SELECT 'MCOM' AS course_code, 4 AS semester, 45000 AS tuition_fee
UNION ALL
  SELECT 'BAEN' AS course_code, 1 AS semester, 25000 AS tuition_fee
UNION ALL
  SELECT 'BAEN' AS course_code, 2 AS semester, 25000 AS tuition_fee
UNION ALL
  SELECT 'BAEN' AS course_code, 3 AS semester, 28000 AS tuition_fee
UNION ALL
  SELECT 'BAEN' AS course_code, 4 AS semester, 28000 AS tuition_fee
UNION ALL
  SELECT 'BAEN' AS course_code, 5 AS semester, 31000 AS tuition_fee
UNION ALL
  SELECT 'BAEN' AS course_code, 6 AS semester, 31000 AS tuition_fee
UNION ALL
  SELECT 'BMMA' AS course_code, 1 AS semester, 50000 AS tuition_fee
UNION ALL
  SELECT 'BMMA' AS course_code, 2 AS semester, 50000 AS tuition_fee
UNION ALL
  SELECT 'BMMA' AS course_code, 3 AS semester, 55000 AS tuition_fee
UNION ALL
  SELECT 'BMMA' AS course_code, 4 AS semester, 55000 AS tuition_fee
UNION ALL
  SELECT 'BMMA' AS course_code, 5 AS semester, 60000 AS tuition_fee
UNION ALL
  SELECT 'BMMA' AS course_code, 6 AS semester, 60000 AS tuition_fee
) f ON f.course_code = c.course_code;

-- ── 3. Finish the indexes schema_admission.sql couldn't create ──
-- (plain "CREATE INDEX IF NOT EXISTS" isn't valid on MySQL 5.7/8.0
-- the way it is on MariaDB, so we guard with information_schema)
DROP PROCEDURE IF EXISTS _create_index_if_missing;
DELIMITER $$
CREATE PROCEDURE _create_index_if_missing(IN tbl VARCHAR(64), IN idx VARCHAR(64), IN cols VARCHAR(255))
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = tbl
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = tbl AND INDEX_NAME = idx
  ) THEN
    SET @sql = CONCAT('CREATE INDEX ', idx, ' ON ', tbl, ' (', cols, ')');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END$$
DELIMITER ;

CALL _create_index_if_missing('students', 'idx_students_gr', 'gr_number');
CALL _create_index_if_missing('students', 'idx_students_email', 'email');
CALL _create_index_if_missing('fee_structure', 'idx_fee_course_sem', 'course_id, semester');

-- ── 4. Finish the transportation columns/indexes (if that file
--       stopped early with the same IF NOT EXISTS syntax error) ──
DROP PROCEDURE IF EXISTS _add_col_if_missing;
DELIMITER $$
CREATE PROCEDURE _add_col_if_missing(IN tbl VARCHAR(64), IN col VARCHAR(64), IN colDef VARCHAR(255))
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.TABLES
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = tbl
  ) AND NOT EXISTS (
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = tbl AND COLUMN_NAME = col
  ) THEN
    SET @sql = CONCAT('ALTER TABLE ', tbl, ' ADD COLUMN ', col, ' ', colDef);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END$$
DELIMITER ;

CALL _add_col_if_missing('students', 'transport_required', "ENUM('Yes','No') DEFAULT 'No' AFTER address");
CALL _add_col_if_missing('students', 'transport_location', 'VARCHAR(100) NULL AFTER transport_required');
CALL _add_col_if_missing('students', 'bus_number', 'VARCHAR(50) NULL AFTER transport_location');
CALL _add_col_if_missing('students', 'transport_fee', 'DECIMAL(10,2) DEFAULT 0 AFTER bus_number');

CALL _create_index_if_missing('transportation_routes', 'idx_transport_routes_status', 'status');
CALL _create_index_if_missing('students', 'idx_students_transport_location', 'transport_location');

-- ── 5. Also finish the profile_photo / salary columns that
--       schema_fee_management.sql never reached after aborting on
--       the duplicate idx_activity_created error ──
CALL _add_col_if_missing('students', 'profile_photo', 'VARCHAR(500) AFTER address');
CALL _add_col_if_missing('faculty', 'salary', 'DECIMAL(10,2) AFTER experience');

DROP PROCEDURE IF EXISTS _create_index_if_missing;
DROP PROCEDURE IF EXISTS _add_col_if_missing;

-- ── 6. Quick verification ──
SELECT (SELECT COUNT(*) FROM courses) AS total_courses,
       (SELECT COUNT(*) FROM fee_structure) AS total_fee_rows;