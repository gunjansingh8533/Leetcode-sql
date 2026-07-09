# Write your MySQL query statement below
WITH pairs AS(
    SELECT p1.product_id AS product1_id, p2.product_id AS product2_id, COUNT(*) AS customer_count
    FROM ProductPurchases p1
    JOIN productPurchases p2
        ON p1.product_id < p2.product_id
        AND p1.user_id = p2.user_id
    GROUP BY p1.product_id, p2.product_id
    HAVING COUNT(*) >= 3
),
pr1_category AS(
    SELECT product1_id, pr.category 
    FROM pairs p
    JOIN ProductInfo pr
        ON p.product1_id = pr.product_id
),
pr2_category AS(
    SELECT product2_id, pr.category
    FROM pairs p
    JOIN ProductInfo pr
        ON p.product2_id = pr.product_id
)
SELECT 
    DISTINCT p.product1_id, 
             p.product2_id, 
             pr1.category AS product1_category, 
             pr2.category AS product2_category , 
             p.customer_count
FROM pairs p
JOIN pr1_category pr1
    ON p.product1_id = pr1.product1_id
JOIN pr2_category pr2
    ON p.product2_id = pr2.product2_id
ORDER BY customer_count DESC, product1_id, product2_id