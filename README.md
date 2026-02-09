# Retail Sales Data Analysis (MySQL)

##  Project Overview
This project focuses on analyzing retail sales data using **MySQL**.  
The goal is to clean the data, explore key metrics, and extract meaningful business insights using SQL queries.

---

## 🛠 Tools & Technologies
- MySQL 8+
- SQL (CTEs, Window Functions)
- MySQL Workbench

---

## 🗂 Database Structure

**Database Name:** `p1_retail_db`  
**Table Name:** `retail_dataset`

### Table Columns:
- transactions_id (Primary Key)
- sale_date
- sale_time
- customer_id
- gender
- age
- category
- quantiy
- price_per_unit
- cogs
- total_sale

---

##  Data Cleaning Steps
- Identified NULL values in critical columns
- Removed records containing NULLs
- Used safe update mode handling for secure deletion

---

## 📊 Analysis Performed
1. Total number of records
2. Unique customer count
3. Unique product categories
4. Date-based sales filtering
5. Category-wise sales analysis
6. Gender-wise transaction count
7. Best-selling month per year (using window functions)
8. Top 5 customers by total sales
9. Unique customers per category
10. Shift-wise order analysis (Morning / Afternoon / Evening)

---

## Key SQL Concepts Used
- GROUP BY & Aggregate Functions
- Window Functions (`RANK()`)
- Common Table Expressions (CTE)
- Date & Time Functions
- Data Cleaning Techniques

---

##  Files in Repository
- `retail_analysis.sql` → Complete SQL script
- `README.md` → Project documentation

---

##  Conclusion
This project demonstrates practical SQL skills required for a **Data Analyst** role, including data cleaning, aggregation, and advanced analytical queries.

---

⭐ Feel free to fork this repo and use it for learning or interviews!
