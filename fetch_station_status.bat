%~d0
cd %~dp0


duckdb bikeshare.db  "Insert into raw_gbfs.raw_station_status_2  select 'SanFrancisco' as ville, ""data"".stations::json[] stations, last_updated, ttl, null as version FROM 'https://gbfs.lyft.com/gbfs/2.3/bay/en/station_status.json'";

duckdb bikeshare.db  "Insert into raw_gbfs.raw_station_status_2  select 'Lyon' as ville, ""data"".stations::json[] stations, last_updated, ttl, null as version FROM 'https://download.data.grandlyon.com/files/rdata/jcd_jcdecaux.jcdvelov/station_status.json'";

