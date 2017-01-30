--Deadlock Thread 2
BEGIN TRANSACTION
UPDATE [Person] SET [FirstName] = 'Chris' WHERE [BusinessEntityID] = 1
UPDATE [PersonPhone] SET PhoneNumber = '999-555-1212' WHERE [BusinessEntityID] = 1
WAITFOR DELAY '00:00:10'
ROLLBACK TRANSACTION