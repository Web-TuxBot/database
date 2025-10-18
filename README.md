# Web-TuxBot Database

Complete PostgreSQL database schema for AI-powered Linux command assistant.

## Database Structure
- 10 main tables
- Proper foreign key relationships  
- Performance indexes
- UUID support for API

## Migrations
Run in order:
1. `001_create_tables.sql` - Creates all tables
2. `002_add_foreign_keys.sql` - Adds relationships
3. `003_add_indexes.sql` - Adds indexes

## Quick Start
```bash
psql -U postgres -d tuxbot_db -f scripts/init_database.sql