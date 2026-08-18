-- ============================================================
-- Fee Structure Management — Additional Fee Categories
-- Add after schema_fee_management.sql
--
-- Adds the remaining "Other Fees" categories called out in the
-- Fee Structure Management spec that were not yet present in
-- fee_settings: Laboratory Fee and Activity / Sports Fee.
-- Admin can edit these from Fee Structure Management →
-- "Registration & Other Charges" exactly like every other global
-- charge; nothing here is hard-coded on the frontend.
-- ============================================================


INSERT IGNORE INTO fee_settings (fee_key, label, amount, category, description) VALUES
  ('lab_fee',       'Laboratory Fee',        3500.00, 'college', 'Per-semester laboratory/practical fee'),
  ('activity_fee',  'Activity / Sports Fee', 1500.00, 'other',   'Per-year fee for sports, clubs, and student activities');