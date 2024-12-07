CREATE MATERIALIZED VIEW avg_customer_bill (customerid, averagebillamount)
AS
(SELECT 
	customerid,
	avg(billedamount)
FROM
	public."FactBilling"
GROUP BY customerid);
