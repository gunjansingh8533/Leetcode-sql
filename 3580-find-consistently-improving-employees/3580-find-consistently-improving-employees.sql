# Write your MySQL query statement below
WITH latest3 AS(
    SELECT employee_id, review_date, rating, 
    ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS recent_rat
    FROM performance_reviews
),
ratings AS(
    SELECT employee_id,
    lead(rating, 0, 0) OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rating1,
    lead(rating, 1, 0) OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rating2,
    lead(rating, 2, 0) OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rating3
    FROM latest3
    WHERE recent_rat <= 3
)
SELECT r.employee_id, e.name, rating1 - rating3 AS improvement_score
FROM ratings r
JOIN employees e
    ON r.employee_id = e.employee_id
WHERE rating1 > rating2 AND rating2 > rating3
AND rating3 != 0
ORDER BY improvement_score DESC, e.name;

