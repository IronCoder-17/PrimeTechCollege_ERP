-- ============================================================
-- College Campus Connect — Admin Security Fix Migration
-- ============================================================
-- Run this once against your database (phpMyAdmin / mysql CLI).
--
-- Creates (or upgrades) a real admin account with a genuine
-- bcrypt password hash so admin login can go through the
-- hardened backend (POST /api/auth.php/login), which now issues
-- a signed, expiring token instead of a forgeable one.
--
-- Admin credentials:
--   Email:    admin1617@primetechcollege.edu
--   Password: admin@103
-- ============================================================

INSERT INTO users (name, email, password_hash, role, major, year, is_verified)
VALUES (
  'Admin User',
  'admin1617@primetechcollege.edu',
  '$2y$12$dsQQIkErUHQXAKQ5EXJr5.3/4seWbzdoslDu7lRUaITCTJpm2el.6',
  'admin',
  'Administration',
  NULL,
  1
)
ON DUPLICATE KEY UPDATE
  password_hash = VALUES(password_hash),
  role = 'admin',
  is_verified = 1;