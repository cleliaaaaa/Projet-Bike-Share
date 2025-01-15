CREATE OR REPLACE TABLE model_stg.stg_station AS
SELECT *
FROM model_stg.processed_station_info psi, model_stg.processed_station_status pss,geoloc.appartenance g
WHERE psi.station_id=pss.station_id
and g.station_id=pss.station_id
