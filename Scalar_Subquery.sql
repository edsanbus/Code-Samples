USE TSQL2012
GO

SELECT productid, productname, unitprice
FROM Production.products
WHERE unitprice = (SELECT min(unitprice) FROM Production.products);
GO
