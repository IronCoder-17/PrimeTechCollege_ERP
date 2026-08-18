-- ============================================================
-- Admin Dashboard Enhancement — Dynamic Fee & Hostel Management
-- Add after schema.sql / schema_admission.sql
-- ============================================================


-- ── Global Fee Settings ─────────────────────────────────────
-- Single source of truth for fees that are NOT tied to a specific
-- course/semester (registration fee, one-time admission charges,
-- exam fee default, misc "other charges"). Admin edits these from
-- the Fee Management tab; the Admission/Registration page and
-- student dashboards read them live via /api/fees.php.
CREATE TABLE IF NOT EXISTS fee_settings (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  fee_key       VARCHAR(60)  NOT NULL UNIQUE,   -- e.g. 'registration_fee', 'admission_fee', 'exam_fee', 'id_card_fee'
  label         VARCHAR(120) NOT NULL,          -- human-readable label shown in Admin UI
  amount        DECIMAL(10,2) NOT NULL DEFAULT 0,
  category      ENUM('college','registration','hostel','other') NOT NULL DEFAULT 'other',
  description   VARCHAR(255),
  updated_by    INT,                            -- admin user id who last changed it
  updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- Seed default global fee settings (admin can edit any of these later)
INSERT IGNORE INTO fee_settings (fee_key, label, amount, category, description) VALUES
  ('registration_fee', 'Registration Fee',        2000.00, 'registration', 'One-time fee charged at the time of admission/registration'),
  ('admission_fee',    'Admission Fee',           5000.00, 'college',      'One-time admission processing fee'),
  ('exam_fee',         'Examination Fee',         2500.00, 'college',      'Per-semester examination fee, added to tuition fee'),
  ('id_card_fee',      'ID Card Fee',              500.00, 'other',        'One-time student ID card issuance fee'),
  ('library_deposit',  'Library Deposit',         3000.00, 'other',        'Refundable library security deposit'),
  ('convocation_fee',  'Convocation Fee',         5000.00, 'other',        'One-time convocation/graduation fee');

-- ── Hostel Fee Plans ─────────────────────────────────────────
-- Admin can Add / Edit / Delete plans here. Each plan covers a
-- hostel_type + room_type combination with its component fees.
-- The Admission page and Hostel application flow fetch these live.
CREATE TABLE IF NOT EXISTS hostel_fee_plans (
  id                    INT AUTO_INCREMENT PRIMARY KEY,
  hostel_type           ENUM('Boys Hostel','Girls Hostel') NOT NULL,
  room_type             ENUM('Non-AC (3 Sharing)','Non-AC (2 Sharing)','AC (2 Sharing)') NOT NULL,
  hostel_admission_fee  DECIMAL(10,2) NOT NULL DEFAULT 5000.00,  -- one-time
  security_deposit      DECIMAL(10,2) NOT NULL DEFAULT 10000.00, -- one-time, refundable
  hostel_fee            DECIMAL(10,2) NOT NULL DEFAULT 0,        -- per semester
  mess_fee              DECIMAL(10,2) NOT NULL DEFAULT 25000.00, -- per semester
  maintenance_fee       DECIMAL(10,2) NOT NULL DEFAULT 3000.00,  -- per semester
  total_fee             DECIMAL(10,2) GENERATED ALWAYS AS (
    hostel_admission_fee + security_deposit + hostel_fee + mess_fee + maintenance_fee
  ) STORED,
  is_active             TINYINT(1) DEFAULT 1,
  updated_by            INT,
  updated_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_hostel_room (hostel_type, room_type),
  FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- Seed default hostel fee plans (matches previous hardcoded AdmissionPage values)
INSERT IGNORE INTO hostel_fee_plans
  (hostel_type, room_type, hostel_admission_fee, security_deposit, hostel_fee, mess_fee, maintenance_fee) VALUES
  ('Boys Hostel',  'Non-AC (3 Sharing)', 5000, 10000, 35000, 25000, 3000),
  ('Boys Hostel',  'Non-AC (2 Sharing)', 5000, 10000, 45000, 25000, 3000),
  ('Boys Hostel',  'AC (2 Sharing)',     5000, 10000, 60000, 25000, 5000),
  ('Girls Hostel', 'Non-AC (3 Sharing)', 5000, 10000, 38000, 25000, 3000),
  ('Girls Hostel', 'Non-AC (2 Sharing)', 5000, 10000, 48000, 25000, 3000),
  ('Girls Hostel', 'AC (2 Sharing)',     5000, 10000, 65000, 25000, 5000);

-- ── Admin User Bridge ────────────────────────────────────────
-- The frontend mock AuthContext logs in a fixed "Admin User"
-- (id=2, admin@university.edu, role=admin) and issues a token of
-- the form "mock-token-2-<timestamp>". For the new Admin/Fees APIs
-- (which use requireAdmin()) to authenticate this user, a matching
-- row must exist in `users` with id=2 and role='admin'.
--
-- If a user with id=2 already exists from seed.sql (e.g. 'Maya
-- Patel'), promote it to admin and overwrite its identity to match
-- the mock admin account. If id=2 does not exist, insert it.
INSERT INTO users (id, name, email, password_hash, avatar, bio, major, year, campus, role, is_verified)
VALUES (2, 'Admin User', 'admin@university.edu', '$2y$12$adminseedhashplaceholder', 
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop',
        'Campus platform administrator.', 'Administration', 'Graduate', 'Main Campus', 'admin', 1)
ON DUPLICATE KEY UPDATE
  name = 'Admin User',
  email = 'admin@university.edu',
  role = 'admin',
  is_verified = 1;


CREATE TABLE IF NOT EXISTS admin_activity_log (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  admin_id    INT,
  action      VARCHAR(120) NOT NULL,   -- e.g. 'updated_fee', 'edited_student', 'deactivated_faculty'
  target_type VARCHAR(40),             -- 'student' | 'faculty' | 'fee_setting' | 'hostel_plan'
  target_id   INT,
  details     TEXT,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (admin_id) REFERENCES users(id)
);

CREATE INDEX idx_activity_created ON admin_activity_log(created_at DESC);

-- ── Additional editable profile fields ──────────────────────
-- Students table: add fields needed by Admin profile editor
ALTER TABLE students
  ADD COLUMN IF NOT EXISTS profile_photo VARCHAR(500) AFTER address;

-- Faculty table: add salary field for Admin profile editor (sensitive — admin only)
ALTER TABLE faculty
  ADD COLUMN IF NOT EXISTS salary DECIMAL(10,2) AFTER experience;

ALTER TABLE faculty_documents
  MODIFY COLUMN profile_photo VARCHAR(500);