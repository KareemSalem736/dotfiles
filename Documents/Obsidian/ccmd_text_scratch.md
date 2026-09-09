-- Testing liquibase changeset for 3.2.5
-- Create dependencies
WITH acm_dep AS (
    INSERT INTO acm_container(id, acm_string)
        VALUES (DEFAULT, 'test_acm_text')
        RETURNING id AS acm_id
),
    originator_dep AS (
        INSERT INTO originator(
                               id,
                               version,
                               acm_id,
                               name)
            SELECT
                DEFAULT,
                DEFAULT,
                acm_id,
                'test_originator'
            FROM acm_dep
        RETURNING id AS originator_id
    ),
    provider_dep AS (
        INSERT INTO provider (
                              id,
                              version,
                              acm_id,
                              name,
                              originator_id
            )
            SELECT
                DEFAULT,
                   DEFAULT,
                   acm_id,
                   'test_provider',
                   originator_id
            FROM acm_dep, originator_dep
            RETURNING id AS track_provider_id)
-- Insert the test data for the node table
INSERT INTO node(
                 id,
                 version,
                 acm_id,
                 name,
                 tier,
                 domain,
                 class_iri,
                 class_iri_chain,
                 class_name,
                 allegiance_aor,
                 current_aor,
                 is_nso,
                 track_provider_id
)
-- Empty string
SELECT
    DEFAULT,
    DEFAULT,
    acm_id,
    'empty_test',
    'test',
    'test',
    'test',
    ARRAY['test'],
    'test',
    '',
    '',
    DEFAULT,
    track_provider_id
FROM acm_dep, provider_dep
UNION ALL
-- Null
SELECT
    DEFAULT,
    DEFAULT,
    acm_id,
    'null_test',
    'test',
    'test',
    'test',
    ARRAY['test'],
    'test',
    NULL,
    NULL,
    DEFAULT,
    track_provider_id
FROM acm_dep, provider_dep;