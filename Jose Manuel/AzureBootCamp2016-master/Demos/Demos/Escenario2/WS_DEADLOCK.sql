-- ==================================
-- Creamos la base de datos 
-- ================================== 
CREATE DATABASE DeadlockDB (SERVICE_OBJECTIVE ='S3')

-- ==================================
-- Creamos las tablas.
-- ================================== 

CREATE TABLE [dbo].[Person](
[Id] [int] IDENTITY(1,1) NOT NULL,
[FirstName] [varchar](20) NOT NULL,
[BusinessEntityID] [int] NOT NULL,
CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
[Id] ASC
))

CREATE TABLE [dbo].[PersonPhone](
[PhoneNumber] [varchar](50) NOT NULL,
[BusinessEntityID] [int] NOT NULL,
CONSTRAINT [PK_PersonPhone] PRIMARY KEY CLUSTERED 
(
[PhoneNumber] ASC
))

-- ==================================
-- Añadimos los registros. 
-- ================================== 
insert into [PersonPhone] values ( '999-555-1212',1) 
insert into [Person] values( 'Chris',1)

-- ==================================
-- Abro una sesión de SQL SERVER Management Studio y ejecuto esta query.
-- ================================== 

--Deadlock Thread 1
BEGIN TRANSACTION
UPDATE [PersonPhone] SET PhoneNumber = '999-555-1212' WHERE [BusinessEntityID] = 1
WAITFOR DELAY '00:00:50'
UPDATE [Person] SET [FirstName] = 'Chris' WHERE [BusinessEntityID] = 1
ROLLBACK TRANSACTION

-- ==================================
-- Rápidamente antes de que la sesión una termine abro otra de SQL SERVER Management Studio y ejecuto esta query.
-- ================================== 
    

--Deadlock Thread 2
BEGIN TRANSACTION
UPDATE [Person] SET [FirstName] = 'Chris' WHERE [BusinessEntityID] = 1
UPDATE [PersonPhone] SET PhoneNumber = '999-555-1212' WHERE [BusinessEntityID] = 1
WAITFOR DELAY '00:00:10'
ROLLBACK TRANSACTION
 
-- ==================================
-- Obtenemos el deadlock, puede que tarde unos 5 a 10 minutos en devolver los datos.
-- ================================== 
sp_helptext 'sys.event_log' 
 
SELECT *,CAST(event_data as XML).value('(/event/@timestamp)[1]', 'datetime2') AS timestamp
,CAST(event_data as XML).value('(/event/data[@name="error"]/value)[1]', 'INT') AS error
,CAST(event_data as XML).value('(/event/data[@name="state"]/value)[1]', 'INT') AS state
,CAST(event_data as XML).value('(/event/data[@name="is_success"]/value)[1]', 'bit') AS is_success
,CAST(event_data as XML).value('(/event/data[@name="database_name"]/value)[1]', 'sysname') AS database_name
FROM sys.fn_xe_telemetry_blob_target_read_file('el', null, null, null)
where object_name = 'database_xml_deadlock_report'
