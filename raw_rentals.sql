

set variable path_input = 'C:/Users/cleli/Desktop/rentals/*.csv';
select getvariable('path_input')

create or replace table raw_rentals.v2
as
SELECT *
FROM "C:\Users\cleli\Desktop\rentals\data2\*.csv";

create or replace table raw_rentals.v1
as
SELECT *
FROM "C:\Users\cleli\Desktop\rentals\data\*.csv";


--create table raw_gbfs.earth_system as 
--from "https://raw.githubusercontent.com/MobilityData/gbfs/refs/heads/master/systems.csv";

--select *, lower(location) location_lower
--from raw_gbfs.earth_system
--where location_lower like '%san francisco%'
--or location_lower like '%toulouse%'