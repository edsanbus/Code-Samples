-- using APPLY operator to join a table and an inline table function to get the N Products with the lowers unit price per supplier

IF OBJECT_ID('Production.GetProducts','IF') IS NOT NULL
DROP FUNCTION Production.GetProducts;
GO

CREATE FUNCTION Production.GetProducts(@supplierid AS INT, @n AS BIGINT)
RETURNS TABLE
AS 
RETURN
	SELECT supplierid, productid, productname, unitprice
	FROM Production.Products
	WHERE supplierid = @supplierid 
	ORDER BY unitprice, productid
	OFFSET 0 ROWS FETCH FIRST @n ROWS ONLY;
GO

SELECT * FROM Production.GetProducts(1,2) AS P;
GO

--CROSS APPLY returns all values from the left table and only matching rows from the right
SELECT S.supplierid, S.companyname AS supplier, A.* 
FROM Production.Suppliers AS S
	CROSS APPLY Production.GetProducts(S.supplierid,2) AS A
WHERE S.country = N'Japan';
GO

-- OUTER APPLY returns all values from both the left and right tables replacing blank rows with NULL
SELECT S.supplierid, S.companyname AS supplier, A.* 
FROM Production.Suppliers AS S
	OUTER APPLY Production.GetProducts(S.supplierid,2) AS A
WHERE S.country = N'Japan';
GO