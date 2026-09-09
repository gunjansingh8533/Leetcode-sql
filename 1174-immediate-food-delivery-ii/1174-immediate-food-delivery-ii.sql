# Write your MySQL query statement below
WITH first_order AS(
    SELECT customer_id, MIN(order_date) AS first_order, MIN(customer_pref_delivery_date) AS pref_date
    FROM Delivery
    GROUP BY customer_id
)
SELECT ROUND(
            (COUNT(
                CASE WHEN first_order = pref_date THEN 1 END)
                /COUNT(*)
            )*100
       , 2) AS immediate_percentage
FROM first_order;

