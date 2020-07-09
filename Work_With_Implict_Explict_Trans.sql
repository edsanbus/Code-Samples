USE TSQL2012;
GO

--working with implicit transaction mode to insert data in a table--
SET IMPLICIT_TRANSACTIONS ON;
SELECT @@TRANCOUNT;
SET IDENTITY_INSERT Production.Products ON;
INSERT INTO Production.Products (productid, productname, supplierid, categoryid, unitprice, discontinued)
VALUES(101, N'Test2: New productid', 1, 1, 18.00, 0);
COMMIT TRAN;
SET IDENTITY_INSERT Production.Products OFF; 
GO

--working with explicit transaction mode to insert data into a table
BEGIN TRAN;
 SELECT @@TRANCOUNT;
	SET IDENTITY_INSERT Production.Products ON;
	INSERT INTO Production.Products (productid, productname, supplierid, categoryid, unitprice, discontinued)
VALUES(103, N'Test3: New productid', 1, 1, 19.00, 0);
COMMIT TRAN;
SELECT @@TRANCOUNT
SET IDENTITY_INSERT Production.Products OFF; 
GO

---working with nested transaction and the COMMIT TRANS while obeserving the value of the @@TRANCOUNT variable--
BEGIN TRAN;
	SELECT @@TRANCOUNT;
	SET IDENTITY_INSERT Production.Products ON;
	INSERT INTO Production.Products (productid, productname, supplierid, categoryid, unitprice, discontinued)
	VALUES(10111, N'Test2: New productid', 1, 1, 18.00, 0);
	BEGIN TRAN;
		SELECT @@TRANCOUNT;
		INSERT INTO Production.Products (productid, productname, supplierid, categoryid, unitprice, discontinued)
		VALUES(1111, N'Test2: New productid', 1, 1, 18.00, 0);
		SET IDENTITY_INSERT Production.Products OFF;
	COMMIT
	SELECT @@TRANCOUNT;
COMMIT TRAN;
SELECT @@TRANCOUNT;
GO
	 