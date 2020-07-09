
--This code returns products with minimum unit price per 
--category from the products table in the production schema of the TSQL2012 database
WITH CatMin AS
(
SELECT categoryid, MIN(unitprice) AS mn
FROM Production.Products
GROUP BY categoryid
)
SELECT P.categoryid, P.productid, P.productname, p.unitprice
FROM Production.Products AS P
INNER JOIN CatMin AS M
ON P.categoryid = M.categoryid
AND P.unitprice = M.mn

