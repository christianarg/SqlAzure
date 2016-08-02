SELECT c.*
FROM sys.database_connection_stats AS c
WHERE c.database_name = 'urano_2016R1Final'
--AND end_time > getdate()-15
and 
(
total_failure_count > 0
)
ORDER BY c.end_time;