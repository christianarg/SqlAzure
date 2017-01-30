-- ==================================================
-- Creamos el SalesMaxRefTemp
-- ==================================================
drop procedure ObtenMax
drop table [SalesMaxRefTemp]

      CREATE TABLE [SalesMaxRefTemp] ( 
       [Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF_SalesMaxRef_Id]  DEFAULT (newid()) PRIMARY KEY NONCLUSTERED,
       [Account_id] [int] NOT NULL,
       [Store_id] [int] NOT NULL,
       [DeviceNumber] [int] NOT NULL,
       [MaxReference] [int] NOT NULL,
       INDEX IDX HASH ([Account_id],[Store_id],[DeviceNumber]) WITH (BUCKET_COUNT=100000) 
    ) WITH (MEMORY_OPTIMIZED=ON,DURABILITY = SCHEMA_AND_DATA) 

-- =====================================================
-- Creamos el procedimiento de actualización
-- =====================================================
create PROCEDURE ObtenMax
@Account_Id INT, @Store_Id INT, @DeviceNumber INT, @MaxReference INT OUTPUT
WITH EXECUTE AS OWNER, SCHEMABINDING, NATIVE_COMPILATION
AS
BEGIN ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT,LANGUAGE = N'us_english')

       SELECT @MaxReference = MaxReference +1 FROM dbo.[SalesMaxRefTemp]   WHERE Store_Id = @Store_Id AND Account_ID = @Account_Id AND DeviceNumber = @DeviceNumber;
       UPDATE dbo.[SalesMaxRefTemp]  SET MaxReference = @MaxReference WHERE Store_Id = @Store_Id AND Account_ID = @Account_Id AND DeviceNumber = @DeviceNumber

end 

-- =====================================================
-- Añadimos 10.000 registros - CLTR-T
-- =====================================================
DECLARE @Times as int = 0
while @times <=10000
begin
  set @times=@times+1
  insert into [SalesMaxRefTemp] (Store_Id,Account_ID, DeviceNumber,Maxreference) values(@times,1,1,1)
end

-- =====================================================
-- Actualizamos los 10.000 registros con un valor máximo al igual que podemos hacer con una secuencial
-- =====================================================

DECLARE @Times as int = 0
declare @Max as int = 0
while @times <=10000
begin
  set @times=@times+1
  exec ObtenMax @times,1,1, @Max OUT
  print @Max
end

-- =====================================================
-- Vemos temas de rendimiento y consumo. 
-- =====================================================

SELECT object_name(object_id) AS Name
     , *
   FROM sys.dm_db_xtp_table_memory_stats

   SELECT memory_consumer_desc
     , allocated_bytes/1024 AS allocated_bytes_kb
     , used_bytes/1024 AS used_bytes_kb
     , allocation_count
   FROM sys.dm_xtp_system_memory_consumers


   SELECT memory_object_address
     , pages_in_bytes
     , bytes_used
     , type
   FROM sys.dm_os_memory_objects WHERE type LIKE '%xtp%'
      
SELECT type
     , name
     , memory_node_id
     , pages_kb/1024 AS pages_MB 
   FROM sys.dm_os_memory_clerks WHERE type LIKE '%xtp%'


ALTER DATABASE iNmEMORY SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = ON