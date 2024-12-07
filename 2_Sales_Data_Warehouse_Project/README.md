# This project is inspired by coursework from IBM Business Intelligence (BI) Analyst Professional Certificate
---

# **SQL Aggregation and Materialized View Lab 🚀**

This project demonstrates the use of advanced SQL aggregation techniques, such as **GROUPING SETS**, **ROLLUP**, and **CUBE**, to generate subtotals, grand totals, and multidimensional aggregates in a data warehouse environment. Additionally, it includes creating a **Materialized View** for optimized query performance.

---

## **📂 Contents**
- **Overview of Aggregation Techniques:**
  - GROUPING SETS
  - ROLLUP
  - CUBE
- **SQL Examples:**
  - Aggregating data using different operators.
  - Creating and querying materialized views.

---

## 🎯 **Purpose**
The goal of this lab is to explore and understand how **GROUPING SETS**, **ROLLUP**, and **CUBE** work in SQL to generate flexible aggregations. These operators allow for customized grouping and subtotaling of data in various ways, making them essential for advanced analytics. The lab also demonstrates the creation and use of **Materialized Views** to store precomputed query results, enabling faster and more efficient data retrieval.

---

## **💻 SQL Implementation**

### **1. Using GROUPING SETS**
GROUPING SETS allows grouping data in multiple ways within a single query.

```sql
SELECT year, category, SUM(billedamount) AS totalbilledamount
FROM "FactBilling"
LEFT JOIN "DimCustomer" ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth" ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY GROUPING SETS (year, category);
```

---

### **2. Using ROLLUP**
ROLLUP creates hierarchical subtotals and grand totals based on the provided columns.

```sql
SELECT year, category, SUM(billedamount) AS totalbilledamount
FROM "FactBilling"
LEFT JOIN "DimCustomer" ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth" ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY ROLLUP (year, category)
ORDER BY year, category;
```

---

### **3. Using CUBE**
CUBE produces subtotals and grand totals for all possible combinations of the specified columns.

```sql
SELECT year, category, SUM(billedamount) AS totalbilledamount
FROM "FactBilling"
LEFT JOIN "DimCustomer" ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth" ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY CUBE (year, category)
ORDER BY year, category;
```

---

### **4. Creating a Materialized View**
A materialized view stores the results of a query for efficient data retrieval.

```sql
CREATE MATERIALIZED VIEW countrystats (country, year, totalbilledamount) AS
SELECT country, year, SUM(billedamount)
FROM "FactBilling"
LEFT JOIN "DimCustomer" ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth" ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY country, year;
```

---

### **5. Grouping Sets for Quarter Analysis**
This query groups data by year and quarter name using GROUPING SETS.

```sql
SELECT year, quartername, SUM(billedamount) AS totalbilledamount
FROM "FactBilling"
LEFT JOIN "DimCustomer" ON "FactBilling".customerid = "DimCustomer".customerid
LEFT JOIN "DimMonth" ON "FactBilling".monthid = "DimMonth".monthid
GROUP BY GROUPING SETS (year, quartername);
```

---

## **✨ Highlights**
- **GROUPING SETS**: Custom grouping combinations.
- **ROLLUP**: Hierarchical totals.
- **CUBE**: Multidimensional aggregations.
- **Materialized View**: Stores precomputed results for optimized performance.

---

## **📊 Usage Scenarios**
- **GROUPING SETS**: Analyze yearly and category-wise sales data in one query.
- **ROLLUP**: Generate hierarchical reports with subtotals and grand totals.
- **CUBE**: Perform multidimensional analysis of sales data.
- **Materialized View**: Store aggregated data by country and year for fast reporting.

---
