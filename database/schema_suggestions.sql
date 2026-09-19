-- ============================================================
-- Suggestion Box — Schema
--
-- Additive migration only. Does not modify or drop any existing
-- table. Reused by Student, Faculty, and Admin.
--
-- `user_id` is intentionally NOT a hard foreign key: for
-- user_role = 'student' it refers to students.id, and for
-- user_role = 'faculty' it refers to faculty.faculty_id — two
-- different tables/id-spaces. All identity resolution and
-- ownership checks are enforced server-side in
-- backend/api/suggestions.php (never trusted from the client),
-- following the same convention already used by
-- schema_faculty_student_messages.sql for faculty_id.
-- ============================================================

CREATE TABLE IF NOT EXISTS suggestions (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    user_id         INT NOT NULL,
    user_role       ENUM('student','faculty') NOT NULL,
    user_name       VARCHAR(160) NOT NULL,      -- denormalized snapshot for fast admin listing
    title           VARCHAR(200) NOT NULL,
    description     TEXT NOT NULL,
    category        VARCHAR(80) NOT NULL DEFAULT 'General',
    status          ENUM(
        'Pending',
        'Under Review',
        'In Progress',
        'Implemented',
        'Rejected'
    ) NOT NULL DEFAULT 'Pending',
    admin_response  TEXT NULL,
    reviewed_by     VARCHAR(160) NULL,          -- admin display name/email, no hard FK (admin may be static)
    reviewed_at     DATETIME NULL,
    is_seen_by_user TINYINT(1) NOT NULL DEFAULT 1, -- flips to 0 whenever admin updates status/response
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_suggestions_user (user_id, user_role),
    INDEX idx_suggestions_status (status),
    INDEX idx_suggestions_category (category),
    INDEX idx_suggestions_created (created_at)
);
