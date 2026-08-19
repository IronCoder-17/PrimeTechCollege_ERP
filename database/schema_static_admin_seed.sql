-- ============================================================
-- College Campus Connect — Static Admin Placeholder Row
-- ============================================================
-- OPTIONAL. Run this once if you want Admin Dashboard actions
-- (edit/delete/status/password-reset on Students & Faculty) to
-- keep showing up in the Activity Log after switching Admin
-- Login to static credentials.
--
-- WHY THIS IS NEEDED:
-- admin_activity_log.admin_id has a FOREIGN KEY to users(id).
-- The new static admin session (see backend/config/helpers.php
-- -> STATIC_ADMIN_ID) is NOT a real row in `users`, since Admin
-- Login no longer queries the database at all. Without a
-- matching row, every activity-log INSERT for an admin action
-- fails the FK check; admin.php already catches that failure
-- silently (see logActivity()), so nothing breaks — the action
-- itself always succeeds — but the entry is simply not recorded.
--
-- This script inserts ONE placeholder row so those log entries
-- can be written again. This row is NEVER read for login/auth —
-- Admin Login still authenticates purely via the static
-- credentials in helpers.php, not against this or any other
-- `users` row. This purely satisfies referential integrity for
-- the activity log.
--
-- Safe to run multiple times (idempotent via ON DUPLICATE KEY).
-- Safe to skip entirely — the app works fully without it, you
-- just won't see these specific log rows.
-- ============================================================

INSERT INTO users (id, name, email, password_hash, role, major, year, is_verified)
VALUES (
  999999999,
  'Administrator',
  'admin1617@primetechcollege.edu',
  -- Unusable placeholder hash: this row is never checked by the
  -- login flow (which no longer verifies any password against
  -- the database), so this value is not a real credential.
  '$2y$12$staticadminplaceholderrowneverusedforauthxxxxxxxxxxxxx',
  'admin',
  'Administration',
  NULL,
  1
)
ON DUPLICATE KEY UPDATE
  name = 'Administrator',
  role = 'admin';
