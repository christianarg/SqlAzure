select rs.*,rs.max_session_percent * 300 as active_sessions from sys.dm_db_resource_stats rs
order by end_time desc