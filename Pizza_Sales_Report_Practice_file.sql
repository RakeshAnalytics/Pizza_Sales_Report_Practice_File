CREATE DATABASE Pizza_sales_Project;

USE Pizza_sales_Project

SELECT  * FROM orders
SELECT * FROM pizza_types
SELECT * FROM pizzas
SELECT * FROM order_details;

-1.-- Retrieve the total number of orders placed.

SELECT COUNT(order_id) AS Total_Orders_Placed 
FROM orders;

-2.-- Calculate the total revenue generated from pizza sales. 

SELECT ROUND(SUM(P.price*OD.quantity),0) AS Total_Revenue
FROM order_details OD
JOIN
pizzas p
ON P.pizza_id= OD.pizza_id;

-3.--- Identify the highest-priced pizza. 

SELECT MAX(price) AS Higest_Price_Pizza
FROM pizzas;


-4.--- Identify the most common pizza size ordered. 
SELECT size, count(size) AS Most_common_Pizza 
FROM pizzas
GROUP BY size
ORDER BY Most_common_Pizza DESC
LIMIT 1


--5.-- List the top 5 most ordered pizza types along with their quantities. 
SELECT P.pizza_type_id, SUM(OD.quantity) AS total_Quantity
FROM order_details OD
JOIN
pizzas P
ON P.pizza_id = OD.pizza_id
GROUP BY P.pizza_type_id
ORDER BY Total_Quantity DESC
LIMIT 5;

-6.-- Join the necessary tables to find the total quantity of each pizza category ordered. 
SELECT PT.category, SUM(OD.quantity)AS Total_Quantity
FROM order_details OD
JOIN pizzas P
ON P.pizza_id = OD.pizza_id
JOIN pizza_types PT
ON P.pizza_type_id = PT.pizza_type_id
GROUP BY PT.category

-7.-- Determine the distribution of orders by hour of the day. 
SELECT HOUR(time) AS Order_hour,
COUNT(*) Total_orders
FROM orders
GROUP BY Order_hour
ORDER BY Total_orders DESC;

-8.-- Join relevant tables to find the category-wise distribution of pizzas. 
SELECT PT.category, COUNT(P.pizza_id) AS count_of_Pizzas
FROM pizza_types PT
JOIN
pizzas P
ON PT.pizza_type_id = P.pizza_type_id
GROUP BY PT.category
ORDER BY count_of_Pizzas DESC;

-9.--- Group the orders by date and calculate the average number of pizzas ordered per day. 
SELECT date, SUM(OD.quantity) AS Total_Pizzas_Ordered,
AVG(SUM(OD.quantity)) OVER () AS Avg_Pizzas_Order_Per_day
FROM orders o
JOIN order_details OD
ON O.order_id = OD.order_id
GROUP BY date
ORDER BY date;


-10.-- Determine the top 3 most ordered pizza types based on revenue. 
SELECT PT.name, SUM(OD.quantity * P.price) AS Total_Revenue
FROM 
pizza_types PT 
JOIN pizzas P
ON PT.pizza_type_id = P.pizza_type_id
JOIN 
order_details OD
ON OD.pizza_id = P.pizza_id
GROUP BY PT.name
ORDER BY Total_Revenue DESC
LIMIT 3;






