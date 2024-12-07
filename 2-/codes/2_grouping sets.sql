--Creating a grouping sets query using the columns productid, producttype, total sales.
--Calculating TotalSales by multiplying the Price_PerUnit by QuantitySold for each sale.
--The ORDER BY clause ensures the results are ordered by productid and then by producttype.


SELECT
    p.Productid,
    p.Producttype,
    SUM(f.Price_PerUnit * f.QuantitySold) AS TotalSales
FROM
    FactSales f
INNER JOIN
    DimProduct p ON f.Productid = p.Productid
GROUP BY GROUPING SETS (
    (p.Productid, p.Producttype),
    p.Productid,
    p.Producttype,
    ()
)
ORDER BY
    p.Productid,
    p.Producttype;