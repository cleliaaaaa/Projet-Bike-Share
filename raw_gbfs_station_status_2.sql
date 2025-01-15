
create or replace table raw_gbfs.raw_station_status_2 as 
select 'SanFrancisco' as ville, "data".stations::json[] stations, last_updated, ttl, null as version
FROM 'https://gbfs.lyft.com/gbfs/2.3/bay/en/station_status.json';


--insert into raw_gbfs.raw_station_status_2
--select 'Paris' as ville, "data".stations::json[] stations, last_updated, ttl, null as version
--FROM 'https://velib-metropole-opendata.smovengo.cloud/opendata/Velib_Metropole/station_status.json


select * from raw_gbfs.raw_station_status_2;

with t as (
	select ville, unnest(stations) stations, last_updated, ttl, version
	from raw_gbfs.raw_station_status_2
)
select
	ville,
	stations->>'station_id' station_id,
	(stations->>'is_installed')::int is_installed,
	(stations->>'is_renting')::int is_renting,
	stations->'is_returning',
	stations->'last_reported',
	stations->'num_bikes_available',
	stations->'num_docks_available',
	stations station_raw,
	last_updated,
	version
from t;

select *
from raw_gbfs.raw_station_status_2;

