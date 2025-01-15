

set variable path_input = 'C:/Users/cleli/Desktop/rentals/*.csv';
select getvariable('path_input')

create or replace table raw_rentals.v1
as
SELECT *
FROM "C:\Users\cleli\Desktop\bikeshare_projet\data\rentals_v1\*.csv";

create or replace table raw_rentals.v2
as
SELECT *
FROM "C:\Users\cleli\Desktop\bikeshare_projet\data\rentals_v2\*.csv";

create or replace table raw_rentals.v3
as
SELECT *
FROM "C:\Users\cleli\Desktop\bikeshare_projet\data\rentals_v3\*.csv";