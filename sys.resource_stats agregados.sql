select 
avg(avg_cpu_percent) avg_cpu_percent,
max(avg_cpu_percent) max_cpu_percent, 

avg(avg_data_io_percent) avg_data_io_percent,
max(avg_data_io_percent) max_data_io_percent,

avg(avg_log_write_percent) avg_log_write_percent,
max(avg_log_write_percent) max_log_write_percent,

avg(max_worker_percent) avg_worker_percent,
max(max_worker_percent) max_worker_percent

from sys.resource_stats

sp_help 'sys.resource_stats'