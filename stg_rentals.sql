CREATE OR REPLACE TABLE model_stg.stg AS
WITH point AS (
    SELECT
        *,
        ST_Point(start_station_longitude, start_station_latitude) AS geom_point_deb,
        ST_Point(end_station_longitude, end_station_latitude) AS geom_point_fin
    FROM (
        SELECT 
            rideable_type, 
            DATEDIFF('SECOND', started_at, ended_at) AS duration_seconds, 
            started_at AS start_time, 
            ended_at AS end_time, 
            start_station_name, 
            start_station_id, 
            start_lat AS start_station_latitude, 
            start_lng AS start_station_longitude, 
            end_station_name, 
            end_station_id, 
            end_lat AS end_station_latitude, 
            end_lng AS end_station_longitude, 
            member_casual AS user_type
        FROM raw_rentals.v2

        UNION ALL

        SELECT
            NULL AS rideable_type, 
            duration_sec AS duration_seconds, 
            start_time,
            end_time, 
            start_station_name, 
            start_station_id, 
            start_station_latitude,
            start_station_longitude,
            end_station_name,
            end_station_id, 
            end_station_latitude,
            end_station_longitude, 
            user_type
        FROM raw_rentals.v3

        UNION ALL

        SELECT 
            NULL AS rideable_type, 
            duration_sec AS duration_seconds, 
            start_time, 
            end_time, 
            start_station_name, 
            start_station_id, 
            start_station_latitude, 
            start_station_longitude, 
            end_station_name, 
            end_station_id, 
            end_station_latitude, 
            end_station_longitude, 
            CASE 
                WHEN user_type = 'Subscriber' THEN 'member' 
                ELSE 'casual' 
            END AS user_type
        FROM raw_rentals.v1
    ) AS rentals
)
SELECT 
    rideable_type, 
    duration_seconds, 
    start_time,
    end_time, 
    start_station_name, 
    start_station_id, 
    start_station_latitude,
    start_station_longitude,
    end_station_name,
    end_station_id, 
    end_station_latitude,
    end_station_longitude,             
    sdeb.nom AS quartierdeb,
    sfin.nom AS quartierfin
FROM 
    point p
LEFT JOIN 
    geoloc.forme_quartiers fq sdeb
ON 
    ST_Within(p.geom_point_deb, sdeb.geom)
LEFT JOIN 
    geoloc.forme_quartiers fq sfin
ON 
    ST_Within(p.geom_point_fin, sfin.geom);
   
   select * from model_stg.stg 
