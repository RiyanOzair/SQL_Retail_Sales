
USE Retail_data_Analysis;

--Import the flat file from Excel and Display the top 10 records in the table
SELECT 
	TOP 10 * 
FROM Retail_Sales;

-- Count the number of records and verify it with the Excel number of rows
SELECT  
	COUNT(*) AS number_of_records
FROM Retail_Sales;

-- Data Cleaning (Remove any null/empty value containing records)
SELECT *
FROM Retail_Sales
WHERE transactions_id is NULL
   OR sale_date is NULL
   OR sale_time is NULL
   OR gender is NULL
   OR age is NULL
   OR category is NULL
   OR quantity is NULL
   OR price_per_unit is NULL
   OR cogs is NULL
   OR total_sales is NULL;

DELETE FROM Retail_sales
WHERE transactions_id is NULL
   OR sale_date is NULL
   OR sale_time is NULL
   OR gender is NULL
   OR age is NULL
   OR category is NULL
   OR quantity is NULL
   OR price_per_unit is NULL
   OR cogs is NULL
   OR total_sales is NULL;

SELECT  
	COUNT(*) AS number_of_records
FROM Retail_Sales;

-- Data Exploration

	-- The Total Number Of Sales:
		SELECT  
			COUNT(*) AS 'Number of Sales'
		FROM Retail_Sales;

	-- The Total Number of Customers:
		SELECT  
			COUNT(DISTINCT customer_id) AS 'Number of Customers'
		FROM Retail_Sales;

	-- The Types of Categories:
		SELECT  
			DISTINCT category AS 'Types of Categories'
		FROM Retail_Sales;

-- Data Analysis - To find answers to key problems such as:

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
	
	SELECT *
	FROM Retail_Sales
	WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022
	
	SELECT *
	FROM Retail_sales
	WHERE category = 'Clothing' 
		AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
		AND quantity > 2


-- Q.3 Write a SQL query to calculate the total sales for each category.
	SELECT 
		category,
		COUNT(*) as Total_Orders,
		SUM(total_sales) as 'Total Sales'
	FROM Retail_sales
	GROUP BY category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
	SELECT 
		AVG(age) as Avg_Age_of_Customer_Purchasing_Beauty_Products
	FROM Retail_sales
	WHERE category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
	SELECT 
		* 
	FROM Retail_sales
	WHERE total_sales > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category.
	SELECT 
		category,
		gender,
		COUNT(transactions_id) as 'Total Transactions'
	FROM Retail_sales
	GROUP BY 
		category,
		gender;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT *FROM
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

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
	
	SELECT TOP 5 customer_id,
		SUM(total_sales) as Total_sales	
	FROM Retail_sales
	GROUP BY customer_id
	ORDER BY Total_sales DESC;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

	SELECT 
		category,
		COUNT(DISTINCT customer_id) as Customer_Id
	FROM Retail_sales
	GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

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

