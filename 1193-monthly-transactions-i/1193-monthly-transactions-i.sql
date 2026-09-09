# Write your MySQL query statement below
SELECT SUBSTRING(trans_date, 1, 7) AS month,
       country,
       COUNT(*) AS trans_count,
       SUM(CASE WHEN state = "approved" THEN 1 ELSE 0 END) AS approved_count,
       SUM(amount) AS trans_total_amount,
       IFNULL(SUM(CASE WHEN state = "approved" THEN amount END), 0) AS approved_total_amount
FROM Transactions
GROUP BY country, month;