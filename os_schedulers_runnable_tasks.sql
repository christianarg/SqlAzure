SELECT scheduler_id, current_tasks_count, runnable_tasks_count, work_queue_count, pending_disk_io_count
FROM sys.dm_os_schedulers
WHERE scheduler_id < 255