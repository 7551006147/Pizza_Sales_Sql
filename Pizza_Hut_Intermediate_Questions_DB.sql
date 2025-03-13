-- 1. Join the necessary tables to find the total quantity of each pizza category ordered.


SELECT 
    category, SUM(Quantity) AS Total_quantity
FROM
    Pizzas
        JOIN
    pizza_types ON Pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    orders_details ON Pizzas.pizza_id = orders_details.pizza_id
GROUP BY category; 



-- 2. Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(Order_Time), COUNT(Order_id) AS orders_count
FROM
    orders
GROUP BY HOUR(Order_Time)
ORDER BY orders_count DESC;




-- 3. Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name)
FROM
    Pizzas
        JOIN
    Pizza_types ON Pizzas.pizza_type_id = Pizza_types.pizza_type_id
GROUP BY category;



-- 4. Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
        Order_Date, SUM(Quantity) AS quantity
    FROM
        orders
    JOIN Orders_Details ON orders.Order_id = Orders_Details.Order_id
    GROUP BY Order_Date;



SELECT 
    AVG(quantity)
FROM
    (SELECT 
        Order_Date, SUM(Quantity) AS quantity
    FROM
        orders
    JOIN Orders_Details ON orders.Order_id = Orders_Details.Order_id
    GROUP BY Order_Date) AS Quantity;




SELECT 
    AVG(quantity)
FROM
    (SELECT 
        Order_Date, SUM(Quantity) AS quantity
    FROM
        orders
    JOIN Orders_Details ON orders.Order_id = Orders_Details.Order_id
    GROUP BY Order_Date) AS Order_Quantity;




-- 5. Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    name, category, SUM(price * Quantity) AS Revenue
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    Orders_Details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY name , category
ORDER BY Revenue DESC
LIMIT 3;