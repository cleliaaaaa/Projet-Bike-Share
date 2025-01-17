--install spatial;
load spatial;
create or replace table geoloc.forme_quartiers
as
with t as (
	select unnest(features) feat
	from "C:\Users\cleli\Desktop\bikeshare_projet\map\geo.json"
)
select
  feat.properties props,
  feat.id,
  feat.properties.nom,
  ST_GeomFromGeoJSON(feat.geometry::json) geom
from t;


   

