-- ============================================
-- College Campus Connect - MySQL Database Schema
-- ============================================

CREATE DATABASE IF NOT EXISTS college_campus;
USE college_campus;

-- Users / Students
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(180) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  avatar VARCHAR(300),
  cover_photo VARCHAR(300),
  bio TEXT,
  major VARCHAR(120),
  year ENUM('Freshman','Sophomore','Junior','Senior','Graduate') DEFAULT 'Freshman',
  gpa DECIMAL(3,2),
  campus VARCHAR(100),
  role ENUM('student','admin','faculty') DEFAULT 'student',
  is_verified TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Posts / Feed
CREATE TABLE posts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  content TEXT NOT NULL,
  image VARCHAR(300),
  post_type ENUM('general','event','announcement','study','lost_found') DEFAULT 'general',
  likes_count INT DEFAULT 0,
  comments_count INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Likes
CREATE TABLE post_likes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  post_id INT NOT NULL,
  user_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_like (post_id, user_id),
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Comments
CREATE TABLE comments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  post_id INT NOT NULL,
  user_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Clubs & Organizations
CREATE TABLE clubs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  description TEXT,
  category VARCHAR(80),
  logo VARCHAR(300),
  cover_image VARCHAR(300),
  president_id INT,
  members_count INT DEFAULT 0,
  is_official TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (president_id) REFERENCES users(id)
);

