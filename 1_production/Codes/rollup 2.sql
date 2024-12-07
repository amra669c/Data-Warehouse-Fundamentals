-- Create a rollup for the columns country, category, sum(billedamount)

SELECT
	country,
	category,
	SUM(billedamount) AS totalbilledamount
FROM
	public."DimCustomer"
LEFT JOIN public."FactBilling"
ON public."DimCustomer".customerid = public."FactBilling".customerid
GROUP BY rollup (country, category)
ORDER BY country, category;