use Pizza_Hut;


-- 1. Calculate the percentage contribution of each pizza type to total revenue.



SELECT 
    category,
    ROUND((SUM(price * Quantity) / (SELECT 
                    ROUND(SUM(price * Quantity), 2) AS Total_Sales
                FROM
                    Pizzas
                        JOIN
                    Orders_Details ON Pizzas.Pizza_id = Orders_Details.Pizza_id) * 100),
            2) AS Revenue
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    Orders_Details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY category
;





-- 2. Analyze the cumulative revenue generated over time.
SELECT Order_Date, SUM(Revenue) OVER( ORDER BY Order_Date) as Cum_Revenue
FROM
(SELECT Order_Date,SUM(price * Quantity) as Revenue
FROM orders_Details JOIN Pizzas
on orders_Details.Pizza_id = Pizzas.Pizza_id JOIN Orders
ON orders_Details.Order_id  = Orders.Order_id
GROUP BY Order_Date
ORDER BY Order_Date) as revenue
;




-- 3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT name, revenue, Rank_Revenue
FROM 
(SELECT category, name, revenue,
RANK() OVER(PARTITION BY category ORDER BY revenue DESC) as Rank_Revenue
FROM 
(SELECT category, name, SUM(price * Quantity)  as revenue
FROM Pizzas JOIN Orders_Details
ON  Pizzas.Pizza_id = Orders_Details.Pizza_id  JOIN Pizza_types
ON Pizzas.pizza_type_id = Pizza_types.pizza_type_id
GROUP BY category, name) as R) AS S
WHERE Rank_Revenue <= 3;

