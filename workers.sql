-- https://blogs.msdn.microsoft.com/sql_pfe_blog/2013/07/01/are-my-actual-worker-threads-exceeding-the-sp_configure-max-worker-threads-value/
select is_preemptive,state,last_wait_type,count(*) as NumWorkers 
from sys.dm_os_workers    
group by state,last_wait_type,is_preemptive    
order by count(*) desc