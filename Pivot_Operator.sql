
WITH PivotData AS 
(SELECT YEAR(orderdate) AS Order_Year, shipperid, shippeddate
  FROM Sales.Orders)
  SELECT Order_Year, [1], [2], [3] FROM PivotData
  PIVOT(MAX(shippeddate) FOR shipperid IN ([1], [2], [3])) AS P;
GO

WITH PivotData AS
 (SELECT custid, shipperid FROM Sales.Orders)
 SELECT custid, [1], [2], [3] FROM PivotData
 PIVOT(Count(shipperid) FOR shipperid IN ([1], [2], [3])) AS P;
 GO