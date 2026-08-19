-- ============================================================
-- Predefined (Constant) Timetable System — Seed Data
-- Auto-generated default timetables for all 20 courses / all semesters
-- ============================================================

-- ── Classrooms ─────────────────────────────────────────────
INSERT IGNORE INTO classrooms (room_code, department, capacity) VALUES
('A108', 'Arts', 60),
('A109', 'Arts', 60),
('A110', 'Arts', 60),
('A111', 'Arts', 60),
('A112', 'Arts', 60),
('A113', 'Arts', 60),
('C101', 'Computer & IT', 60),
('C105', 'Computer & IT', 60),
('C106', 'Computer & IT', 60),
('C107', 'Computer & IT', 60),
('C108', 'Computer & IT', 60),
('C109', 'Computer & IT', 60),
('C110', 'Computer & IT', 60),
('C111', 'Computer & IT', 60),
('C112', 'Computer & IT', 60),
('C113', 'Computer & IT', 60),
('C114', 'Computer & IT', 60),
('C115', 'Computer & IT', 60),
('C116', 'Computer & IT', 60),
('C118', 'Computer & IT', 60),
('C119', 'Computer & IT', 60),
('C120', 'Computer & IT', 60),
('CO101', 'Commerce', 60),
('CO102', 'Commerce', 60),
('CO103', 'Commerce', 60),
('CO104', 'Commerce', 60),
('CO114', 'Commerce', 60),
('CO115', 'Commerce', 60),
('CO116', 'Commerce', 60),
('CO117', 'Commerce', 60),
('CO118', 'Commerce', 60),
('CO119', 'Commerce', 60),
('D115', 'Design', 60),
('D116', 'Design', 60),
('D117', 'Design', 60),
('D118', 'Design', 60),
('D119', 'Design', 60),
('D120', 'Design', 60),
('E101', 'Engineering', 60),
('E102', 'Engineering', 60),
('E103', 'Engineering', 60),
('E104', 'Engineering', 60),
('E105', 'Engineering', 60),
('E106', 'Engineering', 60),
('E107', 'Engineering', 60),
('E108', 'Engineering', 60),
('E109', 'Engineering', 60),
('E110', 'Engineering', 60),
('E111', 'Engineering', 60),
('E112', 'Engineering', 60),
('E113', 'Engineering', 60),
('E114', 'Engineering', 60),
('E115', 'Engineering', 60),
('E116', 'Engineering', 60),
('E117', 'Engineering', 60),
('E118', 'Engineering', 60),
('E119', 'Engineering', 60),
('E120', 'Engineering', 60),
('M101', 'Management', 60),
('M102', 'Management', 60),
('M106', 'Management', 60),
('M107', 'Management', 60),
('M108', 'Management', 60),
('M109', 'Management', 60),
('M110', 'Management', 60),
('M111', 'Management', 60),
('M112', 'Management', 60),
('M113', 'Management', 60),
('M114', 'Management', 60),
('M115', 'Management', 60),
('M116', 'Management', 60),
('M117', 'Management', 60),
('M119', 'Management', 60),
('M120', 'Management', 60),
('S101', 'Science', 60),
('S102', 'Science', 60),
('S103', 'Science', 60),
('S104', 'Science', 60),
('S105', 'Science', 60),
('S107', 'Science', 60),
('S108', 'Science', 60),
('S109', 'Science', 60),
('S110', 'Science', 60),
('S113', 'Science', 60),
('S114', 'Science', 60),
('S115', 'Science', 60),
('S116', 'Science', 60),
('S117', 'Science', 60),
('S118', 'Science', 60),
('S120', 'Science', 60);

