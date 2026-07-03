# Write your MySQL query statement below
WITH score_rank AS(
    SELECT student_id, subject, score,
    ROW_NUMBER() OVER(PARTITION BY student_id, subject ORDER BY exam_date ASC) AS first_scr,
    ROW_NUMBER() OVER(PARTITION BY student_id, subject ORDER BY exam_date DESC) AS ltst_scr
    FROM Scores
),
First_score AS(
    SELECT student_id, subject, score
    FROM score_rank
    WHERE first_scr = 1
),
Latest_score AS(
    SELECT student_id, subject, score
    FROM score_rank
    WHERE ltst_scr = 1
)
SELECT f.student_id, f.subject, f.score AS first_score, l.score AS latest_score
FROM First_score f
JOIN Latest_score l
    ON f.student_id = l.student_id 
    AND f.subject = l.subject
WHERE l.score > f.score

