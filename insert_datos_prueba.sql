DECLARE @cnt INT = 0;

WHILE @cnt < 50000
BEGIN
   insert into prueba(text) values('prueba' + convert(nvarchar(5),@cnt)) 
   SET @cnt = @cnt + 1;
END;

/****** Object:  Table [dbo].[prueba]    Script Date: 22/02/2018 13:30:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[prueba](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[text] [nvarchar](50) NULL,
 CONSTRAINT [PK_prueba] PRIMARY KEY CLUSTERED 
(
	[id] ASC
))

GO

