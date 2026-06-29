# Write your MySQL query statement below
WITH order_2019 AS(
    SELECT buyer_id, COUNT(*) AS cnt
    FROM Orders
    WHERE YEAR(order_date) = 2019
    GROUP BY buyer_id
)
SELECT u.user_id AS buyer_id, u.join_date, IFNULL(cnt, 0) AS orders_in_2019
FROM Users u
LEFT JOIN order_2019 o
    ON u.user_id = o.buyer_id;


