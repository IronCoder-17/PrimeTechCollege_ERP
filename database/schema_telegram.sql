-- ============================================================
-- Telegram Bot Integration — schema additions (CORRECTED)
-- Your live database has no separate `faculty` table — faculty
-- accounts are rows in `users` with role = 'faculty'. This version
-- targets `students` and `users` instead of `students` + `faculty`.
--
-- Run in phpMyAdmin: select your database → Import tab → choose this
-- file → Go. (Or via CLI: mysql -u root -p your_db < this_file.sql)
-- ============================================================

-- 1. Student Telegram chat id ----------------------------------------------
ALTER TABLE students
  ADD COLUMN IF NOT EXISTS telegram_chat_id VARCHAR(64) NULL DEFAULT NULL AFTER phone,
  ADD INDEX IF NOT EXISTS idx_students_telegram_chat_id (telegram_chat_id);

-- 2. Faculty (and every other) Telegram chat id — stored on `users` -------
-- NOTE: `users` has no `phone` column in most versions of this schema.
-- If the ALTER below errors on "Unknown column 'phone'", tell me and
-- I'll give you a version that adds a phone column too — the bot needs
-- a phone number on the users row to match faculty by mobile number.
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS telegram_chat_id VARCHAR(64) NULL DEFAULT NULL,
  ADD INDEX IF NOT EXISTS idx_users_telegram_chat_id (telegram_chat_id);

-- 3. Pending phone -> chat_id links -----------------------------------------
-- The bot writes here the moment someone shares/types their mobile number,
-- BEFORE we know whether that number belongs to a student or a faculty
-- member. The admission flow looks this up by phone and copies the
-- chat_id onto students.telegram_chat_id or users.telegram_chat_id.
CREATE TABLE IF NOT EXISTS telegram_chat_links (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  phone         VARCHAR(20)  NOT NULL,
  chat_id       VARCHAR(64)  NOT NULL,
  telegram_username VARCHAR(100) NULL,
  linked_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uniq_phone (phone),
  UNIQUE KEY uniq_chat_id (chat_id)
);

-- 4. Failed-message log -------------------------------------------------------
CREATE TABLE IF NOT EXISTS telegram_message_log (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  chat_id       VARCHAR(64)  NULL,
  recipient_type ENUM('student','faculty','unlinked') NOT NULL DEFAULT 'unlinked',
  recipient_ref VARCHAR(64)  NULL,        -- gr_number / employee_id / phone
  message       TEXT NOT NULL,
  status        ENUM('sent','failed') NOT NULL,
  http_code     INT NULL,
  response_body TEXT NULL,
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);