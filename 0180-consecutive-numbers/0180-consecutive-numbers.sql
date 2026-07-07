# Write your MySQL query statement below
WITH consecutive AS
(
    SELECT LAG(num, 0) OVER(ORDER BY id) AS num_1,
           LAG(num, 1) OVER(ORDER BY id) AS num_2,
           LAG(num, 2) OVER(ORDER BY id) AS num_3
    FROM Logs
)
SELECT DISTINCT num_1 AS ConsecutiveNums
FROM consecutive
WHERE num_1 = num_2 AND num_2 = num_3;