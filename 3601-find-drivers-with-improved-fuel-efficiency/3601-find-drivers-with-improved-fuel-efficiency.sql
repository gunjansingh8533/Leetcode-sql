# Write your MySQL query statement below
WITH first_half AS(
    SELECT driver_id, AVG(distance_km/fuel_consumed) AS first_half_avg
    FROM trips
    WHERE MONTH(trip_date) BETWEEN 1 AND 6
    GROUP BY driver_id
),
second_half AS(
    SELECT driver_id, AVG(distance_km/fuel_consumed) AS second_half_avg
    FROM trips
    WHERE MONTH(trip_date) BETWEEN 7 AND 12
    GROUP BY driver_id
)
SELECT f.driver_id, 
       d.driver_name,
       ROUND(f.first_half_avg, 2) AS first_half_avg, 
       ROUND(s.second_half_avg, 2) AS second_half_avg,
       ROUND(s.second_half_avg - f.first_half_avg, 2) AS efficiency_improvement
FROM first_half f
JOIN second_half s
    ON f.driver_id = s.driver_id
    AND s.second_half_avg > f.first_half_avg
JOIN drivers d
    ON f.driver_id = d.driver_id
ORDER BY efficiency_improvement DESC, driver_name;