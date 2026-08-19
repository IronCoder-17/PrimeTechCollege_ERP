-- ============================================================
-- PrimeTech College — Courses & Fee Structure Seed Data
-- ============================================================


-- ── Courses ───────────────────────────────────────────────
INSERT INTO courses (course_name, course_code, duration_years, total_semesters, department, level) VALUES
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
('Bachelor of Multimedia & Animation',  'BMMA',  3, 6, 'Design',      'UG');

-- ── Fee Structure ─────────────────────────────────────────
-- B.Tech Computer Engineering (course_id = 1)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(1,1,75000),(1,2,75000),(1,3,80000),(1,4,80000),(1,5,85000),(1,6,85000),(1,7,90000),(1,8,90000);

-- B.Tech Information Technology (course_id = 2)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(2,1,72000),(2,2,72000),(2,3,77000),(2,4,77000),(2,5,82000),(2,6,82000),(2,7,87000),(2,8,87000);

-- B.Tech Mechanical Engineering (course_id = 3)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(3,1,68000),(3,2,68000),(3,3,72000),(3,4,72000),(3,5,76000),(3,6,76000),(3,7,80000),(3,8,80000);

-- B.Tech Civil Engineering (course_id = 4)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(4,1,65000),(4,2,65000),(4,3,69000),(4,4,69000),(4,5,73000),(4,6,73000),(4,7,77000),(4,8,77000);

-- B.Tech Electronics & Communication (course_id = 5)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(5,1,70000),(5,2,70000),(5,3,75000),(5,4,75000),(5,5,80000),(5,6,80000),(5,7,85000),(5,8,85000);

-- M.Tech Computer Engineering (course_id = 6)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(6,1,85000),(6,2,85000),(6,3,90000),(6,4,90000);

-- M.Tech Structural Engineering (course_id = 7)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(7,1,80000),(7,2,80000),(7,3,85000),(7,4,85000);

-- BCA (course_id = 8)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(8,1,40000),(8,2,40000),(8,3,44000),(8,4,44000),(8,5,48000),(8,6,48000);

-- MCA (course_id = 9)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(9,1,55000),(9,2,55000),(9,3,60000),(9,4,60000);

-- B.Sc Information Technology (course_id = 10)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(10,1,35000),(10,2,35000),(10,3,38000),(10,4,38000),(10,5,42000),(10,6,42000);

-- BBA (course_id = 11)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(11,1,38000),(11,2,38000),(11,3,42000),(11,4,42000),(11,5,46000),(11,6,46000);

-- MBA (course_id = 12)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(12,1,65000),(12,2,65000),(12,3,72000),(12,4,72000);

-- B.Com Business Analytics (course_id = 13)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(13,1,42000),(13,2,42000),(13,3,46000),(13,4,46000),(13,5,50000),(13,6,50000);

-- B.Sc Mathematics (course_id = 14)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(14,1,30000),(14,2,30000),(14,3,33000),(14,4,33000),(14,5,36000),(14,6,36000);

-- B.Sc Physics (course_id = 15)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(15,1,32000),(15,2,32000),(15,3,35000),(15,4,35000),(15,5,38000),(15,6,38000);

-- M.Sc Data Science (course_id = 16)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(16,1,60000),(16,2,60000),(16,3,65000),(16,4,65000);

-- B.Com (course_id = 17)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(17,1,28000),(17,2,28000),(17,3,31000),(17,4,31000),(17,5,34000),(17,6,34000);

-- M.Com (course_id = 18)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(18,1,40000),(18,2,40000),(18,3,45000),(18,4,45000);

-- BA English (course_id = 19)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(19,1,25000),(19,2,25000),(19,3,28000),(19,4,28000),(19,5,31000),(19,6,31000);

-- Bachelor of Multimedia & Animation (course_id = 20)
INSERT INTO fee_structure (course_id, semester, tuition_fee) VALUES
(20,1,50000),(20,2,50000),(20,3,55000),(20,4,55000),(20,5,60000),(20,6,60000);