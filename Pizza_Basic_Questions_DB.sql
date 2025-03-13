-- 1. Retrieve the total number of orders placed. 

USE Pizza_Hut;

SELECT COUNT(Order_id) 
FROM Orders;



USE Pizza_Hut;

SELECT COUNT(*) AS Total_orders
 FROM Orders;



-- 2. Calculate the total revenue generated from pizza sales.

-- Revenue = Price * Quantity

SELECT 
    ROUND(SUM(price * Quantity), 2) AS Total_Sales
FROM
    Pizzas
        JOIN
    Orders_Details ON Pizzas.Pizza_id = Orders_Details.Pizza_id;







SELECT 
    ROUND(SUM(Orders_Details.Quantity * Pizzas.price),
            2) AS Total_Revenue
FROM
    Orders_Details
        LEFT JOIN
    Pizzas ON Pizzas.Pizza_id = Orders_Details.Pizza_id;



-- 3. Ideify the highest-priced pizza.


SELECT 
    name, MAX(price) AS Highest_Price
FROM
    Pizza_types
        JOIN
    Pizzas ON Pizza_types.pizza_type_id = Pizzas.pizza_type_id
GROUP BY name
ORDER BY Highest_Price DESC
LIMIT 1;




SELECT 
    MAX(price) AS Highest_Price
FROM
    Pizzas;





-- Alternative with JOIN

SELECT 
    Pizza_types.name, Pizzas.price
FROM
    Pizza_types
        JOIN
    Pizzas ON Pizza_types.pizza_type_id = Pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1;






-- 4. Identify the most common pizza size ordered.


SELECT 
    size, COUNT(Order_Details_id) AS total_orders
FROM
    Pizzas
        JOIN
    Orders_Details ON Pizzas.pizza_id = Orders_Details.pizza_id
GROUP BY size
ORDER BY total_orders DESC;






SELECT 
    size, COUNT(Order_id) AS Total_Orders
FROM
    Pizzas
        JOIN
    Orders_Details ON Pizzas.pizza_id = Orders_Details.pizza_id
GROUP BY size;









SELECT * FROM Pizzas;


SELECT 
    size, COUNT(Order_Details_id) AS Total_Size_Ordered
FROM
    Pizzas
        JOIN
    Orders_Details ON Pizzas.pizza_id = Orders_Details.pizza_id
GROUP BY size
ORDER BY Total_Size_Ordered DESC;



-- 5. List the top 5 most ordered pizza types along with their quantities.

SELECT 
    name, SUM(Quantity) AS Total_quantity
FROM
    Pizzas
        JOIN
    Pizza_types ON Pizzas.pizza_type_id = Pizza_types.pizza_type_id
        JOIN
    Orders_Details ON Pizzas.pizza_id = Orders_Details.pizza_id
GROUP BY name
ORDER BY Total_quantity DESC
LIMIT 5;












SELECT 
    name, SUM(Quantity) AS Total_Quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    Orders_Details ON Orders_Details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY Total_Quantity DESC
LIMIT 5;

