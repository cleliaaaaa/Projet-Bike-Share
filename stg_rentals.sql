

CREATE or replace TABLE model_stg.stg  as

from(
SELECT 
    rideable_type, 
    DATEDIFF('SECOND', started_at ,ended_at) AS duration_seconds, 
    started_at as start_time, 
    ended_at as end_time, 
    start_station_name, 
    start_station_id, 
    start_lat as start_station_latitude, 
    start_lng as start_station_longitude, 
    end_station_name, 
    end_station_id, 
    end_lat as end_station_latitude, 
    end_lng as end_station_longitude, 
    member_casual as user_type 
FROM raw_rentals.v2

Union all

SELECT
    null as rideable_type, 
duration_sec  AS duration_seconds, 
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
user_type, 
FROM raw_rentals.v3


UNION ALL

SELECT 
    null as rideable_type, 
    duration_sec, 
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
    END as user_type
FROM raw_rentals.v1);
