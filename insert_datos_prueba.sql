DECLARE @cnt INT = 0;

WHILE @cnt < 50000
BEGIN
   insert into prueba(text) values('prueba' + convert(nvarchar(5),@cnt)) 
   SET @cnt = @cnt + 1;
END;


