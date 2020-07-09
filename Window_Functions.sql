-- this query returns the moving average value of a customers's last three orders--
SELECT custid, orderid, orderdate, val,
AVG(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid
				ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS movingavg
FROM Sales.OrderValues;
GO

--this query returns the three orders with the highest freight amount per shipper--
with result AS(
SELECT shipperid, orderid, freight, 
ROW_NUMBER() OVER(PARTITION BY shipperid ORDER BY freight DESC, orderid) AS rownum
FROM Sales.Orders)
SELECT shipperid, orderid, freight, rownum
FROM result
WHERE  rownum <= 3;
GO

/*this query returns the difference between a customer previous order value
and his current order and the difference between th customer next order value and the current order*/
SELECT custid, orderid, orderdate, val, 
val - LAG(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS diffprev,
val - LEAD(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS diffnext
FROM Sales.OrderValues;
GO