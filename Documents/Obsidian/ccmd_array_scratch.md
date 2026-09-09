-- Testing liquibase changeset for 3.2.5
-- Create dependencies
WITH event_deps AS (
    INSERT INTO acm_container(id, acm_string)
        VALUES (DEFAULT, 'test_acm_array')
        RETURNING id AS acm_id
)
-- Insert the test data for the event table
INSERT INTO event(
                  acm_id,
                  class_iri,
                  class_name,
                  name,
                  aors
)
-- Null array
SELECT
        acm_id,
        'test',
        'test',
        'null_test',
        NULL
FROM event_deps
UNION ALL
-- Empty array
SELECT
    acm_id,
        'test',
        'test',
        'empty_test',
        ARRAY[]::text[]
FROM event_deps
UNION ALL
-- Null value in the array
SELECT
    acm_id,
           'test',
           'test',
           'null_string_test',
           ARRAY['test', NULL, 'test', NULL, 'test', NULL]
FROM event_deps
UNION ALL
-- Empty string in the array
SELECT
    acm_id,
           'test',
           'test',
           'empty_string_test',
           ARRAY['test', '', 'test', '', 'test', '']
FROM event_deps
UNION ALL
-- Empty string and null value in the array
SELECT
    acm_id,
           'test',
           'test',
           'empty_null_test',
           ARRAY['test', '', '', 'test', NULL, NULL, 'test']
FROM event_deps;