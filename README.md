# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `Retail_Data_Analysis`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Import a Flat file containing 'retail sales database' with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Retail_Data_Analysis`.
- **Import Database**: By Right Clicking the Newly created Database and going to task and importing the downloaded Database file, We are able to get hold of all                          the data required for the project.


### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022**:
```sql

	SELECT *
	FROM Retail_sales
	WHERE category = 'Clothing' 
		AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
		AND quantity > 2

```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
	category,
	COUNT(*) as Total_Orders,
	SUM(total_sales) as 'Total Sales'
FROM Retail_sales
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
	AVG(age) as Avg_Age_of_Customer_Purchasing_Beauty_Products
FROM Retail_sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
	category,
	gender,
	COUNT(transactions_id) as 'Total Transactions'
FROM Retail_sales
GROUP BY 
	category,
	gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
	[Year],
    [Month],
    Avg_Sales
FROM
(
	SELECT
		YEAR(sale_date) as [Year],
		MONTH(sale_date) as [Month],
		AVG(total_sales) as Avg_Sales,
		RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sales) DESC) AS rank
	FROM Retail_sales
	GROUP BY YEAR(sale_date), MONTH(sale_date)
) as t1
WHERE rank = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT TOP 5 customer_id,
	SUM(total_sales) as Total_sales	
FROM Retail_sales
GROUP BY customer_id
ORDER BY Total_sales DESC;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
	category,
	COUNT(DISTINCT customer_id) as Customer_Id
FROM Retail_sales
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH cte as
	(SELECT *,
		CASE
			WHEN DATEPART(HOUR, sale_time) <= 12 THEN 'Morning' 
			WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END as [Shifts]
	FROM Retail_sales)
SELECT 
	Shifts,
	COUNT(*) as 'Number of Orders'
FROM cte
GROUP BY Shifts;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.




