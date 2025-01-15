CREATE TABLE model_stg.processed_station_info AS

WITH t AS (
    SELECT
        ville,
        unnest(stations) AS stations,
        last_updated,
        ttl,
        version
    FROM raw_gbfs.raw_station_info_2
)
SELECT
    ville,
    stations->>'station_id' AS station_id,  
    stations->>'name' AS station_name, 
    stations->>'short_name' AS short_name,  
    (stations->>'capacity')::int AS capacity,  
    (stations->>'lat')::float AS latitude,  
    (stations->>'lon')::float AS longitude,
    stations->>'region_id' AS region_id, 
    stations->>'address' AS address, 
    last_updated,
    version
FROM t;
