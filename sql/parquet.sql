copy(select * from model_stg.processed_station_info )to "C:\Users\cleli\Desktop\bikeshare_projet\parquet\info.parquet";
copy(select * from model_stg.processed_station_status )to "C:\Users\cleli\Desktop\bikeshare_projet\parquet\status.parquet";
copy(select * from model_stg.stg )to "C:\Users\cleli\Desktop\bikeshare_projet\parquet\histo.parquet";


