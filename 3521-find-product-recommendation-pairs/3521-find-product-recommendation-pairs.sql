# Write your MySQL query statement below
SELECT 
        p1.product_id AS product1_id, 
        p2.product_id AS product2_id, 
        pr1.category AS product1_category,
        pr2.category AS product2_category,
        COUNT(*) AS customer_count
FROM ProductPurchases p1
JOIN productPurchases p2
    ON p1.product_id < p2.product_id
    AND p1.user_id = p2.user_id
LEFT JOIN ProductInfo pr1
    ON p1.product_id = pr1.product_id
LEFT JOIN ProductInfo pr2
    ON p2.product_id = pr2.product_id
GROUP BY p1.product_id, p2.product_id
HAVING COUNT(*) >= 3
ORDER BY customer_count DESC,product1_id,product2_id   