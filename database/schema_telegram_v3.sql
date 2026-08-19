-- ============================================================
-- Telegram Bot Integration — pending credentials for late-linkers
-- Run this after schema_telegram_v2.sql (same way: phpMyAdmin → Import)
-- ============================================================

-- Holds the generated credentials just long enough for a student/faculty
-- to link their Telegram (if they weren't linked yet at admission time).
-- Row is deleted the instant it's delivered, so plaintext passwords never
-- sit here longer than necessary.
CREATE TABLE IF NOT EXISTS telegram_pending_credentials (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  phone       VARCHAR(20) NOT NULL,
  recipient_type ENUM('student','faculty') NOT NULL,
  payload     TEXT NOT NULL,      -- JSON: name, enroll_no, gr_no, course, department, email, password
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_pending_phone (phone)
);
