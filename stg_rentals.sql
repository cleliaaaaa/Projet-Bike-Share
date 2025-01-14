SELECT 
rideable_type, 
null as duration_sec,
started_at as start_time,
ended_at as end_time ,
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
	user_type,
FROM test.raw_rentals.v2;