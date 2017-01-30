/* Create the database and table */

CREATE DATABASE ColumnStoreDB (SERVICE_OBJECTIVE ='S3')
 
  CREATE TABLE ExampleSales
   (ProductKey [int] NOT NULL, 
    Name varchar(200) NOT NULL, 
    Value decimal(9,2) NOT NULL DEFAULT 0,
    ShipDateKey [DATETIME] NOT NULL);
GO

/* Insert the 500000 rows */
  declare @k as int
  set @k = 1
  while @k <= 500000
  begin 
    set @k = @k+1  
    INSERT INTO ExampleSales(productKey,Name,Value,ShipDateKey) Values (@k, 'Example ' + convert(varchar(20),@k), case @k % 2 WHEN 0 THEN @K*0.02 ELSE @K*0.03 END, getdate() )
  end  

/* Create the clustered index and columnstore index */

  CREATE CLUSTERED INDEX cl_simple ON ExampleSales (ProductKey);
  GO
  CREATE NONCLUSTERED COLUMNSTORE INDEX ExampleSales_simple ON ExampleSales (Name, Value, ShipDateKey);
  GO

/* Obtain the report and verify the total row*/
  SELECT avg(value), SUM(Value), datepart(minute,ShipDateKey) FROM ExampleSales group by datepart(minute,ShipDateKey) order by 2
  select count(*) from ExampleSales

 /* it was needed to scale to P1 to use columnstore 
  alter database ColumnStoreDB modify ( service_objective='P1')
  
 /* timme to time I use these command to verify the slo of the database */
  select DATABASEPROPERTYEX(db_name(), 'ServiceObjective')
  SELECT  * FROM sys.dm_operation_status WHERE major_resource_id = ‘dbname’ AND operation = 'CREATE DATABASE COPY' AND state = 2 
  SELECT  * FROM sys.dm_operation_status WHERE major_resource_id = 'dbname’ AND operation = 'ALTER DATABASE' AND state = 2 

