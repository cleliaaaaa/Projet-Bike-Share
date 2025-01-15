
create or replace table raw_gbfs.raw_station_info_2 as 
select 'SanFrancisco' as ville, "data".stations::json[] stations, last_updated, ttl, null as version
FROM 'https://gbfs.lyft.com/gbfs/2.3/bay/en/station_information.json';


--insert into raw.raw_station_status_2
--select 'toulouse' as ville, "data".stations::json[] stations, last_updated, ttl, null as version
--FROM 'https://transport.data.gouv.fr/gbfs/toulouse/station_status.json'

-------------------------------------


select * from raw_gbfs.raw_station_info_2;

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


