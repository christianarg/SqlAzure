SELECT *,
   CAST(event_data as XML).value('(/event/@timestamp)[1]', 'datetime2') AS timestamp
,CAST(event_data as XML).value('(/event/data[@name="error"]/value)[1]', 'INT') AS error
,CAST(event_data as XML).value('(/event/data[@name="state"]/value)[1]', 'INT') AS state
  ,CAST(event_data as XML).value('(/event/data[@name="is_success"]/value)[1]', 'bit') AS is_success
,CAST(event_data as XML).value('(/event/data[@name="database_name"]/value)[1]', 'sysname') AS database_name
FROM sys.fn_xe_telemetry_blob_target_read_file('el', null, null, null)
     where object_name = 'database_xml_deadlock_report' 
