CREATE OR REPLACE TABLE model_stg.processed_station_status AS
WITH t AS (
    SELECT ville, unnest(stations) AS stations, last_updated, ttl, version
    FROM raw_gbfs.raw_station_status_2
)
SELECT
    ville,
    stations->>'station_id' AS station_id,
    (stations->>'is_installed') AS is_installed,
    (stations->>'is_renting') AS is_renting,
    stations->>'is_returning' AS is_returning,  
    to_timestamp((stations->>'last_reported')::BIGINT) AS last_reported,  -- Convert to TIMESTAMP
    (stations->>'num_bikes_available')::INT AS num_bikes_available,
    (stations->>'num_docks_available')::INT AS num_docks_available,
    to_timestamp(last_updated) AS last_updated,
    version
FROM t;


select *
from model_stg.processed_station_status
