-- ======================================================
-- Creamos la master key para almacenar las credenciales.
-- ======================================================
CREATE MASTER KEY ENCRYPTION BY PASSWORD='Nuevos123!';

-- BASE DE DATOS DE REMOTO --- 
-- ======================================================================
-- Creamos la credencial de base de datos que nos permitrá conectarnos a la base de datos.
-- ======================================================================

CREATE DATABASE SCOPED CREDENTIAL AppCred WITH IDENTITY = 'PandaLogin',  SECRET = 'Nuevos123!';

-- ======================================================================
-- Configuramos el acceso
-- ======================================================================
CREATE EXTERNAL DATA SOURCE RemoteReferenceData
WITH
(
	TYPE=RDBMS,
	LOCATION='iyg43q8cjy.database.windows.net',
	DATABASE_NAME='Remoto',
	CREDENTIAL= AppCred
);

-- ===========================================================================
-- Creamos la tabla en base a mapeo
-- ==============================================================================
CREATE EXTERNAL TABLE Cambios
  (ID int,
   Nombre varchar(100)  NULL,
   Apellido varchar(100) NOT NULL,
   NrTlf varchar(12)  NULL,
   Email varchar(100)  NULL, 
   UserID int )
WITH
(
	DATA_SOURCE = RemoteReferenceData
);

-- ===========================================================================
-- Realizamos las pruebas
-- ==========================================================================
Select count(*) from Cambios 

-- ========================================================================
-- Si el login no está creado en master dará el error
-- ========================================================================
Msg 46824, Level 16, State 2, Line 43
Login failed on one or more shards.  Please verify that the shards are accessible and that the credential information affiliated with external data source RemoteReferenceData is correct.

Select count(*) from Cambios 

-- ========================================================================
-- Si el usuario no está asociado al usuario. 
-- ========================================================================
Msg 46823, Level 16, State 2, Line 43
Error retrieving data from one or more shards.  The underlying error message received was: 'The server principal "PandaLogin" is not able to access the database "REMOTO" under the current security context.
Database 'Remoto' on server 'a45b2ff80a47.tr17.northeurope1-a.worker.database.windows.net,11175' is not currently available.  Please retry the connection later.  If the problem persists, contact customer support, and provide them the session tracing ID of '39404F37-F6EB-4B4C-A66A-B2B7075279A4'.
Login failed for user 'PandaLogin'.'.

Select count(*) from Cambios 

-- ==========================================================================
-- Si no tiene permisos.
--==========================================================================
Msg 46823, Level 16, State 2, Line 61
Error retrieving data from one or more shards.  The underlying error message received was: 'The SELECT permission was denied on the object 'Cambios', database 'REMOTO', schema 'dbo'.'.

Select count(*) from Cambios 


----> In case of problems--->

DROP EXTERNAL TABLE [dbo].[Table_1]
DROP EXTERNAL DATA SOURCE RemoteReferenceData
DROP DATABASE SCOPED CREDENTIAL AppCred

---->Msg 46519, Level 16, State 16, Line 80 DML Operations are not supported with external tables.

INSERT Cambios (Nombre, Apellido, NrTlf, Email, UserId) VALUES 
('Roberto', 'Torres', '91551234567', 'RTorres@contoso.com', 5),
('Juan', 'Galvin', '95551234568', 'JGalvin@contoso.com', 5),
('José', 'Garcia', '95551234569', 'Jgarcia@contoso.net',1);


Msg 46519, Level 16, State 16, Line 32
DML Operations are not supported with external tables.

--- =====================================
-- Creamos una tabla local ( mira el plan de ejecución ) y la unimos para departamentos por el user Id.
-- =====================================================
CREATE TABLE UserId
  (ID int IDENTITY PRIMARY KEY,
   Nombre varchar(100)  NULL  );

iNSERT UserId (Nombre) VALUES 
('Departamento 1'),
('Departamento 2'),
('Departamento 3'),
('Departamento 4'),
('Departamento 5'),
('Departamento 6');

   select * from Cambios 
   inner join UserId on UserId.Id = Cambios.UserId


   ----========================================
   -- Modo sharding
   -- ===========================================

   drop external data source EjemploSharding
   drop external table [Customers]
   CREATE DATABASE SCOPED CREDENTIAL AppTotal WITH IDENTITY = 'jmjurado',  SECRET = 'Nuevos123!';
   CREATE EXTERNAL DATA SOURCE EjemploSharding
    WITH ( 
        TYPE = SHARD_MAP_MANAGER,
        LOCATION = 'iyg43q8cjy.database.windows.net',
        DATABASE_NAME = 'ElasticScaleStarterKit_ShardMapManagerDb',
        CREDENTIAL = AppTotal,
        SHARD_MAP_NAME = 'CustomerIDShardMap'
    )

CREATE EXTERNAL TABLE [dbo].[Customers]
( [CustomerId] [int] NOT NULL,
  [Name] [nvarchar](256) NOT NULL,
  [RegionId] [int] NOT NULL)
WITH
( DATA_SOURCE = EjemploSharding,
  DISTRIBUTION = SHARDED([CustomerId])
)

  insert into [Customers] ([CustomerId], [Name], [RegionId]) values(1,'Shard 0', 1)
    insert into [Customers] ([CustomerId], [Name], [RegionId]) values(1,'Shard 1', 1)

select * from customers
select count(CustomerId) from [dbo].[Customers]