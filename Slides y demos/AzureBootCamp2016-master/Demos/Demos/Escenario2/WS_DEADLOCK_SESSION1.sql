
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
    

 

