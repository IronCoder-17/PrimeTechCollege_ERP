-- ============================================================
-- Transportation Management Module — Schema (Addendum)
-- Add after schema.sql / schema_admission.sql / schema_fee_management.sql
-- ============================================================


-- ── Transportation Routes ───────────────────────────────────
-- Single source of truth for bus routes, bus numbers, and fees.
-- Admin manages these from the Admin Panel "Transportation
-- Management" section; the Student Registration form and fee
-- receipts always read the live values from this table.
CREATE TABLE IF NOT EXISTS transportation_routes (
  id             BIGINT AUTO_INCREMENT PRIMARY KEY,
  location       VARCHAR(100) UNIQUE NOT NULL,
  bus_number     VARCHAR(50)  NOT NULL,
  transport_fee  DECIMAL(10,2) NOT NULL DEFAULT 0,
  status         ENUM('active','inactive') DEFAULT 'active',
  created_at     TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at     TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Seed the default coverage areas (admin can edit fees / bus
-- numbers / status at any time from the Admin Panel).
INSERT IGNORE INTO transportation_routes (location, bus_number, transport_fee, status) VALUES
  ('Rajkot',          'BUS-01', 2000.00, 'active'),
  ('Wankaner',        'BUS-02', 1500.00, 'active'),
  ('Gondal',           'BUS-03', 1800.00, 'active'),
  ('Porbandar',        'BUS-04', 2200.00, 'active'),
  ('Morbi',            'BUS-05', 2500.00, 'active'),
  ('Jetpur',           'BUS-06', 1700.00, 'active'),
  ('Jamnagar',         'BUS-07', 2100.00, 'active'),
  ('Dhrol',            'BUS-08', 1600.00, 'active'),
  ('Surendranagar',    'BUS-09', 1900.00, 'active'),
  ('Maliya-Miyana',    'BUS-10', 1400.00, 'active');

-- ── Students table additions ────────────────────────────────
-- Captured at registration time. transport_location / bus_number
-- / transport_fee are auto-populated from transportation_routes
-- based on the student's selected location, and stay in sync with
-- whatever the Admin has configured at the time of registration.
ALTER TABLE students
  ADD COLUMN IF NOT EXISTS transport_required ENUM('Yes','No') DEFAULT 'No' AFTER address,
  ADD COLUMN IF NOT EXISTS transport_location  VARCHAR(100) NULL AFTER transport_required,
  ADD COLUMN IF NOT EXISTS bus_number           VARCHAR(50)  NULL AFTER transport_location,
  ADD COLUMN IF NOT EXISTS transport_fee        DECIMAL(10,2) DEFAULT 0 AFTER bus_number;

-- Indexes
CREATE INDEX IF NOT EXISTS idx_transport_routes_status   ON transportation_routes(status);
CREATE INDEX IF NOT EXISTS idx_students_transport_location ON students(transport_location);