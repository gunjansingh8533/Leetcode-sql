# Write your MySQL query statement below
WITH red_sales  AS(
    SELECT o.sales_id
    FROM Orders o
    JOIN Company c ON
    c.com_id = o.com_id
    WHERE c.name = "RED"
)
SELECT name
FROM SalesPerson 
WHERE sales_id NOT IN 
(SELECT sales_id FROM red_sales)