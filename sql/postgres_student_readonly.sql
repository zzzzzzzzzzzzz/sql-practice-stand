-- Sample: create a read-only student role for the "company" database.
-- Replace placeholders before running:
--   - company: target database name
--   - student_user: login name
--   - student_password: strong password

CREATE ROLE student_user LOGIN PASSWORD 'student_password';

GRANT CONNECT ON DATABASE company TO student_user;

-- Switch to the target database before granting schema/table permissions.
\connect company

GRANT USAGE ON SCHEMA public TO student_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO student_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO student_user;

-- Ensure future objects remain readable by the student role.
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT ON TABLES TO student_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT USAGE, SELECT ON SEQUENCES TO student_user;
