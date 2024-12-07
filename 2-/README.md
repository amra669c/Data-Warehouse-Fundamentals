

# **📊 Sales Data Warehouse Project**

## **Overview**
This project demonstrates the implementation of a **Data Warehouse** to analyze and report sales performance for a consumer electronics retail company. The goal is to build a structured data model using dimension and fact tables, implement advanced SQL commands for aggregations and rollups, and utilize materialized views for optimizing query performance. 🛠️

---

## **✨ Project Features**
1. **📂 Table Creation**:
   - Schema includes fact and dimension tables.
   - Structured relationships enable efficient querying and analysis.
2. **🔍 Advanced SQL Commands**:
   - Use of **GROUPING SETS**, **ROLLUP**, and **CUBE** for flexible aggregations.
3. **🚀 Materialized Views**:
   - Precomputing and storing complex query results to optimize analytics.

---

## **🗂️ Database Schema**

### **Tables**
1. **FactSales**: Stores transactional sales data.
2. **MyDimCustomer**: Contains customer information.
3. **MyDimProduct**: Contains product information.
4. **MyDimDate**: Stores date details for time-based analysis.

---

## **💻 SQL Implementation**

### **1. Creating Tables**
The following tables are created to support sales data analysis:

#### **FactSales Table**
```sql
CREATE TABLE FactSales (
    sales_id INT PRIMARY KEY,
    quantity_sold INT,
    price_per_unit DECIMAL(10, 2),
    customer_id INT,
    date_id INT
);
```

#### **MyDimCustomer Table**
```sql
CREATE TABLE MyDimCustomer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255)
);
```

#### **MyDimProduct Table**
```sql
CREATE TABLE MyDimProduct (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255)
);
```

#### **MyDimDate Table**
```sql
CREATE TABLE MyDimDate (
    date_id INT PRIMARY KEY,
    year INT,
    month INT,
    month_name VARCHAR(20),
    day INT,
    week_day INT,
    week_day_name VARCHAR(20)
);
```

---

### **2. Advanced Aggregations**

#### **Using GROUPING SETS** 🔄
Generates custom combinations of aggregated results:
```sql
SELECT year, month, product_id, SUM(quantity_sold) AS total_quantity
FROM FactSales
GROUP BY GROUPING SETS ((year, month, product_id), (year, month), (year), ());
```
- Provides totals at multiple levels (e.g., year + month, year only, or grand total).

#### **Using ROLLUP** 📊
Generates hierarchical aggregations:
```sql
SELECT year, month, SUM(quantity_sold) AS total_quantity
FROM FactSales
GROUP BY ROLLUP (year, month);
```
- Produces subtotals for each year and a grand total.

#### **Using CUBE** 📈
Generates all possible combinations of grouping:
```sql
SELECT year, month, product_id, SUM(quantity_sold) AS total_quantity
FROM FactSales
GROUP BY CUBE (year, month, product_id);
```
- Useful for generating multidimensional reports.

---

### **3. Materialized View** 💾

#### **Creating a Materialized View**
Precomputes and stores the maximum sales for each product in each city:
```sql
CREATE MATERIALIZED VIEW max_sales AS
SELECT
    cs.city,
    p.product_id,
    p.product_name,
    MAX(f.price_per_unit * f.quantity_sold) AS max_sales
FROM
    FactSales f
JOIN
    MyDimProduct p ON f.product_id = p.product_id
JOIN
    MyDimCustomer cs ON f.customer_id = cs.customer_id
GROUP BY
    cs.city,
    p.product_id,
    p.product_name
WITH DATA;
```

#### **Refreshing the Materialized View** 🔄
If the source tables are updated, refresh the view to maintain accuracy:
```sql
REFRESH MATERIALIZED VIEW max_sales;
```

---

## **📊 Example Reports**

### **1. Total Sales Revenue Per Year Per City**
```sql
SELECT year, city, SUM(price_per_unit * quantity_sold) AS total_revenue
FROM FactSales
JOIN MyDimCustomer ON FactSales.customer_id = MyDimCustomer.customer_id
JOIN MyDimDate ON FactSales.date_id = MyDimDate.date_id
GROUP BY year, city;
```

### **2. Product Sales Insights**
```sql
SELECT product_name, SUM(quantity_sold) AS total_quantity
FROM FactSales
JOIN MyDimProduct ON FactSales.product_id = MyDimProduct.product_id
GROUP BY product_name;
```

---

## **🚀 Future Enhancements**
- Add more dimensions (e.g., regions, stores) for deeper analysis.
- Implement more materialized views for precomputed insights.
- Optimize performance with indexing and partitioning.

---

## **📜 License**
This project is licensed under the MIT License.

