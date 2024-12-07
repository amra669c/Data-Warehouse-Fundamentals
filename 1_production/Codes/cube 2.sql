--Create a cube for the columns year,country, category, sum(billedamount).

SELECT 
	year,
	country, 
	category, 
	SUM(billedamount) AS totalbilledamount
FROM "FactBilling"
LEFT JOIN "DimCustomer"
	ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth"
	ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY CUBE(year,country, category)
