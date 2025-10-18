-- Database initialization script for Web-TuxBot
-- Run this to set up complete database structure

-- Enable extensions
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Run migrations in order
\i migrations/001_create_tables.sql
\i migrations/002_add_foreign_keys.sql
\i migrations/003_add_indexes.sql

-- Display created tables
SELECT 
    table_name,
    COUNT(*) as column_count
FROM information_schema.columns 
WHERE table_schema = 'public'
GROUP BY table_name
ORDER BY table_name;