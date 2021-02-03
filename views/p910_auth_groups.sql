CREATE OR REPLACE VIEW p910_auth_groups AS
SELECT
    a.authorization_scheme_name     AS auth_scheme,
    MAX(s.procedure_name)           AS auth_procedure,
    MAX(a.attribute_01)             AS auth_source,
    MAX(a.error_message)            AS error_message,
    MAX(a.caching)                  AS caching,
    --
    CASE WHEN MAX(s.procedure_name) IS NOT NULL
        THEN '<span class="fa fa-check-square" style="color: #666;" title="Auth procedure exists"></span>'
        END AS valid,
    --
    NULLIF(COUNT(p.page_id), 0)     AS pages
FROM apex_application_authorization a
LEFT JOIN apex_application_pages p
    ON p.application_id             = a.application_id
    AND p.authorization_scheme      = a.authorization_scheme_name
LEFT JOIN user_procedures s
    ON s.object_name                = 'AUTH'  -- nav.auth_package
    AND s.procedure_name            = p.authorization_scheme
WHERE a.application_id              = sess.get_app_id()
    AND p.page_group                = NVL(apex.get_item('$PAGE_GROUP'), p.page_group)
    AND a.authorization_scheme_name = NVL(apex.get_item('$AUTH_SCHEME'), a.authorization_scheme_name)
GROUP BY a.authorization_scheme_name;