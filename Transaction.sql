USE TSQL2012;
BEGIN TRAN;
	SELECT @@TRANCOUNT AS TRANSACTIONCOUNT1;
		BEGIN TRAN;
			SELECT @@TRANCOUNT AS TRANSACTIONCOUNT2;
			SET IDENTITY_INSERT Production.Products ON;
				INSERT INTO Production.Products (productid, productname, supplierid, categoryid, unitprice, discontinued)
				VALUES (101, N'Test2: New Producid', 1, 1, 18.00,0);
			SELECT @@TRANCOUNT AS TRANSACTIONCOUNT3;
			ROLLBACK TRAN;
			COMMIT TRAN;
			SET IDENTITY_INSERT Production.Products OFF;

DELETE FROM Production.Products 
WHERE productid = 101;

SELECT * FROM Production.Products
WHERE productid = 101;

