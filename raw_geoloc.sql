--install spatial;
load spatial;
create or replace table geoloc.forme
as
with t as (
	select unnest(features) feat
	from "C:\Users\cleli\Desktop\bikeshare_projet\geo.json"
)
select
  feat.properties props,
  feat.id,
  feat.properties.nom,
  ST_GeomFromGeoJSON(feat.geometry::json) geom
from t;


with point as (
    select
        station_id, 
        ST_Point(longitude, latitude) AS geom_point
    from model_stg.stg_station ss 
)
select 
    p.station_id,               -- L'ID du point
    s.nom,              
from 
    point p
left join 
    geoloc.forme s
on 
    ST_Within(p.geom_point, s.geom);

   
create or replace table geoloc.appartenance
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
    geoloc.forme s
ON 
    ST_Within(p.geom_point, s.geom);

