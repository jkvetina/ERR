--
-- create context
--
CREATE CONTEXT APP USING lumberjack.sess;



--
-- create tables and sequences
--
@../tables/logs.sql
@../tables/logs_lobs.sql
@../tables/logs_setup.sql
@../tables/users.sql
@../tables/sessions.sql
--
@../sequences/log_id.sql
@../sequences/session_id.sql



--
-- create packages
--
@../procedures/recompile.sql
--
@../packages/tree.spec.sql
@../packages/sess.spec.sql



--
-- profiler + coverage tables
--
@./proftab.sql
EXEC DBMS_PLSQL_CODE_COVERAGE.CREATE_COVERAGE_TABLES(force_it => TRUE);



--
-- create views
--
@../views/logs_tree.sql
@../views/logs_dml_errors.sql
@../views/logs_modules.sql
@../views/logs_profiler.sql
@../views/logs_profiler_sum.sql



--
-- create packages and procedures
--
@../procedures/process_dml_errors.sql
--
@../packages/sess.sql
@../packages/tree.sql



--
-- create jobs
--
@../jobs/process_dml_errors_.sql
@../jobs/purge_old_logs.sql
