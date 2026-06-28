# Write your MySQL query statement below
WITH most_friends AS(
    SELECT requester_id AS id, COUNT(*) AS cnt
    FROM RequestAccepted
    GROUP BY requester_id
    UNION ALL
    SELECT accepter_id AS id, COUNT(*) AS cnt
    FROM RequestAccepted
    GROUP BY accepter_id
),
total_friends AS (
    SELECT id, SUM(cnt) as num
    FROM most_friends
    GROUP BY id
)
SELECT id, num 
FROM total_friends
WHERE num = (SELECT MAX(num) FROM total_friends);