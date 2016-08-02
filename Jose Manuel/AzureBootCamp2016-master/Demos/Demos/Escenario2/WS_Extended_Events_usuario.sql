
-- ===================================================================
-- Vamos a crear un procedimiento almacenado para provocar un timeout. 
-- ===================================================================
create PROC usp_Timeout
as
select 1
waitfor delay '00:00:10'

-- ====================================================================
-- Creamos el master key y habilitamos la seguridad existente para el acceso a blo.
-- ====================================================================
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Nuevos123!'; 
CREATE DATABASE SCOPED CREDENTIAL [https://dsdazurejmjurado.blob.core.windows.net/xe-container] 
WITH IDENTITY='SHARED ACCESS SIGNATURE', 
SECRET = 'sv=2014-02-14&sr=c&sig=xiH3tDCEaoaTWmYCnOtnRqz5W0cPG3i66aeKUPoP4p8%3D&st=2016-04-15T22%3A00%3A00Z&se=2016-04-23T22%3A00%3A00Z&sp=rw' 

-- ====================================================================
-- Creamos la session de extended events
-- ====================================================================
CREATE EVENT SESSION ssEventoEnFichero
ON DATABASE
ADD EVENT sqlserver.error_reported(
ACTION(sqlserver.client_app_name,sqlserver.client_connection_id,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.session_id,sqlserver.sql_text,sqlserver.username))
  ADD TARGET package0.asynchronous_file_target(
     SET filename='https://dsdazurejmjurado.blob.core.windows.net/xe-container/DemoPersistedError.xel')

-- =====================================================================
-- Lanzamos el START del evento
-- =====================================================================
     ALTER EVENT SESSION [ssEventoEnFichero] ON DATABASE STATE = START;

	 SELECT *,names FROM sys.object

-- =====================================================================
-- Lanzamos el STOP del evento
--- ====================================================================

     ALTER EVENT SESSION [ssEventoEnFichero] ON DATABASE STATE = STOP;

         DROP EVENT SESSION ssEventoEnFichero ON DATABASE

-- =====================================================================
-- Vemos el timeout del evento.
-- =====================================================================
CREATE EVENT SESSION ssEventoTimeout
ON DATABASE
ADD EVENT sqlserver.sql_batch_completed (
    ACTION(sqlserver.client_app_name,sqlserver.client_connection_id,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.session_id,sqlserver.sql_text,sqlserver.username)
WHERE ([result] <> (0)))
  ADD TARGET package0.asynchronous_file_target(
     SET filename='https://dsdazurejmjurado.blob.core.windows.net/xe-container/DemoPersistedTimeout.xel')

-- ===========
-- Habilitamos 
-- =====================================================================
       ALTER EVENT SESSION [ssEventoTimeout] ON DATABASE STATE = START;

-- =====================================================================
-- Deshabilitamos
-- =====================================================================
       ALTER EVENT SESSION [ssEventoTimeout] ON DATABASE STATE = STop;
	   DROP EVENT SESSION ssEventoTimeout ON DATABASE
