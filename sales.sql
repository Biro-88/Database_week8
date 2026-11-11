-- Week 8 Assignment: MySQL Database Backup and Restore
-- File: answer.sql
--
-- NOTE: mysqldump is a command-line utility, NOT an SQL statement.
-- The commands below must be run in your system terminal / command
-- prompt (not inside MySQL Workbench's query editor). They are written
-- here as comments so this file stays valid SQL.





-- QUESTION 1: Creating a Complete Database Backup

-- Command:
--
--   mysqldump -u root -p sales > sales_backup.sql
--
-- Explanation:
--   mysqldump       : MySQL utility that creates a logical backup of a database.
--                     It produces a text file of SQL statements (CREATE TABLE,
--                     INSERT, etc.) that can be replayed to rebuild the database.
--   -u root         : connects to the MySQL server as the user "root".
--   -p              : makes MySQL prompt for the password, so the password is
--                     not typed in the command (safer than putting it in the
--                     command line or shell history).
--   sales           : the name of the database being backed up.
--   > sales_backup.sql : redirects the output into the file sales_backup.sql
--                     instead of printing it on the screen.
--
-- The resulting file contains both the structure (tables, keys) and the
-- data (rows) of the sales database.
--
-- To restore it later:
--   mysql -u root -p sales < sales_backup.sql
--   (the sales database must already exist; create it first with
--    CREATE DATABASE sales; if needed)
--
-- Why regular backups are important:
--   - Protection against data loss caused by hardware failure, accidental
--     deletion, human error, or a bad UPDATE/DELETE statement.
--   - Safety net before major changes such as schema updates, upgrades,
--     or data migrations: if something goes wrong, the database can be
--     restored to its previous state.
--   - Disaster recovery and business continuity: after a crash, cyberattack
--     or ransomware incident, backups allow the business to recover quickly.
--   - Supports database migration and copying data to test or development
--     environments.
--   - Helps meet data retention, audit and compliance requirements.





-- QUESTION 2: Backing Up All Databases

-- Command:
--
--   mysqldump -u root -p --all-databases > all_databases_backup.sql
--
-- Explanation:
--   --all-databases : exports every database on the server (including sales)
--                     in one dump file. The dump includes CREATE DATABASE and
--                     USE statements, so each database is recreated
--                     automatically when the file is restored. It also
--                     includes the system "mysql" database, which holds user
--                     accounts and privileges.
--   -u root         : connects as the "root" user.
--   -p              : prompts for the password.
--   > all_databases_backup.sql : saves the output to all_databases_backup.sql.
--
-- To restore it on the new server:
--   mysql -u root -p < all_databases_backup.sql
--
-- Why backing up all databases is important before migrating to another server:
--   - Completeness: nothing is left behind. Every database, table, and row
--     is captured, so the new server can be an exact copy of the old one.
--   - Safety: if the migration fails or data is corrupted on the way, the
--     original data can still be restored, so there is no data loss.
--   - Users and permissions: the dump includes the system "mysql" database,
--     so accounts and privileges can be carried over, which reduces manual
--     setup and access problems on the new server.
--   - Simplicity: one file and one restore command rebuild the entire
--     server contents, which saves time and reduces human error.
--   - Rollback option: the backup lets the team return to the old setup
--     quickly if the new server has problems.
--   - Verification: the backup can be used to compare and confirm that all
--     data arrived correctly after migration.




-- QUESTION 3: Data-Only Backup of the sales Database
-- (The brief lists three questions but only two were provided; the
--  learning objectives mention data-only backups, so this is included.)

-- Command:
--
--   mysqldump -u root -p --no-create-info sales > sales_data_only_backup.sql
--
-- Explanation:
--   --no-create-info : skips the CREATE TABLE statements, so the file
--                      contains only the INSERT statements (the data).
--   -u root          : connects as the "root" user.
--   -p               : prompts for the password.
--   sales            : the database being backed up.
--   > sales_data_only_backup.sql : saves the output to this file.
--
-- Use case: restoring or copying the rows into a database whose tables
-- already exist (for example, refreshing a test database with real data).
-- Because the table structure is not included, the tables must already
-- exist before the file is restored:
--   mysql -u root -p sales < sales_data_only_backup.sql
