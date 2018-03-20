select * from sys.dm_os_schedulers

select count(*) cpu_count from 
(
	select distinct cpu_id from sys.dm_os_schedulers
) cpus