-- ── Timetable Subjects (per course & semester) ──────────────
INSERT IGNORE INTO tt_subjects (course_id, semester, subject_code, subject_name, faculty_name) 
SELECT c.id, s.semester, s.subject_code, s.subject_name, s.faculty_name FROM (
SELECT 'BTCE' course_code, 1 semester, 'BTCE101' subject_code, 'Programming Fundamentals' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'BTCE102' subject_code, 'Data Structures' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'BTCE103' subject_code, 'Database Management Systems' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'BTCE104' subject_code, 'Operating Systems' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'BTCE105' subject_code, 'Computer Networks' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'BTCE106' subject_code, 'Software Engineering' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'BTCE201' subject_code, 'Database Management Systems' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'BTCE202' subject_code, 'Operating Systems' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'BTCE203' subject_code, 'Computer Networks' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'BTCE204' subject_code, 'Software Engineering' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'BTCE205' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'BTCE206' subject_code, 'Machine Learning' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'BTCE301' subject_code, 'Computer Networks' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'BTCE302' subject_code, 'Software Engineering' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'BTCE303' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'BTCE304' subject_code, 'Machine Learning' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'BTCE305' subject_code, 'Cloud Computing' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'BTCE306' subject_code, 'Cyber Security' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'BTCE401' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'BTCE402' subject_code, 'Machine Learning' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'BTCE403' subject_code, 'Cloud Computing' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'BTCE404' subject_code, 'Cyber Security' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'BTCE405' subject_code, 'Programming Fundamentals' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'BTCE406' subject_code, 'Data Structures' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'BTCE501' subject_code, 'Cloud Computing' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'BTCE502' subject_code, 'Cyber Security' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'BTCE503' subject_code, 'Programming Fundamentals' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'BTCE504' subject_code, 'Data Structures' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'BTCE505' subject_code, 'Database Management Systems' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'BTCE506' subject_code, 'Operating Systems' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'BTCE601' subject_code, 'Programming Fundamentals' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'BTCE602' subject_code, 'Data Structures' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'BTCE603' subject_code, 'Database Management Systems' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'BTCE604' subject_code, 'Operating Systems' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'BTCE605' subject_code, 'Computer Networks' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'BTCE606' subject_code, 'Software Engineering' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'BTCE701' subject_code, 'Database Management Systems' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'BTCE702' subject_code, 'Operating Systems' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'BTCE703' subject_code, 'Computer Networks' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'BTCE704' subject_code, 'Software Engineering' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'BTCE705' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'BTCE706' subject_code, 'Machine Learning' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'BTCE801' subject_code, 'Computer Networks' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'BTCE802' subject_code, 'Software Engineering' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'BTCE803' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'BTCE804' subject_code, 'Machine Learning' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'BTCE805' subject_code, 'Cloud Computing' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'BTCE806' subject_code, 'Cyber Security' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'BTIT101' subject_code, 'Programming in C' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'BTIT102' subject_code, 'Data Structures' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'BTIT103' subject_code, 'Database Systems' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'BTIT104' subject_code, 'Computer Networks' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'BTIT105' subject_code, 'Web Technologies' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'BTIT106' subject_code, 'Cloud Computing' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'BTIT201' subject_code, 'Database Systems' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'BTIT202' subject_code, 'Computer Networks' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'BTIT203' subject_code, 'Web Technologies' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'BTIT204' subject_code, 'Cloud Computing' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'BTIT205' subject_code, 'Information Security' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'BTIT206' subject_code, 'Mobile Application Development' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'BTIT301' subject_code, 'Web Technologies' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'BTIT302' subject_code, 'Cloud Computing' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'BTIT303' subject_code, 'Information Security' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'BTIT304' subject_code, 'Mobile Application Development' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'BTIT305' subject_code, 'Programming in C' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'BTIT306' subject_code, 'Data Structures' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'BTIT401' subject_code, 'Information Security' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'BTIT402' subject_code, 'Mobile Application Development' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'BTIT403' subject_code, 'Programming in C' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'BTIT404' subject_code, 'Data Structures' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'BTIT405' subject_code, 'Database Systems' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'BTIT406' subject_code, 'Computer Networks' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'BTIT501' subject_code, 'Programming in C' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'BTIT502' subject_code, 'Data Structures' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'BTIT503' subject_code, 'Database Systems' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'BTIT504' subject_code, 'Computer Networks' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'BTIT505' subject_code, 'Web Technologies' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'BTIT506' subject_code, 'Cloud Computing' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'BTIT601' subject_code, 'Database Systems' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'BTIT602' subject_code, 'Computer Networks' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'BTIT603' subject_code, 'Web Technologies' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'BTIT604' subject_code, 'Cloud Computing' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'BTIT605' subject_code, 'Information Security' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'BTIT606' subject_code, 'Mobile Application Development' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'BTIT701' subject_code, 'Web Technologies' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'BTIT702' subject_code, 'Cloud Computing' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'BTIT703' subject_code, 'Information Security' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'BTIT704' subject_code, 'Mobile Application Development' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'BTIT705' subject_code, 'Programming in C' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'BTIT706' subject_code, 'Data Structures' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'BTIT801' subject_code, 'Information Security' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'BTIT802' subject_code, 'Mobile Application Development' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'BTIT803' subject_code, 'Programming in C' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'BTIT804' subject_code, 'Data Structures' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'BTIT805' subject_code, 'Database Systems' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'BTIT806' subject_code, 'Computer Networks' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'BTME101' subject_code, 'Engineering Mechanics' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'BTME102' subject_code, 'Thermodynamics' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'BTME103' subject_code, 'Manufacturing Technology' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'BTME104' subject_code, 'Fluid Mechanics' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'BTME105' subject_code, 'Machine Design' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'BTME106' subject_code, 'CAD/CAM' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'BTME201' subject_code, 'Manufacturing Technology' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'BTME202' subject_code, 'Fluid Mechanics' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'BTME203' subject_code, 'Machine Design' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'BTME204' subject_code, 'CAD/CAM' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'BTME205' subject_code, 'Heat Transfer' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'BTME206' subject_code, 'Industrial Engineering' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'BTME301' subject_code, 'Machine Design' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'BTME302' subject_code, 'CAD/CAM' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'BTME303' subject_code, 'Heat Transfer' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'BTME304' subject_code, 'Industrial Engineering' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'BTME305' subject_code, 'Engineering Mechanics' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'BTME306' subject_code, 'Thermodynamics' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'BTME401' subject_code, 'Heat Transfer' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'BTME402' subject_code, 'Industrial Engineering' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'BTME403' subject_code, 'Engineering Mechanics' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'BTME404' subject_code, 'Thermodynamics' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'BTME405' subject_code, 'Manufacturing Technology' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'BTME406' subject_code, 'Fluid Mechanics' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'BTME501' subject_code, 'Engineering Mechanics' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'BTME502' subject_code, 'Thermodynamics' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'BTME503' subject_code, 'Manufacturing Technology' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'BTME504' subject_code, 'Fluid Mechanics' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'BTME505' subject_code, 'Machine Design' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'BTME506' subject_code, 'CAD/CAM' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'BTME601' subject_code, 'Manufacturing Technology' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'BTME602' subject_code, 'Fluid Mechanics' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'BTME603' subject_code, 'Machine Design' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'BTME604' subject_code, 'CAD/CAM' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'BTME605' subject_code, 'Heat Transfer' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'BTME606' subject_code, 'Industrial Engineering' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'BTME701' subject_code, 'Machine Design' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'BTME702' subject_code, 'CAD/CAM' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'BTME703' subject_code, 'Heat Transfer' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'BTME704' subject_code, 'Industrial Engineering' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'BTME705' subject_code, 'Engineering Mechanics' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'BTME706' subject_code, 'Thermodynamics' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'BTME801' subject_code, 'Heat Transfer' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'BTME802' subject_code, 'Industrial Engineering' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'BTME803' subject_code, 'Engineering Mechanics' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'BTME804' subject_code, 'Thermodynamics' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'BTME805' subject_code, 'Manufacturing Technology' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'BTME806' subject_code, 'Fluid Mechanics' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'BTCV101' subject_code, 'Surveying' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'BTCV102' subject_code, 'Structural Analysis' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'BTCV103' subject_code, 'RCC Design' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'BTCV104' subject_code, 'Geotechnical Engineering' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'BTCV105' subject_code, 'Environmental Engineering' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'BTCV106' subject_code, 'Transportation Engineering' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'BTCV201' subject_code, 'RCC Design' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'BTCV202' subject_code, 'Geotechnical Engineering' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'BTCV203' subject_code, 'Environmental Engineering' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'BTCV204' subject_code, 'Transportation Engineering' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'BTCV205' subject_code, 'Concrete Technology' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'BTCV206' subject_code, 'Surveying' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'BTCV301' subject_code, 'Environmental Engineering' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'BTCV302' subject_code, 'Transportation Engineering' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'BTCV303' subject_code, 'Concrete Technology' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'BTCV304' subject_code, 'Surveying' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'BTCV305' subject_code, 'Structural Analysis' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'BTCV306' subject_code, 'RCC Design' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'BTCV401' subject_code, 'Concrete Technology' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'BTCV402' subject_code, 'Surveying' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'BTCV403' subject_code, 'Structural Analysis' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'BTCV404' subject_code, 'RCC Design' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'BTCV405' subject_code, 'Geotechnical Engineering' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'BTCV406' subject_code, 'Environmental Engineering' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'BTCV501' subject_code, 'Structural Analysis' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'BTCV502' subject_code, 'RCC Design' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'BTCV503' subject_code, 'Geotechnical Engineering' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'BTCV504' subject_code, 'Environmental Engineering' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'BTCV505' subject_code, 'Transportation Engineering' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'BTCV506' subject_code, 'Concrete Technology' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'BTCV601' subject_code, 'Geotechnical Engineering' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'BTCV602' subject_code, 'Environmental Engineering' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'BTCV603' subject_code, 'Transportation Engineering' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'BTCV604' subject_code, 'Concrete Technology' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'BTCV605' subject_code, 'Surveying' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'BTCV606' subject_code, 'Structural Analysis' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'BTCV701' subject_code, 'Transportation Engineering' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'BTCV702' subject_code, 'Concrete Technology' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'BTCV703' subject_code, 'Surveying' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'BTCV704' subject_code, 'Structural Analysis' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'BTCV705' subject_code, 'RCC Design' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'BTCV706' subject_code, 'Geotechnical Engineering' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'BTCV801' subject_code, 'Surveying' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'BTCV802' subject_code, 'Structural Analysis' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'BTCV803' subject_code, 'RCC Design' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'BTCV804' subject_code, 'Geotechnical Engineering' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'BTCV805' subject_code, 'Environmental Engineering' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'BTCV806' subject_code, 'Transportation Engineering' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'BTEC101' subject_code, 'Digital Electronics' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'BTEC102' subject_code, 'Analog Electronics' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'BTEC103' subject_code, 'Signals & Systems' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'BTEC104' subject_code, 'Microprocessors' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'BTEC105' subject_code, 'Embedded Systems' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'BTEC106' subject_code, 'VLSI Design' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'BTEC201' subject_code, 'Signals & Systems' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'BTEC202' subject_code, 'Microprocessors' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'BTEC203' subject_code, 'Embedded Systems' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'BTEC204' subject_code, 'VLSI Design' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'BTEC205' subject_code, 'Wireless Communication' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'BTEC206' subject_code, 'Digital Electronics' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'BTEC301' subject_code, 'Embedded Systems' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'BTEC302' subject_code, 'VLSI Design' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'BTEC303' subject_code, 'Wireless Communication' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'BTEC304' subject_code, 'Digital Electronics' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'BTEC305' subject_code, 'Analog Electronics' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'BTEC306' subject_code, 'Signals & Systems' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'BTEC401' subject_code, 'Wireless Communication' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'BTEC402' subject_code, 'Digital Electronics' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'BTEC403' subject_code, 'Analog Electronics' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'BTEC404' subject_code, 'Signals & Systems' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'BTEC405' subject_code, 'Microprocessors' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'BTEC406' subject_code, 'Embedded Systems' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'BTEC501' subject_code, 'Analog Electronics' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'BTEC502' subject_code, 'Signals & Systems' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'BTEC503' subject_code, 'Microprocessors' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'BTEC504' subject_code, 'Embedded Systems' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'BTEC505' subject_code, 'VLSI Design' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'BTEC506' subject_code, 'Wireless Communication' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'BTEC601' subject_code, 'Microprocessors' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'BTEC602' subject_code, 'Embedded Systems' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'BTEC603' subject_code, 'VLSI Design' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'BTEC604' subject_code, 'Wireless Communication' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'BTEC605' subject_code, 'Digital Electronics' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'BTEC606' subject_code, 'Analog Electronics' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'BTEC701' subject_code, 'VLSI Design' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'BTEC702' subject_code, 'Wireless Communication' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'BTEC703' subject_code, 'Digital Electronics' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'BTEC704' subject_code, 'Analog Electronics' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'BTEC705' subject_code, 'Signals & Systems' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'BTEC706' subject_code, 'Microprocessors' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'BTEC801' subject_code, 'Digital Electronics' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'BTEC802' subject_code, 'Analog Electronics' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'BTEC803' subject_code, 'Signals & Systems' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'BTEC804' subject_code, 'Microprocessors' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'BTEC805' subject_code, 'Embedded Systems' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'BTEC806' subject_code, 'VLSI Design' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'MTCE101' subject_code, 'Advanced Algorithms' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'MTCE102' subject_code, 'Distributed Systems' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'MTCE103' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'MTCE104' subject_code, 'Cloud Computing' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'MTCE105' subject_code, 'Research Methodology' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'MTCE201' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'MTCE202' subject_code, 'Cloud Computing' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'MTCE203' subject_code, 'Research Methodology' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'MTCE204' subject_code, 'Advanced Algorithms' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'MTCE205' subject_code, 'Distributed Systems' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'MTCE301' subject_code, 'Research Methodology' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'MTCE302' subject_code, 'Advanced Algorithms' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'MTCE303' subject_code, 'Distributed Systems' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'MTCE304' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'MTCE305' subject_code, 'Cloud Computing' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'MTCE401' subject_code, 'Distributed Systems' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'MTCE402' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'MTCE403' subject_code, 'Cloud Computing' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'MTCE404' subject_code, 'Research Methodology' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'MTCE405' subject_code, 'Advanced Algorithms' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'MTSE101' subject_code, 'Advanced RCC' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'MTSE102' subject_code, 'Structural Dynamics' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'MTSE103' subject_code, 'Earthquake Engineering' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'MTSE104' subject_code, 'Finite Element Analysis' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'MTSE105' subject_code, 'Bridge Engineering' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'MTSE201' subject_code, 'Earthquake Engineering' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'MTSE202' subject_code, 'Finite Element Analysis' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'MTSE203' subject_code, 'Bridge Engineering' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'MTSE204' subject_code, 'Advanced RCC' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'MTSE205' subject_code, 'Structural Dynamics' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'MTSE301' subject_code, 'Bridge Engineering' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'MTSE302' subject_code, 'Advanced RCC' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'MTSE303' subject_code, 'Structural Dynamics' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'MTSE304' subject_code, 'Earthquake Engineering' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'MTSE305' subject_code, 'Finite Element Analysis' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'MTSE401' subject_code, 'Structural Dynamics' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'MTSE402' subject_code, 'Earthquake Engineering' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'MTSE403' subject_code, 'Finite Element Analysis' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'MTSE404' subject_code, 'Bridge Engineering' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'MTSE405' subject_code, 'Advanced RCC' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'BCA101' subject_code, 'C Programming' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'BCA102' subject_code, 'Java Programming' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'BCA103' subject_code, 'Python Programming' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'BCA104' subject_code, 'DBMS' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'BCA105' subject_code, 'Data Structures' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'BCA106' subject_code, 'Web Development' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'BCA201' subject_code, 'Python Programming' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'BCA202' subject_code, 'DBMS' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'BCA203' subject_code, 'Data Structures' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'BCA204' subject_code, 'Web Development' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'BCA205' subject_code, 'C Programming' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'BCA206' subject_code, 'Java Programming' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'BCA301' subject_code, 'Data Structures' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'BCA302' subject_code, 'Web Development' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'BCA303' subject_code, 'C Programming' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'BCA304' subject_code, 'Java Programming' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'BCA305' subject_code, 'Python Programming' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'BCA306' subject_code, 'DBMS' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'BCA401' subject_code, 'C Programming' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'BCA402' subject_code, 'Java Programming' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'BCA403' subject_code, 'Python Programming' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'BCA404' subject_code, 'DBMS' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'BCA405' subject_code, 'Data Structures' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'BCA406' subject_code, 'Web Development' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'BCA501' subject_code, 'Python Programming' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'BCA502' subject_code, 'DBMS' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'BCA503' subject_code, 'Data Structures' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'BCA504' subject_code, 'Web Development' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'BCA505' subject_code, 'C Programming' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'BCA506' subject_code, 'Java Programming' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'BCA601' subject_code, 'Data Structures' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'BCA602' subject_code, 'Web Development' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'BCA603' subject_code, 'C Programming' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'BCA604' subject_code, 'Java Programming' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'BCA605' subject_code, 'Python Programming' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'BCA606' subject_code, 'DBMS' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'MCA101' subject_code, 'Advanced Java' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'MCA102' subject_code, 'Data Mining' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'MCA103' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'MCA104' subject_code, 'Cloud Computing' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'MCA105' subject_code, 'Mobile Computing' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'MCA106' subject_code, 'Software Testing' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'MCA201' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'MCA202' subject_code, 'Cloud Computing' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'MCA203' subject_code, 'Mobile Computing' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'MCA204' subject_code, 'Software Testing' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'MCA205' subject_code, 'Advanced Java' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'MCA206' subject_code, 'Data Mining' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'MCA301' subject_code, 'Mobile Computing' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'MCA302' subject_code, 'Software Testing' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'MCA303' subject_code, 'Advanced Java' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'MCA304' subject_code, 'Data Mining' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'MCA305' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'MCA306' subject_code, 'Cloud Computing' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'MCA401' subject_code, 'Advanced Java' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'MCA402' subject_code, 'Data Mining' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'MCA403' subject_code, 'Artificial Intelligence' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'MCA404' subject_code, 'Cloud Computing' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'MCA405' subject_code, 'Mobile Computing' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'MCA406' subject_code, 'Software Testing' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'BSCIT101' subject_code, 'Computer Fundamentals' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'BSCIT102' subject_code, 'Programming' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'BSCIT103' subject_code, 'Database Systems' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'BSCIT104' subject_code, 'Networking' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'BSCIT105' subject_code, 'Cyber Security' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'BSCIT106' subject_code, 'Software Engineering' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'BSCIT201' subject_code, 'Database Systems' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'BSCIT202' subject_code, 'Networking' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'BSCIT203' subject_code, 'Cyber Security' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'BSCIT204' subject_code, 'Software Engineering' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'BSCIT205' subject_code, 'Computer Fundamentals' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'BSCIT206' subject_code, 'Programming' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'BSCIT301' subject_code, 'Cyber Security' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'BSCIT302' subject_code, 'Software Engineering' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'BSCIT303' subject_code, 'Computer Fundamentals' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'BSCIT304' subject_code, 'Programming' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'BSCIT305' subject_code, 'Database Systems' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'BSCIT306' subject_code, 'Networking' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'BSCIT401' subject_code, 'Computer Fundamentals' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'BSCIT402' subject_code, 'Programming' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'BSCIT403' subject_code, 'Database Systems' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'BSCIT404' subject_code, 'Networking' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'BSCIT405' subject_code, 'Cyber Security' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'BSCIT406' subject_code, 'Software Engineering' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'BSCIT501' subject_code, 'Database Systems' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'BSCIT502' subject_code, 'Networking' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'BSCIT503' subject_code, 'Cyber Security' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'BSCIT504' subject_code, 'Software Engineering' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'BSCIT505' subject_code, 'Computer Fundamentals' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'BSCIT506' subject_code, 'Programming' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'BSCIT601' subject_code, 'Cyber Security' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'BSCIT602' subject_code, 'Software Engineering' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'BSCIT603' subject_code, 'Computer Fundamentals' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'BSCIT604' subject_code, 'Programming' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'BSCIT605' subject_code, 'Database Systems' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'BSCIT606' subject_code, 'Networking' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'BBA101' subject_code, 'Principles of Management' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'BBA102' subject_code, 'Business Economics' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'BBA103' subject_code, 'Accounting' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'BBA104' subject_code, 'Marketing' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'BBA105' subject_code, 'Entrepreneurship' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'BBA106' subject_code, 'Business Communication' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'BBA201' subject_code, 'Accounting' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'BBA202' subject_code, 'Marketing' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'BBA203' subject_code, 'Entrepreneurship' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'BBA204' subject_code, 'Business Communication' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'BBA205' subject_code, 'Principles of Management' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'BBA206' subject_code, 'Business Economics' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'BBA301' subject_code, 'Entrepreneurship' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'BBA302' subject_code, 'Business Communication' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'BBA303' subject_code, 'Principles of Management' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'BBA304' subject_code, 'Business Economics' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'BBA305' subject_code, 'Accounting' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'BBA306' subject_code, 'Marketing' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'BBA401' subject_code, 'Principles of Management' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'BBA402' subject_code, 'Business Economics' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'BBA403' subject_code, 'Accounting' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'BBA404' subject_code, 'Marketing' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'BBA405' subject_code, 'Entrepreneurship' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'BBA406' subject_code, 'Business Communication' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'BBA501' subject_code, 'Accounting' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'BBA502' subject_code, 'Marketing' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'BBA503' subject_code, 'Entrepreneurship' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'BBA504' subject_code, 'Business Communication' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'BBA505' subject_code, 'Principles of Management' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'BBA506' subject_code, 'Business Economics' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'BBA601' subject_code, 'Entrepreneurship' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'BBA602' subject_code, 'Business Communication' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'BBA603' subject_code, 'Principles of Management' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'BBA604' subject_code, 'Business Economics' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'BBA605' subject_code, 'Accounting' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'BBA606' subject_code, 'Marketing' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'MBA101' subject_code, 'Marketing Management' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'MBA102' subject_code, 'Human Resource Management' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'MBA103' subject_code, 'Financial Management' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'MBA104' subject_code, 'Operations Management' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'MBA105' subject_code, 'Strategic Management' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'MBA106' subject_code, 'Business Analytics' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'MBA201' subject_code, 'Financial Management' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'MBA202' subject_code, 'Operations Management' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'MBA203' subject_code, 'Strategic Management' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'MBA204' subject_code, 'Business Analytics' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'MBA205' subject_code, 'Marketing Management' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'MBA206' subject_code, 'Human Resource Management' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'MBA301' subject_code, 'Strategic Management' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'MBA302' subject_code, 'Business Analytics' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'MBA303' subject_code, 'Marketing Management' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'MBA304' subject_code, 'Human Resource Management' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'MBA305' subject_code, 'Financial Management' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'MBA306' subject_code, 'Operations Management' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'MBA401' subject_code, 'Marketing Management' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'MBA402' subject_code, 'Human Resource Management' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'MBA403' subject_code, 'Financial Management' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'MBA404' subject_code, 'Operations Management' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'MBA405' subject_code, 'Strategic Management' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'MBA406' subject_code, 'Business Analytics' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'BCBA101' subject_code, 'Financial Accounting' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'BCBA102' subject_code, 'Statistics' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'BCBA103' subject_code, 'Business Analytics' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'BCBA104' subject_code, 'Cost Accounting' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'BCBA105' subject_code, 'Taxation' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'BCBA106' subject_code, 'Auditing' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'BCBA201' subject_code, 'Business Analytics' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'BCBA202' subject_code, 'Cost Accounting' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'BCBA203' subject_code, 'Taxation' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'BCBA204' subject_code, 'Auditing' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'BCBA205' subject_code, 'Financial Accounting' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'BCBA206' subject_code, 'Statistics' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'BCBA301' subject_code, 'Taxation' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'BCBA302' subject_code, 'Auditing' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'BCBA303' subject_code, 'Financial Accounting' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'BCBA304' subject_code, 'Statistics' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'BCBA305' subject_code, 'Business Analytics' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'BCBA306' subject_code, 'Cost Accounting' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'BCBA401' subject_code, 'Financial Accounting' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'BCBA402' subject_code, 'Statistics' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'BCBA403' subject_code, 'Business Analytics' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'BCBA404' subject_code, 'Cost Accounting' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'BCBA405' subject_code, 'Taxation' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'BCBA406' subject_code, 'Auditing' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'BCBA501' subject_code, 'Business Analytics' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'BCBA502' subject_code, 'Cost Accounting' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'BCBA503' subject_code, 'Taxation' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'BCBA504' subject_code, 'Auditing' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'BCBA505' subject_code, 'Financial Accounting' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'BCBA506' subject_code, 'Statistics' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'BCBA601' subject_code, 'Taxation' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'BCBA602' subject_code, 'Auditing' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'BCBA603' subject_code, 'Financial Accounting' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'BCBA604' subject_code, 'Statistics' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'BCBA605' subject_code, 'Business Analytics' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'BCBA606' subject_code, 'Cost Accounting' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'BSCMA101' subject_code, 'Algebra' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'BSCMA102' subject_code, 'Calculus' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'BSCMA103' subject_code, 'Linear Algebra' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'BSCMA104' subject_code, 'Probability' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'BSCMA105' subject_code, 'Statistics' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'BSCMA106' subject_code, 'Differential Equations' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'BSCMA201' subject_code, 'Linear Algebra' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'BSCMA202' subject_code, 'Probability' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'BSCMA203' subject_code, 'Statistics' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'BSCMA204' subject_code, 'Differential Equations' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'BSCMA205' subject_code, 'Algebra' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'BSCMA206' subject_code, 'Calculus' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'BSCMA301' subject_code, 'Statistics' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'BSCMA302' subject_code, 'Differential Equations' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'BSCMA303' subject_code, 'Algebra' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'BSCMA304' subject_code, 'Calculus' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'BSCMA305' subject_code, 'Linear Algebra' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'BSCMA306' subject_code, 'Probability' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'BSCMA401' subject_code, 'Algebra' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'BSCMA402' subject_code, 'Calculus' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'BSCMA403' subject_code, 'Linear Algebra' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'BSCMA404' subject_code, 'Probability' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'BSCMA405' subject_code, 'Statistics' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'BSCMA406' subject_code, 'Differential Equations' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'BSCMA501' subject_code, 'Linear Algebra' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'BSCMA502' subject_code, 'Probability' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'BSCMA503' subject_code, 'Statistics' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'BSCMA504' subject_code, 'Differential Equations' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'BSCMA505' subject_code, 'Algebra' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'BSCMA506' subject_code, 'Calculus' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'BSCMA601' subject_code, 'Statistics' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'BSCMA602' subject_code, 'Differential Equations' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'BSCMA603' subject_code, 'Algebra' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'BSCMA604' subject_code, 'Calculus' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'BSCMA605' subject_code, 'Linear Algebra' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'BSCMA606' subject_code, 'Probability' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'BSCPH101' subject_code, 'Mechanics' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'BSCPH102' subject_code, 'Electromagnetics' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'BSCPH103' subject_code, 'Optics' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'BSCPH104' subject_code, 'Thermodynamics' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'BSCPH105' subject_code, 'Quantum Physics' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'BSCPH106' subject_code, 'Electronics' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'BSCPH201' subject_code, 'Optics' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'BSCPH202' subject_code, 'Thermodynamics' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'BSCPH203' subject_code, 'Quantum Physics' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'BSCPH204' subject_code, 'Electronics' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'BSCPH205' subject_code, 'Mechanics' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'BSCPH206' subject_code, 'Electromagnetics' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'BSCPH301' subject_code, 'Quantum Physics' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'BSCPH302' subject_code, 'Electronics' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'BSCPH303' subject_code, 'Mechanics' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'BSCPH304' subject_code, 'Electromagnetics' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'BSCPH305' subject_code, 'Optics' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'BSCPH306' subject_code, 'Thermodynamics' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'BSCPH401' subject_code, 'Mechanics' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'BSCPH402' subject_code, 'Electromagnetics' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'BSCPH403' subject_code, 'Optics' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'BSCPH404' subject_code, 'Thermodynamics' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'BSCPH405' subject_code, 'Quantum Physics' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'BSCPH406' subject_code, 'Electronics' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'BSCPH501' subject_code, 'Optics' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'BSCPH502' subject_code, 'Thermodynamics' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'BSCPH503' subject_code, 'Quantum Physics' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'BSCPH504' subject_code, 'Electronics' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'BSCPH505' subject_code, 'Mechanics' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'BSCPH506' subject_code, 'Electromagnetics' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'BSCPH601' subject_code, 'Quantum Physics' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'BSCPH602' subject_code, 'Electronics' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'BSCPH603' subject_code, 'Mechanics' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'BSCPH604' subject_code, 'Electromagnetics' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'BSCPH605' subject_code, 'Optics' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'BSCPH606' subject_code, 'Thermodynamics' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'MSCDS101' subject_code, 'Machine Learning' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'MSCDS102' subject_code, 'Deep Learning' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'MSCDS103' subject_code, 'Data Mining' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'MSCDS104' subject_code, 'Big Data Analytics' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'MSCDS105' subject_code, 'Data Visualization' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'MSCDS106' subject_code, 'Natural Language Processing' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'MSCDS201' subject_code, 'Data Mining' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'MSCDS202' subject_code, 'Big Data Analytics' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'MSCDS203' subject_code, 'Data Visualization' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'MSCDS204' subject_code, 'Natural Language Processing' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'MSCDS205' subject_code, 'Machine Learning' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'MSCDS206' subject_code, 'Deep Learning' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'MSCDS301' subject_code, 'Data Visualization' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'MSCDS302' subject_code, 'Natural Language Processing' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'MSCDS303' subject_code, 'Machine Learning' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'MSCDS304' subject_code, 'Deep Learning' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'MSCDS305' subject_code, 'Data Mining' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'MSCDS306' subject_code, 'Big Data Analytics' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'MSCDS401' subject_code, 'Machine Learning' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'MSCDS402' subject_code, 'Deep Learning' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'MSCDS403' subject_code, 'Data Mining' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'MSCDS404' subject_code, 'Big Data Analytics' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'MSCDS405' subject_code, 'Data Visualization' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'MSCDS406' subject_code, 'Natural Language Processing' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'BCOM101' subject_code, 'Financial Accounting' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'BCOM102' subject_code, 'Business Law' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'BCOM103' subject_code, 'Economics' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'BCOM104' subject_code, 'Taxation' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'BCOM105' subject_code, 'Auditing' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'BCOM106' subject_code, 'Cost Accounting' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'BCOM201' subject_code, 'Economics' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'BCOM202' subject_code, 'Taxation' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'BCOM203' subject_code, 'Auditing' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'BCOM204' subject_code, 'Cost Accounting' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'BCOM205' subject_code, 'Financial Accounting' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'BCOM206' subject_code, 'Business Law' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'BCOM301' subject_code, 'Auditing' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'BCOM302' subject_code, 'Cost Accounting' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'BCOM303' subject_code, 'Financial Accounting' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'BCOM304' subject_code, 'Business Law' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'BCOM305' subject_code, 'Economics' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'BCOM306' subject_code, 'Taxation' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'BCOM401' subject_code, 'Financial Accounting' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'BCOM402' subject_code, 'Business Law' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'BCOM403' subject_code, 'Economics' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'BCOM404' subject_code, 'Taxation' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'BCOM405' subject_code, 'Auditing' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'BCOM406' subject_code, 'Cost Accounting' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'BCOM501' subject_code, 'Economics' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'BCOM502' subject_code, 'Taxation' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'BCOM503' subject_code, 'Auditing' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'BCOM504' subject_code, 'Cost Accounting' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'BCOM505' subject_code, 'Financial Accounting' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'BCOM506' subject_code, 'Business Law' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'BCOM601' subject_code, 'Auditing' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'BCOM602' subject_code, 'Cost Accounting' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'BCOM603' subject_code, 'Financial Accounting' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'BCOM604' subject_code, 'Business Law' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'BCOM605' subject_code, 'Economics' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'BCOM606' subject_code, 'Taxation' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'MCOM101' subject_code, 'Advanced Accounting' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'MCOM102' subject_code, 'Corporate Finance' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'MCOM103' subject_code, 'International Business' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'MCOM104' subject_code, 'Banking' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'MCOM105' subject_code, 'Research Methodology' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'MCOM201' subject_code, 'International Business' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'MCOM202' subject_code, 'Banking' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'MCOM203' subject_code, 'Research Methodology' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'MCOM204' subject_code, 'Advanced Accounting' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'MCOM205' subject_code, 'Corporate Finance' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'MCOM301' subject_code, 'Research Methodology' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'MCOM302' subject_code, 'Advanced Accounting' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'MCOM303' subject_code, 'Corporate Finance' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'MCOM304' subject_code, 'International Business' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'MCOM305' subject_code, 'Banking' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'MCOM401' subject_code, 'Corporate Finance' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'MCOM402' subject_code, 'International Business' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'MCOM403' subject_code, 'Banking' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'MCOM404' subject_code, 'Research Methodology' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'MCOM405' subject_code, 'Advanced Accounting' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'BAEN101' subject_code, 'English Literature' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'BAEN102' subject_code, 'Grammar' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'BAEN103' subject_code, 'Linguistics' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'BAEN104' subject_code, 'Poetry' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'BAEN105' subject_code, 'Communication Skills' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'BAEN106' subject_code, 'Literary Criticism' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'BAEN201' subject_code, 'Linguistics' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'BAEN202' subject_code, 'Poetry' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'BAEN203' subject_code, 'Communication Skills' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'BAEN204' subject_code, 'Literary Criticism' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'BAEN205' subject_code, 'English Literature' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'BAEN206' subject_code, 'Grammar' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'BAEN301' subject_code, 'Communication Skills' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'BAEN302' subject_code, 'Literary Criticism' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'BAEN303' subject_code, 'English Literature' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'BAEN304' subject_code, 'Grammar' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'BAEN305' subject_code, 'Linguistics' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'BAEN306' subject_code, 'Poetry' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'BAEN401' subject_code, 'English Literature' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'BAEN402' subject_code, 'Grammar' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'BAEN403' subject_code, 'Linguistics' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'BAEN404' subject_code, 'Poetry' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'BAEN405' subject_code, 'Communication Skills' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'BAEN406' subject_code, 'Literary Criticism' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'BAEN501' subject_code, 'Linguistics' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'BAEN502' subject_code, 'Poetry' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'BAEN503' subject_code, 'Communication Skills' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'BAEN504' subject_code, 'Literary Criticism' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'BAEN505' subject_code, 'English Literature' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'BAEN506' subject_code, 'Grammar' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'BAEN601' subject_code, 'Communication Skills' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'BAEN602' subject_code, 'Literary Criticism' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'BAEN603' subject_code, 'English Literature' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'BAEN604' subject_code, 'Grammar' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'BAEN605' subject_code, 'Linguistics' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'BAEN606' subject_code, 'Poetry' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'BMMA101' subject_code, 'Graphic Design' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'BMMA102' subject_code, 'Typography' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'BMMA103' subject_code, '2D Animation' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'BMMA104' subject_code, '3D Animation' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'BMMA105' subject_code, 'Motion Graphics' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'BMMA106' subject_code, 'Video Editing' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'BMMA201' subject_code, '2D Animation' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'BMMA202' subject_code, '3D Animation' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'BMMA203' subject_code, 'Motion Graphics' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'BMMA204' subject_code, 'Video Editing' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'BMMA205' subject_code, 'Visual Effects' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'BMMA206' subject_code, 'Character Design' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'BMMA301' subject_code, 'Motion Graphics' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'BMMA302' subject_code, 'Video Editing' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'BMMA303' subject_code, 'Visual Effects' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'BMMA304' subject_code, 'Character Design' subject_name, 'Prof. Shweta Reddy' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'BMMA305' subject_code, 'Graphic Design' subject_name, 'Prof. Ashok Gupta' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'BMMA306' subject_code, 'Typography' subject_name, 'Prof. Rekha Mehta' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'BMMA401' subject_code, 'Visual Effects' subject_name, 'Prof. Suresh Joshi' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'BMMA402' subject_code, 'Character Design' subject_name, 'Prof. Divya Desai' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'BMMA403' subject_code, 'Graphic Design' subject_name, 'Prof. Anil Sharma' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'BMMA404' subject_code, 'Typography' subject_name, 'Prof. Sunita Verma' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'BMMA405' subject_code, '2D Animation' subject_name, 'Prof. Ramesh Patel' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'BMMA406' subject_code, '3D Animation' subject_name, 'Prof. Priya Iyer' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'BMMA501' subject_code, 'Graphic Design' subject_name, 'Prof. Vikram Nair' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'BMMA502' subject_code, 'Typography' subject_name, 'Prof. Neha Reddy' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'BMMA503' subject_code, '2D Animation' subject_name, 'Prof. Arjun Gupta' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'BMMA504' subject_code, '3D Animation' subject_name, 'Prof. Kavita Mehta' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'BMMA505' subject_code, 'Motion Graphics' subject_name, 'Prof. Sanjay Joshi' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'BMMA506' subject_code, 'Video Editing' subject_name, 'Prof. Meera Desai' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'BMMA601' subject_code, '2D Animation' subject_name, 'Prof. Rajesh Sharma' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'BMMA602' subject_code, '3D Animation' subject_name, 'Prof. Pooja Verma' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'BMMA603' subject_code, 'Motion Graphics' subject_name, 'Prof. Deepak Patel' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'BMMA604' subject_code, 'Video Editing' subject_name, 'Prof. Anjali Iyer' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'BMMA605' subject_code, 'Visual Effects' subject_name, 'Prof. Manoj Nair' faculty_name
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'BMMA606' subject_code, 'Character Design' subject_name, 'Prof. Shweta Reddy' faculty_name
) s JOIN courses c ON c.course_code = s.course_code;

