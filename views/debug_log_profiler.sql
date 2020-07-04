CREATE OR REPLACE VIEW debug_log_profiler AS
WITH x AS (
    SELECT
        MAX(c.run_id)   AS coverage_id,
        MAX(p.runid)    AS profiler_id
    FROM dbmspcc_runs c
    CROSS JOIN plsql_profiler_runs p
)
SELECT
    s.name, s.type, s.line,
    d.total_occur, d.total_time, d.max_time,
    b.block, b.col, b.covered,
    s.text AS source_line
FROM plsql_profiler_units p
JOIN plsql_profiler_data d
    ON p.runid          = d.runid
    AND p.unit_number   = d.unit_number
JOIN user_source s
    ON s.name           = p.unit_name
    AND s.type          = p.unit_type
    AND s.line          = d.line#
CROSS JOIN x
LEFT JOIN dbmspcc_units c
    ON  c.name          = s.name
    AND c.type          = s.type
    AND c.run_id        = x.coverage_id
LEFT JOIN dbmspcc_blocks b
    ON  b.run_id        = c.run_id
    AND b.object_id     = c.object_id
    AND b.line          = s.line
WHERE p.runid           = x.profiler_id
    AND p.unit_owner    = USER;

