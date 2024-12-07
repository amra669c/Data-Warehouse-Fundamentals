--Create a grouping set for the columns year, quartername, sum(billedamount)
SELECT 
	year,
	quartername,
	SUM(billedamount) AS totalbilledamount
FROM
	public."FactBilling"
LEFT JOIN public."DimCustomer"
	on public."FactBilling".customerid =public."DimCustomer".customerid
LEFT JOIN public."DimMonth" 
ON public."FactBilling".monthid=public."DimMonth".monthid
GROUP BY GROUPING SETS(year, quartername)