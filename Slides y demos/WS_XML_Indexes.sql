
/* 
  XML --- ElasticPoolDb2 
 
  CREATE TABLE [dbo].[XML_Table](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Informacion] [xml] NULL,
 CONSTRAINT [PK_XML_Table] PRIMARY KEY CLUSTERED 
 (
	[Id] ASC
 )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
 ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

  DECLARE @xml AS XML 
  SET @xml = '<Clientes> <Cliente> <ClienteID>2042</ClienteID> <Nombre>Jose</Nombre> </Cliente> </Clientes>'
  declare @k as int
  set @k = 1
  while @k <= 500000
  begin 
    set @k = @k+1  
    SET @xml = '<Clientes> <Cliente> <ClienteID> ' + convert(varchar(200), @k ) + ' </ClienteID> <Nombre>Jose ' + convert(varchar(200),@k) + '</Nombre> </Cliente> </Clientes>'
    INSERT INTO Xml_table(Informacion) Values (@xml)
  end  
  
*/ 

/* 
  CREATE TABLE [dbo].[XML_Table_NOINDEX](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Informacion] [xml] NULL,
 CONSTRAINT [PK_XML_Table_NOINDEX] PRIMARY KEY CLUSTERED 
 (
	[Id] ASC
 )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
 ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

  DECLARE @xml AS XML 
  SET @xml = '<Clientes> <Cliente> <ClienteID>2042</ClienteID> <Nombre>Jose</Nombre> </Cliente> </Clientes>'
  declare @k as int
  set @k = 1
  while @k <= 500000
  begin 
    set @k = @k+1  
    SET @xml = '<Clientes> <Cliente> <ClienteID> ' + convert(varchar(200), @k ) + ' </ClienteID> <Nombre>Jose ' + convert(varchar(200),@k) + '</Nombre> </Cliente> </Clientes>'
    INSERT INTO Xml_table_NOINDEX(Informacion) Values (@xml)
  end  


*/
CREATE PRIMARY XML INDEX [PrimaryXmlIndex-20150614-160529] ON [dbo].[XML_Table]
(
	[Informacion]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE XML INDEX [SecondaryXmlIndex-20150614-160956_value] ON [dbo].[XML_Table]
(
	[Informacion]
)
USING XML INDEX [PrimaryXmlIndex-20150614-160529] FOR VALUE WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE XML INDEX [SecondaryXmlIndex-20150614-160834] ON [dbo].[XML_Table]
(
	[Informacion]
)
USING XML INDEX [PrimaryXmlIndex-20150614-160529] FOR PATH WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE XML INDEX [SecondaryXmlIndex-20150614-160911_property] ON [dbo].[XML_Table]
(
	[Informacion]
)
USING XML INDEX [PrimaryXmlIndex-20150614-160529] FOR PROPERTY WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
  
SELECT *  FROM XML_Table where informacion.exist('/Clientes/Cliente/ClienteID[text()=200]')=1
SELECT *  FROM XML_Table_noindex where informacion.exist('/Clientes/Cliente/ClienteID[text()=200]')=1

select DATABASEPROPERTYEX(db_name(), 'ServiceObjective')