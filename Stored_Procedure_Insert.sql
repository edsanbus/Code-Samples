--Version 2 with error handling
USE TSQL2012;
GO

IF OBJECT_ID(N'Production.InsertProducts', N'P') IS NOT NULL DROP PROCEDURE Production.InsertProducts
GO

CREATE PROCEDURE Production.InsertProducts
  @productname AS NVARCHAR(40)
 ,@supplierid AS INT
 ,@categoryid AS INT
 ,@unitprice AS MONEY = 0
 ,@discontinued AS BIT = 0
AS 
BEGIN
	DECLARE @ClientMessage NVARCHAR(100);
	BEGIN TRY
		--Test parameters
		IF NOT EXISTS(SELECT 1 FROM Production.Suppliers WHERE supplierid = @supplierid)
			BEGIN
				SET @ClientMessage = 'Supplier id '+ CAST(@supplierid AS VARCHAR) + ' is invalid';
				THROW 50000, @ClientMessage, 0;
			END;
		IF NOT EXISTS(SELECT 1 FROM Production.Categories WHERE categoryid = @categoryid)
			BEGIN
				SET @ClientMessage = 'Category id ' + CAST(@categoryid AS VARCHAR) + 'is invalid';
				THROW 50000, @ClientMessage, 0;
			END;
		IF NOT (@unitprice >= 0)
			BEGIN
				SET @ClientMessage = 'Unitprice ' + CAST (@unitprice AS VARCHAR) + ' is invalid. Must be >= 0';
				THROW 50000, @ClientMessage, 0;
			END;
		--perform the insert
		INSERT Production.Products (productname, supplierid, categoryid, unitprice, discontinued)
		VALUES(@productname,@supplierid, @categoryid, @unitprice, @discontinued);
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH;
END;
GO

EXEC Production.InsertProducts
  @productname = 'Test Product'
 ,@supplierid = 100
 ,@categoryid = 1
 ,@unitprice = 100
 ,@discontinued = 0
GO