-- ── Timetable Slots (default/predefined) ────────────────────
INSERT IGNORE INTO timetable_slots
  (course_id, semester, day_of_week, period_no, start_time, end_time, subject_id, classroom_id, is_predefined)
SELECT c.id, x.semester, x.day_of_week, x.period_no, x.start_time, x.end_time, ts.id, cr.id, 1
FROM (
SELECT 'BTCE' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE101' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE102' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE103' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE104' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE105' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE106' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE101' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE102' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE103' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE104' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE105' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE106' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE101' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE102' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE103' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE104' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE105' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE106' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE101' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE102' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE103' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE104' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE105' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE106' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE101' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE102' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE103' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE104' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE105' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE106' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE101' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE102' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE103' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE104' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE105' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE106' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE201' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE202' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE203' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE204' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE205' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE206' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE201' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE202' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE203' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE204' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE205' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE206' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE201' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE202' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE203' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE204' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE205' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE206' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE201' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE202' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE203' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE204' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE205' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE206' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE201' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE202' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE203' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE204' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE205' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE206' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE201' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE202' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE203' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE204' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE205' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE206' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE301' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE302' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE303' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE304' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE305' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE306' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE301' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE302' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE303' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE304' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE305' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE306' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE301' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE302' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE303' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE304' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE305' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE306' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE301' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE302' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE303' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE304' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE305' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE306' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE301' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE302' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE303' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE304' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE305' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE306' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE301' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE302' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE303' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE304' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE305' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE306' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE401' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE402' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE403' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE404' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE405' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE406' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE401' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE402' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE403' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE404' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE405' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE406' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE401' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE402' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE403' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE404' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE405' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE406' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE401' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE402' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE403' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE404' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE405' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE406' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE401' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE402' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE403' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE404' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE405' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE406' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE401' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE402' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE403' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE404' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE405' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE406' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE501' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE502' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE503' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE504' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE505' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE506' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE501' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE502' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE503' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE504' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE505' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE506' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE501' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE502' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE503' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE504' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE505' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE506' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE501' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE502' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE503' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE504' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE505' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE506' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE501' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE502' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE503' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE504' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE505' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE506' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE501' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE502' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE503' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE504' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE505' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE506' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE601' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE602' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE603' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE604' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE605' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE606' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE601' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE602' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE603' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE604' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE605' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE606' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE601' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE602' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE603' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE604' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE605' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE606' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE601' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE602' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE603' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE604' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE605' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE606' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE601' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE602' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE603' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE604' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE605' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE606' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE601' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE602' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE603' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE604' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE605' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE606' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE701' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE702' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE703' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE704' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE705' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE706' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE701' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE702' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE703' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE704' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE705' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE706' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE701' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE702' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE703' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE704' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE705' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE706' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE701' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE702' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE703' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE704' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE705' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE706' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE701' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE702' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE703' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE704' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE705' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE706' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE701' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE702' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE703' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE704' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE705' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 7 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE706' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE801' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE802' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE803' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE804' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE805' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE806' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE801' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE802' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE803' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE804' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE805' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE806' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE801' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE802' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE803' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE804' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE805' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE806' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE801' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE802' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE803' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE804' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE805' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE806' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE801' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE802' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE803' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE804' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE805' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE806' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCE801' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCE802' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCE803' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCE804' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCE805' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCE' course_code, 8 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCE806' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT101' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT102' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT103' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT104' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT105' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT106' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT101' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT102' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT103' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT104' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT105' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT106' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT101' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT102' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT103' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT104' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT105' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT106' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT101' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT102' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT103' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT104' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT105' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT106' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT101' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT102' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT103' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT104' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT105' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT106' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT101' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT102' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT103' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT104' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT105' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT106' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT201' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT202' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT203' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT204' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT205' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT206' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT201' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT202' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT203' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT204' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT205' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT206' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT201' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT202' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT203' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT204' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT205' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT206' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT201' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT202' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT203' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT204' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT205' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT206' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT201' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT202' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT203' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT204' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT205' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT206' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT201' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT202' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT203' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT204' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT205' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT206' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT301' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT302' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT303' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT304' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT305' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT306' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT301' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT302' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT303' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT304' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT305' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT306' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT301' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT302' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT303' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT304' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT305' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT306' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT301' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT302' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT303' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT304' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT305' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT306' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT301' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT302' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT303' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT304' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT305' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT306' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT301' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT302' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT303' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT304' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT305' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT306' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT401' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT402' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT403' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT404' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT405' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT406' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT401' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT402' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT403' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT404' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT405' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT406' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT401' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT402' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT403' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT404' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT405' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT406' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT401' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT402' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT403' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT404' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT405' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT406' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT401' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT402' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT403' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT404' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT405' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT406' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT401' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT402' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT403' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT404' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT405' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT406' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT501' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT502' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT503' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT504' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT505' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT506' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT501' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT502' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT503' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT504' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT505' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT506' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT501' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT502' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT503' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT504' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT505' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT506' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT501' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT502' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT503' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT504' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT505' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT506' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT501' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT502' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT503' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT504' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT505' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT506' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT501' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT502' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT503' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT504' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT505' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT506' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT601' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT602' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT603' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT604' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT605' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT606' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT601' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT602' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT603' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT604' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT605' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT606' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT601' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT602' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT603' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT604' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT605' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT606' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT601' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT602' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT603' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT604' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT605' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT606' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT601' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT602' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT603' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT604' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT605' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT606' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT601' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT602' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT603' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT604' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT605' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT606' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT701' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT702' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT703' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT704' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT705' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT706' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT701' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT702' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT703' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT704' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT705' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT706' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT701' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT702' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT703' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT704' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT705' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT706' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT701' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT702' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT703' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT704' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT705' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT706' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT701' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT702' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT703' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT704' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT705' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT706' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT701' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT702' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT703' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT704' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT705' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 7 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT706' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT801' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT802' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT803' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT804' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT805' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT806' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT801' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT802' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT803' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT804' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT805' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT806' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT801' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT802' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT803' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT804' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT805' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT806' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT801' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT802' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT803' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT804' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT805' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT806' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT801' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT802' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT803' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT804' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT805' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT806' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTIT801' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTIT802' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTIT803' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTIT804' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTIT805' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTIT' course_code, 8 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTIT806' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME101' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME102' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME103' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME104' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME105' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME106' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME101' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME102' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME103' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME104' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME105' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME106' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME101' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME102' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME103' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME104' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME105' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME106' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME101' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME102' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME103' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME104' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME105' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME106' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME101' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME102' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME103' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME104' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME105' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME106' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME101' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME102' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME103' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME104' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME105' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME106' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME201' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME202' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME203' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME204' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME205' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME206' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME201' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME202' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME203' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME204' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME205' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME206' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME201' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME202' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME203' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME204' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME205' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME206' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME201' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME202' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME203' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME204' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME205' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME206' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME201' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME202' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME203' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME204' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME205' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME206' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME201' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME202' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME203' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME204' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME205' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME206' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME301' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME302' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME303' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME304' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME305' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME306' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME301' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME302' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME303' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME304' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME305' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME306' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME301' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME302' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME303' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME304' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME305' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME306' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME301' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME302' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME303' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME304' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME305' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME306' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME301' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME302' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME303' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME304' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME305' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME306' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME301' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME302' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME303' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME304' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME305' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME306' subject_code, 'E118' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME401' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME402' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME403' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME404' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME405' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME406' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME401' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME402' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME403' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME404' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME405' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME406' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME401' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME402' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME403' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME404' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME405' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME406' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME401' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME402' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME403' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME404' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME405' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME406' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME401' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME402' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME403' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME404' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME405' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME406' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME401' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME402' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME403' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME404' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME405' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME406' subject_code, 'E119' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME501' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME502' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME503' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME504' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME505' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME506' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME501' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME502' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME503' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME504' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME505' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME506' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME501' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME502' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME503' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME504' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME505' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME506' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME501' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME502' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME503' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME504' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME505' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME506' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME501' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME502' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME503' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME504' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME505' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME506' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME501' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME502' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME503' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME504' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME505' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME506' subject_code, 'E120' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME601' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME602' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME603' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME604' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME605' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME606' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME601' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME602' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME603' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME604' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME605' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME606' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME601' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME602' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME603' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME604' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME605' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME606' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME601' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME602' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME603' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME604' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME605' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME606' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME601' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME602' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME603' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME604' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME605' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME606' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME601' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME602' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME603' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME604' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME605' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME606' subject_code, 'E101' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME701' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME702' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME703' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME704' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME705' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME706' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME701' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME702' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME703' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME704' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME705' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME706' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME701' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME702' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME703' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME704' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME705' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME706' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME701' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME702' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME703' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME704' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME705' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME706' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME701' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME702' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME703' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME704' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME705' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME706' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME701' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME702' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME703' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME704' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME705' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 7 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME706' subject_code, 'E102' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME801' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME802' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME803' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME804' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME805' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME806' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME801' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME802' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME803' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME804' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME805' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME806' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME801' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME802' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME803' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME804' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME805' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME806' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME801' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME802' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME803' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME804' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME805' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME806' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME801' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME802' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME803' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME804' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME805' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME806' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTME801' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTME802' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTME803' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTME804' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTME805' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTME' course_code, 8 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTME806' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV101' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV102' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV103' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV104' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV105' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV106' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV101' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV102' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV103' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV104' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV105' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV106' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV101' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV102' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV103' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV104' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV105' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV106' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV101' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV102' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV103' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV104' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV105' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV106' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV101' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV102' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV103' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV104' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV105' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV106' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV101' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV102' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV103' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV104' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV105' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV106' subject_code, 'E103' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV201' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV202' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV203' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV204' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV205' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV206' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV201' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV202' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV203' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV204' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV205' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV206' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV201' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV202' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV203' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV204' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV205' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV206' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV201' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV202' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV203' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV204' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV205' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV206' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV201' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV202' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV203' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV204' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV205' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV206' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV201' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV202' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV203' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV204' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV205' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV206' subject_code, 'E104' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV301' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV302' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV303' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV304' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV305' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV306' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV301' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV302' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV303' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV304' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV305' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV306' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV301' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV302' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV303' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV304' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV305' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV306' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV301' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV302' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV303' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV304' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV305' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV306' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV301' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV302' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV303' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV304' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV305' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV306' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV301' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV302' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV303' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV304' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV305' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV306' subject_code, 'E105' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV401' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV402' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV403' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV404' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV405' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV406' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV401' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV402' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV403' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV404' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV405' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV406' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV401' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV402' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV403' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV404' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV405' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV406' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV401' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV402' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV403' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV404' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV405' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV406' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV401' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV402' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV403' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV404' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV405' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV406' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV401' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV402' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV403' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV404' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV405' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV406' subject_code, 'E106' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV501' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV502' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV503' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV504' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV505' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV506' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV501' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV502' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV503' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV504' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV505' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV506' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV501' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV502' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV503' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV504' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV505' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV506' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV501' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV502' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV503' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV504' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV505' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV506' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV501' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV502' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV503' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV504' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV505' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV506' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV501' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV502' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV503' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV504' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV505' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV506' subject_code, 'E107' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV601' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV602' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV603' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV604' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV605' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV606' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV601' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV602' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV603' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV604' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV605' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV606' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV601' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV602' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV603' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV604' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV605' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV606' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV601' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV602' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV603' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV604' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV605' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV606' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV601' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV602' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV603' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV604' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV605' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV606' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV601' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV602' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV603' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV604' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV605' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV606' subject_code, 'E108' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV701' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV702' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV703' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV704' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV705' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV706' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV701' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV702' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV703' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV704' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV705' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV706' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV701' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV702' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV703' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV704' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV705' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV706' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV701' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV702' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV703' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV704' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV705' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV706' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV701' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV702' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV703' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV704' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV705' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV706' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV701' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV702' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV703' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV704' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV705' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 7 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV706' subject_code, 'E109' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV801' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV802' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV803' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV804' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV805' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV806' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV801' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV802' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV803' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV804' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV805' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV806' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV801' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV802' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV803' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV804' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV805' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV806' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV801' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV802' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV803' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV804' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV805' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV806' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV801' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV802' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV803' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV804' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV805' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV806' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTCV801' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTCV802' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTCV803' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTCV804' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTCV805' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTCV' course_code, 8 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTCV806' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC101' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC102' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC103' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC104' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC105' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC106' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC101' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC102' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC103' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC104' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC105' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC106' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC101' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC102' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC103' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC104' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC105' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC106' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC101' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC102' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC103' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC104' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC105' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC106' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC101' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC102' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC103' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC104' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC105' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC106' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC101' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC102' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC103' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC104' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC105' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC106' subject_code, 'E110' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC201' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC202' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC203' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC204' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC205' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC206' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC201' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC202' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC203' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC204' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC205' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC206' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC201' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC202' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC203' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC204' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC205' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC206' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC201' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC202' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC203' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC204' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC205' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC206' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC201' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC202' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC203' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC204' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC205' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC206' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC201' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC202' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC203' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC204' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC205' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC206' subject_code, 'E111' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC301' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC302' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC303' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC304' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC305' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC306' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC301' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC302' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC303' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC304' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC305' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC306' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC301' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC302' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC303' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC304' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC305' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC306' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC301' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC302' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC303' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC304' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC305' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC306' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC301' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC302' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC303' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC304' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC305' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC306' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC301' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC302' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC303' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC304' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC305' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC306' subject_code, 'E112' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC401' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC402' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC403' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC404' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC405' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC406' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC401' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC402' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC403' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC404' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC405' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC406' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC401' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC402' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC403' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC404' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC405' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC406' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC401' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC402' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC403' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC404' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC405' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC406' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC401' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC402' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC403' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC404' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC405' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC406' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC401' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC402' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC403' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC404' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC405' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC406' subject_code, 'E113' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC501' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC502' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC503' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC504' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC505' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC506' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC501' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC502' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC503' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC504' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC505' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC506' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC501' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC502' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC503' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC504' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC505' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC506' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC501' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC502' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC503' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC504' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC505' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC506' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC501' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC502' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC503' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC504' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC505' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC506' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC501' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC502' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC503' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC504' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC505' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC506' subject_code, 'E114' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC601' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC602' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC603' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC604' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC605' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC606' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC601' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC602' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC603' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC604' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC605' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC606' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC601' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC602' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC603' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC604' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC605' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC606' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC601' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC602' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC603' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC604' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC605' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC606' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC601' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC602' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC603' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC604' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC605' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC606' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC601' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC602' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC603' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC604' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC605' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC606' subject_code, 'E115' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC701' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC702' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC703' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC704' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC705' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC706' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC701' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC702' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC703' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC704' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC705' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC706' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC701' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC702' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC703' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC704' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC705' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC706' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC701' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC702' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC703' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC704' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC705' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC706' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC701' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC702' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC703' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC704' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC705' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC706' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC701' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC702' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC703' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC704' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC705' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 7 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC706' subject_code, 'E116' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC801' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC802' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC803' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC804' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC805' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC806' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC801' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC802' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC803' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC804' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC805' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC806' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC801' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC802' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC803' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC804' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC805' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC806' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC801' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC802' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC803' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC804' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC805' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC806' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC801' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC802' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC803' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC804' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC805' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC806' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BTEC801' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BTEC802' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BTEC803' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BTEC804' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BTEC805' subject_code, 'E117' room_code
UNION ALL
SELECT 'BTEC' course_code, 8 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BTEC806' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE101' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE102' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE103' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE104' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE105' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE101' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE102' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE103' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE104' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE105' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE101' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE102' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE103' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE104' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE105' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE101' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE102' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE103' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE104' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE105' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE101' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE102' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE103' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE104' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE105' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE101' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE102' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE103' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE104' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE105' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE101' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE102' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE103' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE104' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE105' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE101' subject_code, 'E117' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE201' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE202' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE203' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE204' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE205' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE201' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE202' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE203' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE204' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE205' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE201' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE202' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE203' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE204' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE205' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE201' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE202' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE203' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE204' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE205' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE201' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE202' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE203' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE204' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE205' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE201' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE202' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE203' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE204' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE205' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE201' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE202' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE203' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE204' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE205' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE201' subject_code, 'E118' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE301' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE302' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE303' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE304' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE305' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE301' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE302' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE303' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE304' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE305' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE301' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE302' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE303' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE304' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE305' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE301' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE302' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE303' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE304' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE305' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE301' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE302' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE303' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE304' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE305' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE301' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE302' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE303' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE304' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE305' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE301' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE302' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE303' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE304' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE305' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE301' subject_code, 'E119' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE401' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE402' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE403' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE404' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE405' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE401' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE402' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE403' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE404' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE405' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE401' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE402' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE403' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE404' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE405' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE401' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE402' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE403' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE404' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE405' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE401' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE402' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE403' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE404' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE405' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE401' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE402' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE403' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE404' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE405' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTCE401' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTCE402' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTCE403' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTCE404' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTCE405' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTCE' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTCE401' subject_code, 'E120' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE101' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE102' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE103' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE104' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE105' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE101' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE102' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE103' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE104' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE105' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE101' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE102' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE103' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE104' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE105' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE101' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE102' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE103' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE104' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE105' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE101' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE102' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE103' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE104' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE105' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE101' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE102' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE103' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE104' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE105' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE101' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE102' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE103' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE104' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE105' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE101' subject_code, 'E104' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE201' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE202' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE203' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE204' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE205' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE201' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE202' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE203' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE204' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE205' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE201' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE202' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE203' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE204' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE205' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE201' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE202' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE203' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE204' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE205' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE201' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE202' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE203' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE204' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE205' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE201' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE202' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE203' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE204' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE205' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE201' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE202' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE203' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE204' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE205' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE201' subject_code, 'E105' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE301' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE302' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE303' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE304' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE305' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE301' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE302' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE303' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE304' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE305' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE301' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE302' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE303' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE304' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE305' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE301' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE302' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE303' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE304' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE305' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE301' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE302' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE303' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE304' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE305' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE301' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE302' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE303' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE304' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE305' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE301' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE302' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE303' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE304' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE305' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE301' subject_code, 'E106' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE401' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE402' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE403' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE404' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE405' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE401' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE402' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE403' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE404' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE405' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE401' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE402' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE403' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE404' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE405' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE401' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE402' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE403' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE404' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE405' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE401' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE402' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE403' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE404' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE405' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE401' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE402' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE403' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE404' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE405' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MTSE401' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MTSE402' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MTSE403' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MTSE404' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MTSE405' subject_code, 'E107' room_code
UNION ALL
SELECT 'MTSE' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MTSE401' subject_code, 'E107' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA101' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA102' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA103' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA104' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA105' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA106' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA101' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA102' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA103' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA104' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA105' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA106' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA101' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA102' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA103' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA104' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA105' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA106' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA101' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA102' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA103' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA104' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA105' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA106' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA101' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA102' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA103' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA104' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA105' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA106' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA101' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA102' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA103' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA104' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA105' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA106' subject_code, 'C111' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA201' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA202' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA203' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA204' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA205' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA206' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA201' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA202' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA203' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA204' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA205' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA206' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA201' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA202' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA203' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA204' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA205' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA206' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA201' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA202' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA203' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA204' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA205' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA206' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA201' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA202' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA203' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA204' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA205' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA206' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA201' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA202' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA203' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA204' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA205' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA206' subject_code, 'C112' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA301' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA302' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA303' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA304' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA305' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA306' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA301' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA302' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA303' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA304' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA305' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA306' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA301' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA302' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA303' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA304' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA305' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA306' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA301' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA302' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA303' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA304' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA305' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA306' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA301' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA302' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA303' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA304' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA305' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA306' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA301' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA302' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA303' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA304' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA305' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA306' subject_code, 'C113' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA401' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA402' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA403' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA404' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA405' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA406' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA401' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA402' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA403' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA404' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA405' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA406' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA401' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA402' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA403' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA404' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA405' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA406' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA401' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA402' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA403' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA404' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA405' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA406' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA401' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA402' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA403' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA404' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA405' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA406' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA401' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA402' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA403' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA404' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA405' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA406' subject_code, 'C114' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA501' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA502' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA503' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA504' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA505' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA506' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA501' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA502' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA503' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA504' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA505' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA506' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA501' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA502' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA503' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA504' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA505' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA506' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA501' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA502' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA503' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA504' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA505' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA506' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA501' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA502' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA503' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA504' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA505' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA506' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA501' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA502' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA503' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA504' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA505' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA506' subject_code, 'C115' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA601' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA602' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA603' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA604' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA605' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA606' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA601' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA602' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA603' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA604' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA605' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA606' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA601' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA602' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA603' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA604' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA605' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA606' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA601' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA602' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA603' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA604' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA605' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA606' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA601' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA602' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA603' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA604' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA605' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA606' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCA601' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCA602' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCA603' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCA604' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCA605' subject_code, 'C116' room_code
UNION ALL
SELECT 'BCA' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCA606' subject_code, 'C116' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA101' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA102' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA103' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA104' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA105' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA106' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA101' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA102' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA103' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA104' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA105' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA106' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA101' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA102' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA103' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA104' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA105' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA106' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA101' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA102' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA103' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA104' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA105' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA106' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA101' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA102' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA103' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA104' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA105' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA106' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA101' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA102' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA103' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA104' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA105' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA106' subject_code, 'C118' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA201' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA202' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA203' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA204' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA205' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA206' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA201' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA202' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA203' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA204' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA205' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA206' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA201' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA202' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA203' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA204' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA205' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA206' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA201' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA202' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA203' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA204' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA205' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA206' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA201' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA202' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA203' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA204' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA205' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA206' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA201' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA202' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA203' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA204' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA205' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA206' subject_code, 'C119' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA301' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA302' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA303' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA304' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA305' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA306' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA301' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA302' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA303' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA304' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA305' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA306' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA301' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA302' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA303' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA304' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA305' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA306' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA301' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA302' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA303' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA304' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA305' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA306' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA301' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA302' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA303' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA304' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA305' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA306' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA301' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA302' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA303' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA304' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA305' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA306' subject_code, 'C120' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA401' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA402' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA403' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA404' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA405' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA406' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA401' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA402' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA403' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA404' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA405' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA406' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA401' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA402' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA403' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA404' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA405' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA406' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA401' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA402' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA403' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA404' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA405' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA406' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA401' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA402' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA403' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA404' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA405' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA406' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCA401' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCA402' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCA403' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCA404' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCA405' subject_code, 'C101' room_code
UNION ALL
SELECT 'MCA' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCA406' subject_code, 'C101' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT101' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT102' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT103' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT104' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT105' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT106' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT101' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT102' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT103' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT104' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT105' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT106' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT101' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT102' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT103' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT104' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT105' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT106' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT101' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT102' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT103' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT104' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT105' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT106' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT101' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT102' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT103' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT104' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT105' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT106' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT101' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT102' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT103' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT104' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT105' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT106' subject_code, 'C105' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT201' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT202' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT203' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT204' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT205' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT206' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT201' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT202' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT203' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT204' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT205' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT206' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT201' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT202' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT203' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT204' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT205' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT206' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT201' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT202' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT203' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT204' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT205' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT206' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT201' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT202' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT203' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT204' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT205' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT206' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT201' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT202' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT203' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT204' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT205' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT206' subject_code, 'C106' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT301' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT302' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT303' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT304' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT305' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT306' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT301' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT302' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT303' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT304' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT305' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT306' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT301' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT302' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT303' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT304' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT305' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT306' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT301' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT302' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT303' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT304' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT305' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT306' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT301' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT302' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT303' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT304' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT305' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT306' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT301' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT302' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT303' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT304' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT305' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT306' subject_code, 'C107' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT401' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT402' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT403' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT404' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT405' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT406' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT401' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT402' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT403' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT404' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT405' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT406' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT401' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT402' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT403' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT404' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT405' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT406' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT401' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT402' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT403' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT404' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT405' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT406' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT401' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT402' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT403' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT404' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT405' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT406' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT401' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT402' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT403' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT404' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT405' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT406' subject_code, 'C108' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT501' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT502' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT503' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT504' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT505' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT506' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT501' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT502' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT503' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT504' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT505' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT506' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT501' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT502' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT503' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT504' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT505' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT506' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT501' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT502' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT503' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT504' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT505' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT506' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT501' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT502' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT503' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT504' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT505' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT506' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT501' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT502' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT503' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT504' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT505' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT506' subject_code, 'C109' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT601' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT602' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT603' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT604' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT605' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT606' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT601' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT602' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT603' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT604' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT605' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT606' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT601' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT602' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT603' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT604' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT605' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT606' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT601' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT602' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT603' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT604' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT605' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT606' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT601' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT602' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT603' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT604' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT605' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT606' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCIT601' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCIT602' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCIT603' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCIT604' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCIT605' subject_code, 'C110' room_code
UNION ALL
SELECT 'BSCIT' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCIT606' subject_code, 'C110' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA101' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA102' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA103' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA104' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA105' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA106' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA101' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA102' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA103' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA104' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA105' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA106' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA101' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA102' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA103' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA104' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA105' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA106' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA101' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA102' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA103' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA104' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA105' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA106' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA101' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA102' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA103' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA104' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA105' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA106' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA101' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA102' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA103' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA104' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA105' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA106' subject_code, 'M112' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA201' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA202' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA203' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA204' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA205' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA206' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA201' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA202' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA203' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA204' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA205' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA206' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA201' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA202' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA203' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA204' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA205' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA206' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA201' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA202' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA203' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA204' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA205' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA206' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA201' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA202' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA203' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA204' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA205' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA206' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA201' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA202' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA203' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA204' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA205' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA206' subject_code, 'M113' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA301' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA302' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA303' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA304' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA305' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA306' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA301' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA302' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA303' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA304' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA305' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA306' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA301' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA302' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA303' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA304' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA305' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA306' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA301' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA302' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA303' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA304' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA305' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA306' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA301' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA302' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA303' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA304' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA305' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA306' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA301' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA302' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA303' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA304' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA305' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA306' subject_code, 'M114' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA401' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA402' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA403' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA404' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA405' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA406' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA401' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA402' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA403' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA404' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA405' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA406' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA401' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA402' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA403' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA404' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA405' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA406' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA401' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA402' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA403' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA404' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA405' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA406' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA401' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA402' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA403' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA404' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA405' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA406' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA401' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA402' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA403' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA404' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA405' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA406' subject_code, 'M115' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA501' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA502' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA503' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA504' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA505' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA506' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA501' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA502' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA503' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA504' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA505' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA506' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA501' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA502' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA503' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA504' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA505' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA506' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA501' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA502' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA503' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA504' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA505' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA506' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA501' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA502' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA503' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA504' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA505' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA506' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA501' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA502' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA503' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA504' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA505' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA506' subject_code, 'M116' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA601' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA602' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA603' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA604' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA605' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA606' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA601' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA602' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA603' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA604' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA605' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA606' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA601' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA602' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA603' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA604' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA605' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA606' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA601' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA602' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA603' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA604' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA605' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA606' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA601' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA602' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA603' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA604' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA605' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA606' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BBA601' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BBA602' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BBA603' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BBA604' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BBA605' subject_code, 'M117' room_code
UNION ALL
SELECT 'BBA' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BBA606' subject_code, 'M117' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA101' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA102' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA103' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA104' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA105' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA106' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA101' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA102' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA103' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA104' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA105' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA106' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA101' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA102' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA103' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA104' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA105' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA106' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA101' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA102' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA103' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA104' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA105' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA106' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA101' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA102' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA103' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA104' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA105' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA106' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA101' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA102' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA103' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA104' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA105' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA106' subject_code, 'M119' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA201' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA202' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA203' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA204' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA205' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA206' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA201' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA202' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA203' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA204' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA205' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA206' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA201' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA202' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA203' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA204' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA205' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA206' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA201' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA202' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA203' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA204' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA205' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA206' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA201' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA202' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA203' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA204' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA205' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA206' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA201' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA202' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA203' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA204' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA205' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA206' subject_code, 'M120' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA301' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA302' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA303' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA304' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA305' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA306' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA301' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA302' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA303' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA304' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA305' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA306' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA301' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA302' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA303' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA304' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA305' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA306' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA301' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA302' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA303' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA304' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA305' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA306' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA301' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA302' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA303' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA304' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA305' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA306' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA301' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA302' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA303' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA304' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA305' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA306' subject_code, 'M101' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA401' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA402' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA403' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA404' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA405' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA406' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA401' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA402' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA403' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA404' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA405' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA406' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA401' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA402' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA403' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA404' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA405' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA406' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA401' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA402' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA403' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA404' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA405' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA406' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA401' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA402' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA403' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA404' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA405' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA406' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MBA401' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MBA402' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MBA403' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MBA404' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MBA405' subject_code, 'M102' room_code
UNION ALL
SELECT 'MBA' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MBA406' subject_code, 'M102' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA101' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA102' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA103' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA104' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA105' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA106' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA101' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA102' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA103' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA104' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA105' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA106' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA101' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA102' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA103' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA104' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA105' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA106' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA101' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA102' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA103' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA104' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA105' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA106' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA101' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA102' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA103' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA104' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA105' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA106' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA101' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA102' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA103' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA104' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA105' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA106' subject_code, 'M106' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA201' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA202' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA203' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA204' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA205' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA206' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA201' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA202' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA203' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA204' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA205' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA206' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA201' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA202' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA203' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA204' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA205' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA206' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA201' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA202' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA203' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA204' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA205' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA206' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA201' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA202' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA203' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA204' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA205' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA206' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA201' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA202' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA203' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA204' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA205' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA206' subject_code, 'M107' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA301' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA302' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA303' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA304' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA305' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA306' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA301' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA302' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA303' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA304' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA305' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA306' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA301' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA302' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA303' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA304' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA305' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA306' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA301' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA302' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA303' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA304' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA305' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA306' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA301' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA302' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA303' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA304' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA305' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA306' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA301' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA302' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA303' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA304' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA305' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA306' subject_code, 'M108' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA401' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA402' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA403' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA404' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA405' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA406' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA401' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA402' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA403' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA404' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA405' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA406' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA401' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA402' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA403' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA404' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA405' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA406' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA401' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA402' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA403' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA404' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA405' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA406' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA401' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA402' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA403' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA404' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA405' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA406' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA401' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA402' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA403' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA404' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA405' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA406' subject_code, 'M109' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA501' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA502' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA503' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA504' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA505' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA506' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA501' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA502' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA503' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA504' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA505' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA506' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA501' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA502' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA503' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA504' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA505' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA506' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA501' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA502' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA503' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA504' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA505' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA506' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA501' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA502' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA503' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA504' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA505' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA506' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA501' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA502' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA503' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA504' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA505' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA506' subject_code, 'M110' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA601' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA602' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA603' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA604' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA605' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA606' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA601' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA602' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA603' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA604' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA605' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA606' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA601' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA602' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA603' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA604' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA605' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA606' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA601' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA602' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA603' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA604' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA605' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA606' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA601' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA602' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA603' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA604' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA605' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA606' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCBA601' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCBA602' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCBA603' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCBA604' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCBA605' subject_code, 'M111' room_code
UNION ALL
SELECT 'BCBA' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCBA606' subject_code, 'M111' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA101' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA102' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA103' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA104' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA105' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA106' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA101' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA102' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA103' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA104' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA105' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA106' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA101' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA102' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA103' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA104' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA105' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA106' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA101' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA102' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA103' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA104' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA105' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA106' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA101' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA102' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA103' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA104' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA105' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA106' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA101' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA102' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA103' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA104' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA105' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA106' subject_code, 'S113' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA201' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA202' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA203' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA204' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA205' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA206' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA201' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA202' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA203' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA204' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA205' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA206' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA201' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA202' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA203' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA204' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA205' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA206' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA201' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA202' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA203' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA204' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA205' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA206' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA201' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA202' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA203' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA204' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA205' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA206' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA201' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA202' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA203' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA204' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA205' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA206' subject_code, 'S114' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA301' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA302' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA303' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA304' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA305' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA306' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA301' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA302' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA303' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA304' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA305' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA306' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA301' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA302' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA303' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA304' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA305' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA306' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA301' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA302' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA303' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA304' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA305' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA306' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA301' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA302' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA303' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA304' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA305' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA306' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA301' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA302' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA303' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA304' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA305' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA306' subject_code, 'S115' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA401' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA402' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA403' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA404' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA405' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA406' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA401' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA402' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA403' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA404' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA405' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA406' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA401' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA402' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA403' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA404' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA405' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA406' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA401' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA402' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA403' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA404' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA405' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA406' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA401' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA402' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA403' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA404' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA405' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA406' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA401' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA402' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA403' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA404' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA405' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA406' subject_code, 'S116' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA501' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA502' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA503' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA504' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA505' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA506' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA501' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA502' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA503' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA504' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA505' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA506' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA501' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA502' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA503' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA504' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA505' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA506' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA501' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA502' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA503' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA504' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA505' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA506' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA501' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA502' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA503' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA504' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA505' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA506' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA501' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA502' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA503' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA504' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA505' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA506' subject_code, 'S117' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA601' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA602' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA603' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA604' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA605' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA606' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA601' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA602' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA603' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA604' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA605' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA606' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA601' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA602' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA603' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA604' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA605' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA606' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA601' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA602' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA603' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA604' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA605' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA606' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA601' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA602' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA603' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA604' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA605' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA606' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCMA601' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCMA602' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCMA603' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCMA604' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCMA605' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCMA' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCMA606' subject_code, 'S118' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH101' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH102' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH103' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH104' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH105' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH106' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH101' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH102' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH103' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH104' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH105' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH106' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH101' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH102' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH103' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH104' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH105' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH106' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH101' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH102' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH103' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH104' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH105' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH106' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH101' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH102' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH103' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH104' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH105' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH106' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH101' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH102' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH103' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH104' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH105' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH106' subject_code, 'S120' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH201' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH202' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH203' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH204' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH205' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH206' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH201' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH202' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH203' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH204' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH205' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH206' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH201' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH202' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH203' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH204' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH205' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH206' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH201' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH202' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH203' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH204' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH205' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH206' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH201' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH202' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH203' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH204' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH205' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH206' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH201' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH202' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH203' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH204' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH205' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH206' subject_code, 'S101' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH301' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH302' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH303' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH304' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH305' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH306' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH301' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH302' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH303' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH304' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH305' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH306' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH301' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH302' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH303' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH304' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH305' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH306' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH301' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH302' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH303' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH304' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH305' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH306' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH301' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH302' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH303' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH304' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH305' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH306' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH301' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH302' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH303' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH304' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH305' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH306' subject_code, 'S102' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH401' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH402' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH403' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH404' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH405' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH406' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH401' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH402' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH403' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH404' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH405' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH406' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH401' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH402' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH403' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH404' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH405' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH406' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH401' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH402' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH403' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH404' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH405' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH406' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH401' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH402' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH403' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH404' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH405' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH406' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH401' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH402' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH403' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH404' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH405' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH406' subject_code, 'S103' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH501' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH502' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH503' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH504' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH505' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH506' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH501' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH502' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH503' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH504' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH505' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH506' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH501' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH502' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH503' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH504' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH505' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH506' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH501' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH502' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH503' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH504' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH505' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH506' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH501' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH502' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH503' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH504' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH505' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH506' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH501' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH502' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH503' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH504' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH505' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH506' subject_code, 'S104' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH601' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH602' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH603' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH604' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH605' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH606' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH601' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH602' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH603' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH604' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH605' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH606' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH601' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH602' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH603' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH604' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH605' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH606' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH601' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH602' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH603' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH604' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH605' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH606' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH601' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH602' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH603' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH604' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH605' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH606' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BSCPH601' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BSCPH602' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BSCPH603' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BSCPH604' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BSCPH605' subject_code, 'S105' room_code
UNION ALL
SELECT 'BSCPH' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BSCPH606' subject_code, 'S105' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS101' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS102' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS103' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS104' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS105' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS106' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS101' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS102' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS103' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS104' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS105' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS106' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS101' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS102' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS103' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS104' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS105' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS106' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS101' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS102' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS103' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS104' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS105' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS106' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS101' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS102' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS103' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS104' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS105' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS106' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS101' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS102' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS103' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS104' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS105' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS106' subject_code, 'S107' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS201' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS202' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS203' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS204' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS205' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS206' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS201' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS202' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS203' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS204' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS205' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS206' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS201' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS202' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS203' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS204' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS205' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS206' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS201' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS202' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS203' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS204' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS205' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS206' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS201' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS202' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS203' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS204' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS205' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS206' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS201' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS202' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS203' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS204' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS205' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS206' subject_code, 'S108' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS301' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS302' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS303' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS304' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS305' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS306' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS301' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS302' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS303' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS304' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS305' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS306' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS301' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS302' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS303' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS304' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS305' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS306' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS301' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS302' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS303' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS304' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS305' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS306' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS301' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS302' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS303' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS304' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS305' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS306' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS301' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS302' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS303' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS304' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS305' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS306' subject_code, 'S109' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS401' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS402' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS403' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS404' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS405' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS406' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS401' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS402' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS403' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS404' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS405' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS406' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS401' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS402' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS403' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS404' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS405' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS406' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS401' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS402' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS403' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS404' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS405' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS406' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS401' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS402' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS403' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS404' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS405' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS406' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MSCDS401' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MSCDS402' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MSCDS403' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MSCDS404' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MSCDS405' subject_code, 'S110' room_code
UNION ALL
SELECT 'MSCDS' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MSCDS406' subject_code, 'S110' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM101' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM102' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM103' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM104' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM105' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM106' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM101' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM102' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM103' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM104' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM105' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM106' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM101' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM102' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM103' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM104' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM105' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM106' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM101' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM102' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM103' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM104' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM105' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM106' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM101' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM102' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM103' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM104' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM105' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM106' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM101' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM102' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM103' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM104' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM105' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM106' subject_code, 'CO114' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM201' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM202' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM203' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM204' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM205' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM206' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM201' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM202' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM203' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM204' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM205' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM206' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM201' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM202' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM203' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM204' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM205' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM206' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM201' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM202' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM203' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM204' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM205' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM206' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM201' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM202' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM203' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM204' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM205' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM206' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM201' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM202' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM203' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM204' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM205' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM206' subject_code, 'CO115' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM301' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM302' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM303' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM304' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM305' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM306' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM301' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM302' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM303' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM304' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM305' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM306' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM301' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM302' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM303' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM304' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM305' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM306' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM301' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM302' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM303' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM304' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM305' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM306' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM301' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM302' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM303' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM304' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM305' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM306' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM301' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM302' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM303' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM304' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM305' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM306' subject_code, 'CO116' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM401' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM402' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM403' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM404' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM405' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM406' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM401' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM402' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM403' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM404' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM405' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM406' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM401' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM402' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM403' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM404' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM405' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM406' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM401' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM402' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM403' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM404' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM405' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM406' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM401' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM402' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM403' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM404' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM405' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM406' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM401' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM402' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM403' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM404' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM405' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM406' subject_code, 'CO117' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM501' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM502' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM503' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM504' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM505' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM506' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM501' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM502' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM503' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM504' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM505' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM506' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM501' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM502' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM503' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM504' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM505' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM506' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM501' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM502' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM503' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM504' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM505' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM506' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM501' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM502' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM503' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM504' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM505' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM506' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM501' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM502' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM503' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM504' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM505' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM506' subject_code, 'CO118' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM601' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM602' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM603' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM604' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM605' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM606' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM601' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM602' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM603' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM604' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM605' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM606' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM601' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM602' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM603' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM604' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM605' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM606' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM601' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM602' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM603' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM604' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM605' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM606' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM601' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM602' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM603' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM604' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM605' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM606' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BCOM601' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BCOM602' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BCOM603' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BCOM604' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BCOM605' subject_code, 'CO119' room_code
UNION ALL
SELECT 'BCOM' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BCOM606' subject_code, 'CO119' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM101' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM102' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM103' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM104' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM105' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM101' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM102' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM103' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM104' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM105' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM101' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM102' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM103' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM104' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM105' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM101' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM102' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM103' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM104' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM105' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM101' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM102' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM103' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM104' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM105' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM101' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM102' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM103' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM104' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM105' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM101' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM102' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM103' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM104' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM105' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM101' subject_code, 'CO101' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM201' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM202' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM203' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM204' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM205' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM201' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM202' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM203' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM204' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM205' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM201' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM202' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM203' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM204' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM205' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM201' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM202' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM203' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM204' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM205' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM201' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM202' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM203' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM204' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM205' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM201' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM202' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM203' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM204' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM205' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM201' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM202' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM203' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM204' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM205' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM201' subject_code, 'CO102' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM301' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM302' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM303' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM304' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM305' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM301' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM302' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM303' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM304' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM305' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM301' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM302' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM303' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM304' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM305' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM301' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM302' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM303' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM304' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM305' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM301' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM302' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM303' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM304' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM305' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM301' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM302' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM303' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM304' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM305' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM301' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM302' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM303' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM304' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM305' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM301' subject_code, 'CO103' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM401' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM402' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM403' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM404' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM405' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM401' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM402' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM403' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM404' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM405' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM401' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM402' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM403' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM404' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM405' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM401' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM402' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM403' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM404' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM405' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM401' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM402' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM403' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM404' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM405' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM401' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM402' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM403' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM404' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM405' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'MCOM401' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'MCOM402' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'MCOM403' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'MCOM404' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'MCOM405' subject_code, 'CO104' room_code
UNION ALL
SELECT 'MCOM' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'MCOM401' subject_code, 'CO104' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN101' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN102' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN103' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN104' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN105' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN106' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN101' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN102' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN103' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN104' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN105' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN106' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN101' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN102' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN103' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN104' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN105' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN106' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN101' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN102' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN103' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN104' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN105' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN106' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN101' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN102' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN103' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN104' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN105' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN106' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN101' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN102' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN103' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN104' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN105' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN106' subject_code, 'A108' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN201' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN202' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN203' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN204' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN205' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN206' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN201' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN202' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN203' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN204' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN205' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN206' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN201' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN202' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN203' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN204' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN205' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN206' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN201' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN202' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN203' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN204' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN205' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN206' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN201' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN202' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN203' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN204' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN205' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN206' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN201' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN202' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN203' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN204' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN205' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN206' subject_code, 'A109' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN301' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN302' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN303' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN304' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN305' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN306' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN301' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN302' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN303' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN304' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN305' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN306' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN301' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN302' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN303' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN304' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN305' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN306' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN301' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN302' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN303' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN304' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN305' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN306' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN301' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN302' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN303' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN304' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN305' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN306' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN301' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN302' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN303' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN304' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN305' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN306' subject_code, 'A110' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN401' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN402' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN403' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN404' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN405' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN406' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN401' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN402' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN403' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN404' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN405' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN406' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN401' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN402' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN403' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN404' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN405' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN406' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN401' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN402' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN403' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN404' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN405' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN406' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN401' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN402' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN403' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN404' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN405' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN406' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN401' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN402' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN403' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN404' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN405' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN406' subject_code, 'A111' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN501' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN502' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN503' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN504' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN505' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN506' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN501' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN502' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN503' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN504' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN505' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN506' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN501' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN502' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN503' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN504' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN505' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN506' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN501' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN502' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN503' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN504' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN505' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN506' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN501' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN502' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN503' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN504' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN505' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN506' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN501' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN502' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN503' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN504' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN505' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN506' subject_code, 'A112' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN601' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN602' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN603' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN604' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN605' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN606' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN601' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN602' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN603' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN604' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN605' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN606' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN601' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN602' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN603' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN604' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN605' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN606' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN601' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN602' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN603' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN604' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN605' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN606' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN601' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN602' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN603' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN604' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN605' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN606' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BAEN601' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BAEN602' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BAEN603' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BAEN604' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BAEN605' subject_code, 'A113' room_code
UNION ALL
SELECT 'BAEN' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BAEN606' subject_code, 'A113' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA101' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA102' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA103' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA104' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA105' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA106' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA101' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA102' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA103' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA104' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA105' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA106' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA101' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA102' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA103' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA104' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA105' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA106' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA101' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA102' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA103' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA104' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA105' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA106' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA101' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA102' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA103' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA104' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA105' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA106' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA101' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA102' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA103' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA104' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA105' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 1 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA106' subject_code, 'D115' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA201' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA202' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA203' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA204' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA205' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA206' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA201' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA202' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA203' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA204' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA205' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA206' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA201' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA202' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA203' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA204' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA205' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA206' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA201' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA202' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA203' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA204' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA205' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA206' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA201' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA202' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA203' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA204' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA205' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA206' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA201' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA202' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA203' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA204' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA205' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 2 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA206' subject_code, 'D116' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA301' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA302' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA303' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA304' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA305' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA306' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA301' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA302' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA303' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA304' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA305' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA306' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA301' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA302' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA303' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA304' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA305' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA306' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA301' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA302' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA303' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA304' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA305' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA306' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA301' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA302' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA303' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA304' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA305' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA306' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA301' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA302' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA303' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA304' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA305' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 3 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA306' subject_code, 'D117' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA401' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA402' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA403' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA404' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA405' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA406' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA401' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA402' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA403' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA404' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA405' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA406' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA401' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA402' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA403' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA404' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA405' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA406' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA401' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA402' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA403' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA404' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA405' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA406' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA401' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA402' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA403' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA404' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA405' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA406' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA401' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA402' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA403' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA404' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA405' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 4 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA406' subject_code, 'D118' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA501' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA502' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA503' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA504' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA505' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA506' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA501' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA502' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA503' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA504' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA505' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA506' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA501' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA502' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA503' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA504' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA505' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA506' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA501' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA502' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA503' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA504' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA505' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA506' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA501' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA502' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA503' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA504' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA505' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA506' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA501' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA502' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA503' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA504' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA505' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 5 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA506' subject_code, 'D119' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Monday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA601' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Monday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA602' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Monday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA603' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Monday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA604' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Monday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA605' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Monday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA606' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Tuesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA601' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Tuesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA602' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Tuesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA603' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Tuesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA604' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Tuesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA605' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Tuesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA606' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Wednesday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA601' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Wednesday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA602' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Wednesday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA603' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Wednesday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA604' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Wednesday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA605' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Wednesday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA606' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Thursday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA601' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Thursday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA602' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Thursday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA603' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Thursday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA604' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Thursday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA605' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Thursday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA606' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Friday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA601' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Friday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA602' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Friday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA603' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Friday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA604' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Friday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA605' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Friday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA606' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Saturday' day_of_week, 1 period_no, '09:00:00' start_time, '10:00:00' end_time, 'BMMA601' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Saturday' day_of_week, 2 period_no, '10:00:00' start_time, '11:00:00' end_time, 'BMMA602' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Saturday' day_of_week, 3 period_no, '11:15:00' start_time, '12:15:00' end_time, 'BMMA603' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Saturday' day_of_week, 4 period_no, '12:15:00' start_time, '13:15:00' end_time, 'BMMA604' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Saturday' day_of_week, 5 period_no, '14:00:00' start_time, '15:00:00' end_time, 'BMMA605' subject_code, 'D120' room_code
UNION ALL
SELECT 'BMMA' course_code, 6 semester, 'Saturday' day_of_week, 6 period_no, '15:00:00' start_time, '16:00:00' end_time, 'BMMA606' subject_code, 'D120' room_code
) x
JOIN courses c ON c.course_code = x.course_code
JOIN tt_subjects ts ON ts.subject_code = x.subject_code
JOIN classrooms cr ON cr.room_code = x.room_code;