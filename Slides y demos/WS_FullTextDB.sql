-- =====================================================
-- Creamos la base de datos >S3
-- =====================================================
CREATE DATABASE FullTextDB (EDITION = 'standard', SERVICE_OBJECTIVE ='S3' )

-- =====================================================
-- Creamos la tabla de FullText -- Cambiamos la base de datos a FullTextDB
-- =====================================================
CREATE TABLE [dbo].[FullTextTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TextData] [varchar](max) NOT NULL,
 CONSTRAINT [PK_FullTextTable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

-- ======================================================
-- Creamos el fulltext
-- =======================================================
 CREATE FULLTEXT CATALOG [FullTextCatalog]WITH ACCENT_SENSITIVITY = ON
 CREATE FULLTEXT INDEX ON [dbo].[FullTextTable] KEY INDEX [PK_FullTextTable] ON ([FullTextCatalog]) WITH (CHANGE_TRACKING AUTO)
 ALTER FULLTEXT INDEX ON [dbo].[FullTextTable] ADD ([TextData])
 ALTER FULLTEXT INDEX ON [dbo].[FullTextTable] ENABLE

-- ======================================================
-- Añadimos los registros 
-- ======================================================
insert into [dbo].[FullTextTable] values('Madrid')
insert into [dbo].[FullTextTable] values('Barcelona')
insert into [dbo].[FullTextTable] values('Alava')
insert into [dbo].[FullTextTable] values('Madrid')
insert into [dbo].[FullTextTable] values('Barcelona')
insert into [dbo].[FullTextTable] values('Alava')
insert into [dbo].[FullTextTable] values('Madrid')
insert into [dbo].[FullTextTable] values('Barcelona')
insert into [dbo].[FullTextTable] values('Alava')
insert into [dbo].[FullTextTable] values('Madrid')
insert into [dbo].[FullTextTable] values('Barcelona')
insert into [dbo].[FullTextTable] values('Alava')
insert into [dbo].[FullTextTable] values('Madrid')
insert into [dbo].[FullTextTable] values('Barcelona')
insert into [dbo].[FullTextTable] values('Alava')
insert into [dbo].[FullTextTable] values('Madrid')
insert into [dbo].[FullTextTable] values('Barcelona')
insert into [dbo].[FullTextTable] values('Alava')
insert into [dbo].[FullTextTable] values('Bilbao')


select * from [FullTextTable] where CONTAINS(TextData, 'Madrid');

DROP DATABASE FullTextDB