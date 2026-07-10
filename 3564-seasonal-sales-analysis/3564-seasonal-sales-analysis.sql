# Write your MySQL query statement below
WITH seasons AS(
    SELECT
        CASE WHEN MONTH(sale_date) IN (12,01,02) THEN 'Winter'
            WHEN MONTH(sale_date) IN (03,04,05) THEN 'Spring'
            WHEN MONTH(sale_date) IN (06,07,08) THEN 'Summer'
            WHEN MONTH(sale_date) IN (09,10,11) THEN 'Fall'
        END AS season,
        p.category,
        SUM(quantity) AS tot_quant,
        SUM(quantity * price) AS revenue
    FROM sales s
    JOIN products p
        ON s.product_id = p.product_id
    GROUP BY season, category
),
popular_cat AS(
    SELECT season, category, tot_quant, revenue,
    ROW_NUMBER() OVER(PARTITION BY season ORDER BY tot_quant DESC, revenue DESC, category) AS popular
    FROM seasons
    ORDER BY season
)
SELECT season, category, tot_quant AS total_quantity, revenue AS total_revenue
FROM popular_cat
WHERE popular = 1
ORDER BY season