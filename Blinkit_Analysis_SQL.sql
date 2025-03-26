


use Blinkit_DB


select *
from Grocery_data



 
select COUNT(*) as Total_Counts
from Grocery_data



-- Cleaning the Datasets

update Grocery_data
set Item_Fat_Content = 
case 
when Item_Fat_Content in ('LF','low fat') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
else Item_Fat_Content
END








select distinct(Item_Fat_Content) as unique_items
from Grocery_data




-- 1. Total Sales: The overall revenue generated from all items sold.

select cast(SUM(Total_Sales) / 1000000 as decimal(10,2))  as Total_Revenue_millions
from Grocery_data




select cast(SUM(Total_Sales) / 1000000 as decimal(10,2))  as Total_Revenue_millions
from Grocery_data
where Item_Fat_Content = 'Low Fat' and Outlet_Establishment_Year = 2022



select cast(SUM(Total_Sales) / 1000000 as decimal(10,2))  as Total_Revenue_millions
from Grocery_data
where Item_Fat_Content = 'Regular' and Outlet_Establishment_Year = 2022




-- 2. Average Sales: The average revenue per sale.

select round(avg(Total_Sales),2) as avg_Revenue
from Grocery_data





select cast(avg(Total_Sales) as decimal(10,2)) as avg_Revenue
from Grocery_data






-- 3. Number of Items: The total count of different items sold.


select COUNT(*) as No_of_Items
from Grocery_data






 -- 4. Average Rating: The average customer rating for items sold. 

 select cast(AVG(Rating) as decimal(10,2)) as Avg_Rating
 from Grocery_data







 -- Objectives

 -- 1. Total Sales by Fat Content:

              --   Objective: Analyze the impact of fat content on total sales.
	          --   Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.


select * 
from Grocery_data


-- Total Sales 

select Item_Fat_Content, CAST(sum(Total_Sales) / 1000000 as decimal(10,2)) as Total_Sales 
 from Grocery_data
 group by Item_Fat_Content



 -- Average Sales 

 select Item_Fat_Content, CAST(avg(Total_Sales) as decimal(10,2)) as avg_Sales 
 from Grocery_data
 group by Item_Fat_Content



  -- Number of Items

 select Item_Fat_Content, count(*) as No_of_Items
 from Grocery_data
 group by Item_Fat_Content






 -- Average Rating


 select Item_Fat_Content, cast(avg(Rating) as decimal(10,2)) as Avg_Rating
 from Grocery_data
 group by Item_Fat_Content






 -- 2. Total Sales by Item Type:

		   -- Objective: Identify the performance of different item types in terms of total sales.
		   -- Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.



-- Total Sales Per Item

select Item_Type, cast(SUM(Total_Sales) / 1000000 as decimal(10,2)) as Sales_millions_Per_Item
from Grocery_data
group by Item_Type
order by Sales_millions_Per_Item desc




-- Average Sales Per Item

select Item_Type, cast(avg(Total_Sales) as decimal(10,2)) as avg_sales_millions_Per_Item
from Grocery_data
group by Item_Type
order by avg_sales_millions_Per_Item desc




-- Number of Items

select Item_Type, COUNT(*) as Total_Counts_per_Item
from Grocery_data
group by Item_Type
order by Total_Counts_per_Item desc




-- Average Rating Per Item

select Item_Type, CAST(AVG(Rating) as decimal(10,2)) as Avg_Rating_Per_Item
from Grocery_data
group by Item_Type
order by Avg_Rating_Per_Item desc








-- 3. Fat Content by Outlet for Total Sales:


	        --  Objective: Compare total sales across different outlets segmented by fat content.
	        --  Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.


select * 
From Grocery_data





select Item_Fat_Content, SUM(Total_Sales) as Total_sales
from Grocery_data
group by Item_Fat_Content




select Outlet_Location_Type,
     ISNULL([Low Fat],0) as Low_Fat,
	 ISNULL([Regular],0) as Regular
from 
(    select Item_Fat_Content, Outlet_Location_Type, 
	cast(Sum(Total_Sales) / 1000000 as decimal(10,2)) as Total_Sales_Per_Outlate
	from Grocery_data
	group by Item_Fat_Content, Outlet_Location_Type

) as SourceTable
pivot
( 
   Sum(Total_Sales_Per_Outlate)
   for Item_Fat_Content in ([Low Fat],[Regular])
) as PivotTable
order by Outlet_Location_Type











-- 4. Total Sales by Outlet Establishment:

	--- Objective: Evaluate how the age or type of outlet establishment influences total sales.



select * from Grocery_data


select Outlet_Establishment_Year, CAST(Sum(Total_Sales) / 1000000 as decimal(10,2)) as Total_Sales_Per_Year,
CAST(AVG(Rating) as decimal(10,2)) as Avg_Rating_Per_Item,
COUNT(*) as Total_Counts_per_Item,
CAST(AVG(Rating) as decimal(10,2)) as Avg_Rating_Per_Item
from Grocery_data
group by Outlet_Establishment_Year
order by Outlet_Establishment_Year, Total_Sales_Per_Year desc









-- 5. Percentage of Sales by Outlet Size:

	-- Objective: Analyze the correlation between outlet size and total sales.




select Outlet_Size,
CAST(Sum(Total_Sales) / 1000000 as decimal(10,2)) as Total_Sales,
CAST((Sum(Total_Sales) * 100 / SUM(sum(Total_Sales)) over()) as decimal(10,2)) as Total_Sales_Percentage
from Grocery_data
group by Outlet_Size
order by Total_Sales desc






-- 6. Sales by Outlet Location:

	-- Objective: Assess the geographic distribution of sales across different locations.


select * From Grocery_data




select Outlet_Location_Type,
cast(SUM(Total_Sales) / 1000000 as decimal(10,2)) as Sales,
CAST((Sum(Total_Sales) * 100 / SUM(sum(Total_Sales)) over()) as decimal(10,2)) as Total_Sales_Percentage,
CAST(AVG(Rating) as decimal(10,2)) as Avg_Rating_Per_Item,
COUNT(*) as Total_Counts_per_Item,
CAST(AVG(Rating) as decimal(10,2)) as Avg_Rating_Per_Item
from Grocery_data
Group by Outlet_Location_Type
Order By Outlet_Location_Type, Sales Desc






-- 7. All Metrics by Outlet Type:

	-- Objective: Provide a comprehensive view of all key metrics (Total Sales, Average Sales, Number of Items, Average Rating) broken down by different outlet types.


select Outlet_Type,
cast(SUM(Total_Sales) / 1000000 as decimal(10,2)) as Sales,
CAST((Sum(Total_Sales) * 100 / SUM(sum(Total_Sales)) over()) as decimal(10,2)) as Total_Sales_Percentage,
CAST(AVG(Rating) as decimal(10,2)) as Avg_Rating_Per_Item,
COUNT(*) as Total_Counts_per_Item,
CAST(AVG(Rating) as decimal(10,2)) as Avg_Rating_Per_Item
from Grocery_data
Group by Outlet_Type
Order By Outlet_Type, Sales Desc



