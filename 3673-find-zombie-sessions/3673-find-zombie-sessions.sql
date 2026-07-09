# Write your MySQL query statement below
WITH zombies AS(
    SELECT 
        session_id,
        user_id,
        SUM(CASE WHEN event_type = 'scroll' THEN 1 ELSE 0 END) AS scroll_count,
        SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchase_count,
        SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) AS click_count,
        TIMESTAMPDIFF(MINUTE, MIN(event_timestamp), MAX(event_timestamp)) AS session_duration_minutes
     FROM app_events
     GROUP BY user_id   
)
SELECT session_id, user_id, session_duration_minutes, scroll_count
FROM zombies
WHERE session_duration_minutes > 30 
      AND scroll_count >= 5
      AND click_count/scroll_count < 0.20
      AND purchase_count = 0
ORDER BY scroll_count DESC, session_id;
