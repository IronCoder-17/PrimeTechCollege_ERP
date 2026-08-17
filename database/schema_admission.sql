-- ============================================================
-- PrimeTech College — Admission & Fee Schema (Addendum)
-- Add after existing schema.sql
-- ============================================================


-- ── Courses ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS courses (
  id               INT AUTO_INCREMENT PRIMARY KEY,
  course_name      VARCHAR(200) NOT NULL,
  course_code      VARCHAR(20)  NOT NULL UNIQUE,  -- e.g. CE, IT, ME
  duration_years   TINYINT      NOT NULL,
  total_semesters  TINYINT      NOT NULL,
  department       VARCHAR(100),
  level            ENUM('UG','PG') DEFAULT 'UG',
  created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ── Fee Structure ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS fee_structure (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  course_id    INT        NOT NULL,
  semester     TINYINT    NOT NULL,
  tuition_fee  DECIMAL(10,2) NOT NULL,
  exam_fee     DECIMAL(10,2) NOT NULL DEFAULT 2500.00,
  total_fee    DECIMAL(10,2) GENERATED ALWAYS AS (tuition_fee + exam_fee) STORED,
  created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_course_sem (course_id, semester),
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

-- ── Students (Admission) ───────────────────────────────────
CREATE TABLE IF NOT EXISTS students (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  first_name     VARCHAR(80)  NOT NULL,
  middle_name    VARCHAR(80),
  last_name      VARCHAR(80)  NOT NULL,
  dob            DATE         NOT NULL,
  gender         ENUM('Male','Female','Other') NOT NULL,
  phone          VARCHAR(15)  NOT NULL,
  email          VARCHAR(180),
  address        TEXT,
  gr_number      VARCHAR(20)  UNIQUE,
  course_id      INT,
  semester       TINYINT,
  admission_year YEAR,
  status         ENUM('pending','active','inactive') DEFAULT 'pending',
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- ── Payments ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS payments (
  id                  INT AUTO_INCREMENT PRIMARY KEY,
  student_id          INT         NOT NULL,
  razorpay_order_id   VARCHAR(100),
  razorpay_payment_id VARCHAR(100),
  amount              DECIMAL(10,2) NOT NULL,
  payment_status      ENUM('pending','success','failed') DEFAULT 'pending',
  payment_date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- ── Documents ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS documents (
  id                INT AUTO_INCREMENT PRIMARY KEY,
  student_id        INT NOT NULL,
  tenth_marksheet   VARCHAR(300),
  twelfth_marksheet VARCHAR(300),
  photo             VARCHAR(300),
  uploaded_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- ── Student Login Credentials ─────────────────────────────
CREATE TABLE IF NOT EXISTS login_credentials (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  student_id    INT         NOT NULL UNIQUE,
  email         VARCHAR(180) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_students_gr    ON students(gr_number);
CREATE INDEX IF NOT EXISTS idx_students_email ON students(email);
CREATE INDEX IF NOT EXISTS idx_fee_course_sem ON fee_structure(course_id, semester);