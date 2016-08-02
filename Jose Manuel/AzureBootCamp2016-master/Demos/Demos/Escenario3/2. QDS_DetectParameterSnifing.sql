--Enable query store (SSMS GUI)

--Z
exec GetUsersByName @Name='Z'
waitfor delay '00:00:01'
go 70
exec GetUsersByName @Name='N'
go 5


--do the same with recompile and force the plan
--Z
exec GetUsersByName @Name='Z' with recompile
waitfor delay '00:00:01'
go 70
exec GetUsersByName @Name='N' with recompile
go 5


--QDS views
SELECT q.query_id, qt.query_text_id, qt.query_sql_text, SUM(rs.count_executions) AS total_execution_count
FROM
sys.query_store_query_text qt JOIN 
sys.query_store_query q ON qt.query_text_id = q.query_text_id JOIN
sys.query_store_plan p ON q.query_id = p.query_id JOIN
sys.query_store_runtime_stats rs ON p.plan_id = rs.plan_id
GROUP BY q.query_id, qt.query_text_id, qt.query_sql_text
ORDER BY total_execution_count DESC