-- Club Memberships
CREATE TABLE club_members (
  id INT AUTO_INCREMENT PRIMARY KEY,
  club_id INT NOT NULL,
  user_id INT NOT NULL,
  role ENUM('member','officer','president') DEFAULT 'member',
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_membership (club_id, user_id),
  FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Events
CREATE TABLE events (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  location VARCHAR(200),
  image VARCHAR(300),
  start_datetime DATETIME NOT NULL,
  end_datetime DATETIME,
  organizer_id INT,
  club_id INT,
  event_type ENUM('social','academic','sports','arts','career','other') DEFAULT 'other',
  attendees_count INT DEFAULT 0,
  max_attendees INT,
  is_free TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (organizer_id) REFERENCES users(id),
  FOREIGN KEY (club_id) REFERENCES clubs(id)
);

-- Event RSVPs
CREATE TABLE event_rsvps (
  id INT AUTO_INCREMENT PRIMARY KEY,
  event_id INT NOT NULL,
  user_id INT NOT NULL,
  status ENUM('going','maybe','not_going') DEFAULT 'going',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_rsvp (event_id, user_id),
  FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Study Groups
CREATE TABLE study_groups (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  course_code VARCHAR(30),
  subject VARCHAR(120),
  description TEXT,
  creator_id INT,
  max_members INT DEFAULT 8,
  members_count INT DEFAULT 1,
  meeting_time VARCHAR(100),
  location VARCHAR(150),
  is_open TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (creator_id) REFERENCES users(id)
);

-- Study Group Members
CREATE TABLE study_group_members (
  id INT AUTO_INCREMENT PRIMARY KEY,
  group_id INT NOT NULL,
  user_id INT NOT NULL,
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_sg_member (group_id, user_id),
  FOREIGN KEY (group_id) REFERENCES study_groups(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Messages / Chat
CREATE TABLE conversations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user1_id INT NOT NULL,
  user2_id INT NOT NULL,
  last_message TEXT,
  last_message_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_conv (user1_id, user2_id),
  FOREIGN KEY (user1_id) REFERENCES users(id),
  FOREIGN KEY (user2_id) REFERENCES users(id)
);

CREATE TABLE messages (
  id INT AUTO_INCREMENT PRIMARY KEY,
  conversation_id INT NOT NULL,
  sender_id INT NOT NULL,
  content TEXT NOT NULL,
  is_read TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE,
  FOREIGN KEY (sender_id) REFERENCES users(id)
);

-- Notifications
CREATE TABLE notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  from_user_id INT,
  type ENUM('like','comment','follow','event','club','message','mention') NOT NULL,
  reference_id INT,
  message TEXT,
  is_read TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (from_user_id) REFERENCES users(id)
);

-- Follows
CREATE TABLE follows (
  id INT AUTO_INCREMENT PRIMARY KEY,
  follower_id INT NOT NULL,
  following_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_follow (follower_id, following_id),
  FOREIGN KEY (follower_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (following_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Marketplace / Lost & Found
CREATE TABLE marketplace (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  price DECIMAL(10,2),
  image VARCHAR(300),
  category ENUM('textbook','electronics','furniture','clothing','other') DEFAULT 'other',
  listing_type ENUM('sell','lost','found','free') DEFAULT 'sell',
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Indexes for performance
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_created_at ON posts(created_at DESC);
CREATE INDEX idx_events_start ON events(start_datetime);
CREATE INDEX idx_notifications_user ON notifications(user_id, is_read);
CREATE INDEX idx_messages_conv ON messages(conversation_id, created_at);

-- ============================================================
-- Faculty Registration & Management Tables
-- ============================================================

CREATE TABLE IF NOT EXISTS faculty (
  faculty_id INT AUTO_INCREMENT PRIMARY KEY,
  employee_id VARCHAR(20) UNIQUE NOT NULL,      -- PTFAC20260001
  first_name VARCHAR(100) NOT NULL,
  middle_name VARCHAR(100),
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(200) UNIQUE NOT NULL,           -- firstname.lastname@primetech.ac.in
  password_hash VARCHAR(255) NOT NULL,
  dob DATE,
  gender ENUM('Male','Female','Other'),
  phone VARCHAR(15),
  address TEXT,
  department VARCHAR(100),
  designation ENUM('Professor','Assistant Professor','Associate Professor','HOD','Lab Assistant','Lecturer','Visiting Faculty'),
  qualification VARCHAR(100),
  specialization VARCHAR(200),
  experience TINYINT UNSIGNED,                  -- Years
  joining_date DATE,
  status ENUM('Pending','Active','Inactive','Suspended') DEFAULT 'Pending',
  registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMP NULL,
  INDEX idx_faculty_employee (employee_id),
  INDEX idx_faculty_email (email),
  INDEX idx_faculty_dept (department)
);

CREATE TABLE IF NOT EXISTS faculty_documents (
  doc_id INT AUTO_INCREMENT PRIMARY KEY,
  faculty_id INT NOT NULL,
  profile_photo VARCHAR(500),
  resume VARCHAR(500),
  qualification_certificate VARCHAR(500),
  id_proof VARCHAR(500),
  uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id) ON DELETE CASCADE
);

-- ============================================================
-- Hostel Management Tables
-- ============================================================

-- Add hostel columns to students table (if using separate students table)
-- ALTER TABLE students ADD COLUMN hostel_required TINYINT(1) DEFAULT 0;
-- ALTER TABLE students ADD COLUMN hostel_type ENUM('Boys Hostel','Girls Hostel');
-- ALTER TABLE students ADD COLUMN room_type ENUM('Non-AC (3 Sharing)','Non-AC (2 Sharing)','AC (2 Sharing)');

CREATE TABLE IF NOT EXISTS hostel_rooms (
  room_id INT AUTO_INCREMENT PRIMARY KEY,
  hostel_type ENUM('Boys Hostel','Girls Hostel') NOT NULL,
  room_number VARCHAR(20) NOT NULL,
  room_type ENUM('Non-AC (3 Sharing)','Non-AC (2 Sharing)','AC (2 Sharing)') NOT NULL,
  total_capacity TINYINT NOT NULL DEFAULT 3,
  occupied_beds TINYINT NOT NULL DEFAULT 0,
  status ENUM('Available','Full','Maintenance') DEFAULT 'Available',
  floor VARCHAR(10),
  block VARCHAR(10),
  INDEX idx_hostel_type (hostel_type),
  INDEX idx_hostel_status (status)
);

CREATE TABLE IF NOT EXISTS hostel_students (
  hostel_student_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  room_id INT,
  hostel_type ENUM('Boys Hostel','Girls Hostel'),
  room_type ENUM('Non-AC (3 Sharing)','Non-AC (2 Sharing)','AC (2 Sharing)'),
  room_number VARCHAR(20) DEFAULT 'Pending Allocation',
  allocation_status ENUM('Pending','Allocated','Vacated') DEFAULT 'Pending',
  admission_date DATE,
  vacate_date DATE,
  status ENUM('Active','Inactive') DEFAULT 'Active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (room_id) REFERENCES hostel_rooms(room_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS hostel_fees (
  hostel_fee_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  semester TINYINT NOT NULL,
  academic_year VARCHAR(10),
  hostel_admission_fee DECIMAL(10,2) DEFAULT 5000,
  security_deposit DECIMAL(10,2) DEFAULT 10000,
  hostel_fee DECIMAL(10,2),
  mess_fee DECIMAL(10,2) DEFAULT 25000,
  maintenance_fee DECIMAL(10,2),
  total_fee DECIMAL(10,2),
  payment_status ENUM('Pending','Paid','Partial') DEFAULT 'Pending',
  payment_date TIMESTAMP NULL,
  transaction_id VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
