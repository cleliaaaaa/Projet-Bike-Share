create or replace table geoloc.appartenance_quartier_gbfs
as
WITH point AS (
    SELECT
        station_id, 
        ST_Point(longitude, latitude) AS geom_point
    FROM model_stg.processed_station_info psi
)

SELECT 
    p.station_id,               
    s.nom  as quartier                  
FROM 
    point p
LEFT JOIN 
    geoloc.forme_quartiers s
ON 
    ST_Within(p.geom_point, s.geom);

CREATE OR REPLACE TABLE model_stg.processed_station_info AS
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
    t.ville,  
    t.stations->>'station_id' AS station_id,  
    t.stations->>'name' AS station_name,  
    t.stations->>'short_name' AS short_name,  
    (t.stations->>'capacity')::int AS capacity,  
    (t.stations->>'lat')::float AS latitude, 
    (t.stations->>'lon')::float AS longitude, 
    t.stations->>'region_id' AS region_id,  
    t.stations->>'address' AS address,  
    g.quartier,  
    t.last_updated,  
    t.version  
FROM t



 Left JOIN 
    geoloc.appartenance_quartier_gbfs g  
ON 
    t.stations->>'station_id' = g.station_id; 
   
select * from model_stg.processed_station_info 