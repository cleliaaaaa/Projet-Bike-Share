CREATE or replace TABLE model_stg.processed_station_status AS
WITH t AS (
    SELECT ville, unnest(stations) AS stations, last_updated, ttl, version
    FROM raw_gbfs.raw_station_status_2
)
SELECT
    ville,
    stations->>'station_id' AS station_id,
    (stations->>'is_installed')::int AS is_installed,
    (stations->>'is_renting')::int AS is_renting,
    stations->'is_returning' AS is_returning,
    stations->'last_reported' AS last_reported,
    stations->'num_bikes_available' AS num_bikes_available,
    stations->'num_docks_available' AS num_docks_available,
    stations AS station_raw,
    last_updated,
    version
FROM t;