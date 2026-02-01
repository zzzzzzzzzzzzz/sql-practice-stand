-- Sample: create a read-only student role for the "company" database.
-- Replace placeholders before running:
--   - company: target database name
--   - student_user: login name
--   - student_password: strong password

CREATE ROLE student_user LOGIN PASSWORD 'student_password';

GRANT CONNECT ON DATABASE company TO student_user;

-- Run the remaining statements while connected to the target database.

GRANT USAGE ON SCHEMA public TO student_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO student_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO student_user;

-- Ensure future objects created by the current role remain readable by the student role.
-- Repeat for any other role that owns schema objects (or use FOR ROLE <owner>).
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT ON TABLES TO student_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT USAGE, SELECT ON SEQUENCES TO student_user;
