--Create an Materialized views named average_billamount with columns year, quarter, category, country, average_bill_amount.

CREATE MATERIALIZED VIEW average_billamount (year, quarter, category, country, average_bill_amount)
AS
(SELECT 
	year, 
	quarter, 
	category, 
	country, 
	AVG(billedamount) 
FROM "FactBilling"
LEFT JOIN "DimCustomer" 
ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth" 
ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY year, quarter, category, country);