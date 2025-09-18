-- Retail_Sales_Analysis
select * from retail_sale

--Create Table
Create Table retail_sale
(
    transactions_id int primary key,
	sale_date	date
	sale_time	time
	customer_id	int 
	gender	varchar(15)
	age	int
	category	varchar(30)
	quantity	int
	price_per_unit	float
	cogs	float
	total_sale float
)

Select * from retail_sale
--Data cleaning
Select 
 count(*)
from retail_sale

Select transactions_id 
from retail_sale
where transactions_id is null

Select * from retail_sale
where transactions_id is null
or 
sale_date is null
or 
sale_time is null
or 
customer_id is null
or 
category is null
or 
total_sale is null

Delete from retail_sale
where transactions_id is null
or 
sale_date is null
or 
sale_time is null
or 
customer_id is null 
or 
category is null
or 
total_sale is null

--Exploration of data
-- How many sales do we have ?
Select 
 count(total_sale)
from retail_sale

--How many unique customers do we have?
Select 
 count(Distinct customer_id) AS Num_of_Customers
from retail_sale

--How many unique Categories do we have?
Select 
 Distinct category
from retail_sale

--Buisness key Problems & Answers 

--Q.1Write a SQL query to retrieve all columns for sales made on '2022-11-05':
Select * from retail_sale
where sale_date = '2022-11-05'



-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
Select 
*
from retail_sale

where
  category= 'Clothing'
 and -
   TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'

 and 
  quantity >=4

10 in the month of Nov-2022



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
 Select 
  category,
  sum(total_sale) as net_sales,
  count(*) as total_sales
 From retail_sale
  Group by category;



-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
Select 
 round(avg(age), 2)
From 
 retail_sale
Where 
 category= 'Beauty'



-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
 Select 
  *
 From 
  retail_sale
 Where 
  total_sale > 1000



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
Select
  category,
 gender,
  count(*) as total_trans
From retail_sale
 group by gender, category
 order by 1



-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select
 year,
 month,
 avg_sales
from(
select 
 extract(YEAR from sale_date) as year,
 extract(MONTH from sale_date) as month,
 avg(total_sale) as avg_sales,
 rank() over(partition by extract(YEAR from sale_date) order by avg(total_sale) desc) as rank
 from retail_sale
group by 1,2
) as t1
where rank = 1 


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select 
 customer_id as customers,
 sum(total_sale) as total_sale
from retail_sale
 group by 1
 order by 2 desc
 limit 5



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select
 category,
 count(distinct customer_id)
from retail_sale
 group by 1


 -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17). Find out which shift has the most orders.
With hourly_sale
as
(
 select *,
  case 
   when extract(HOUR From sale_time) < 12 then 'Morning'
   when extract(HOUR FROM sale_time) BETWEEN 12 AND 17 then 'Afternoon'
   else 'Evening'
  END as Shift
 from retail_sale
 ) 
Select
  shift,
  count(*) as total_orders
From hourly_sale
 Group by 1
 Order by 2 Desc

--End of Project



 