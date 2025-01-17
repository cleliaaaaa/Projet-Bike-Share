
create or replace table raw_gbfs.raw_station_info_2 as 
select 'SanFrancisco' as ville, "data".stations::json[] stations, last_updated, ttl, null as version
FROM 'https://gbfs.lyft.com/gbfs/2.3/bay/en/station_information.json'
UNION

select 'Lyon' as ville, "data".stations::json[] stations, last_updated, ttl, null as version
FROM "https://download.data.grandlyon.com/files/rdata/jcd_jcdecaux.jcdvelov/station_information.json";



