--create schema donnees_brutes
CREATE TABLE donnees_brutes.rentals_SF (
    rideable_type VARCHAR(255),
    duration_seconds VARCHAR(255),  -- Change INT en VARCHAR
    start_time VARCHAR(255),  -- Change TIMESTAMP en VARCHAR
    end_time VARCHAR(255),    -- Change TIMESTAMP en VARCHAR
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_station_latitude VARCHAR(255),  -- Change DOUBLE en VARCHAR
    start_station_longitude VARCHAR(255), -- Change DOUBLE en VARCHAR
    end_station_latitude VARCHAR(255),    -- Change DOUBLE en VARCHAR
    end_station_longitude VARCHAR(255),   -- Change DOUBLE en VARCHAR
    user_type VARCHAR(50)
);

INSERT INTO donnees_brutes.rentals_SF  (
    rideable_type, 
    duration_seconds, 
    start_time, 
    end_time, 
    start_station_name, 
    start_station_id, 
    end_station_name, 
    end_station_id, 
    start_station_latitude, 
    start_station_longitude, 
    end_station_latitude, 
    end_station_longitude, 
    user_type
)
SELECT 
    rideable_type, 
    DATEDIFF('SECOND', started_at ,ended_at) AS duration_seconds, 
    started_at as start_time, 
    ended_at as end_time, 
    start_station_name, 
    start_station_id, 
    end_station_name, 
    end_station_id, 
    start_lat as start_station_latitude, 
    start_lng as start_station_longitude, 
    end_lat as end_station_latitude, 
    end_lng as end_station_longitude, 
    member_casual as user_type 
FROM test.raw_rentals.v1

UNION ALL

SELECT 
    null as rideable_type, 
    duration_sec, 
    start_time, 
    end_time, 
    start_station_id, 
    start_station_name, 
    start_station_latitude, 
    start_station_longitude, 
    end_station_id, 
    end_station_name, 
    end_station_latitude, 
    end_station_longitude, 
    CASE 
        WHEN user_type = 'Subscriber' THEN 'member' 
        ELSE 'casual' 
    END as user_type
FROM test.raw_rentals.v2;
