-- ===============================
-- DATABASE & TABLE SETUP
-- ===============================

CREATE DATABASE IF NOT EXISTS p1_retail_db;
USE p1_retail_db;

DROP TABLE IF EXISTS retail_dataset;

CREATE TABLE retail_dataset (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- ===============================
-- DATA EXPLORATION & CLEANING
-- ===============================

-- Total records
SELECT COUNT(*) AS total_records FROM retail_dataset;

-- Unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_dataset;

-- Unique categories
SELECT COUNT(DISTINCT category) AS total_categories FROM retail_dataset;

-- Find NULL values
SELECT *
FROM retail_dataset
WHERE sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Disable safe update
SET SQL_SAFE_UPDATES = 0;

-- Delete rows with NULLs
DELETE FROM retail_dataset
WHERE sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Enable safe update
SET SQL_SAFE_UPDATES = 1;

-- ===============================
-- DATA ANALYSIS
-- ===============================

-- 1. Sales on a specific date
SELECT *
FROM retail_dataset
WHERE sale_date = '2022-11-05';

-- 2. Clothing category with quantity >= 4 in Nov 2022
SELECT *
FROM retail_dataset
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01';

-- 3. Category-wise total sales
SELECT category, SUM(total_sale) AS net_sale
FROM retail_dataset
GROUP BY category;

-- 4. Average age for Beauty category
SELECT category, AVG(age) AS avg_age
FROM retail_dataset
WHERE category = 'Beauty'
GROUP BY category;

-- 5. Transactions with total_sale > 1000
SELECT *
FROM retail_dataset
WHERE total_sale > 1000;

-- 6. Transactions by gender & category
SELECT 
    category,
    gender,
    COUNT(transactions_id) AS total_transactions
FROM retail_dataset
GROUP BY category, gender;

-- 7. Best-selling month (avg sale) per year
SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM retail_dataset
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) t
WHERE rnk = 1;

-- 8. Top 5 customers by total sales
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_dataset
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- 9. Unique customers per category
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_dataset
GROUP BY category;

-- 10. Shift-wise order count
WITH hourly_sale AS (
    SELECT 
        *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_dataset
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
