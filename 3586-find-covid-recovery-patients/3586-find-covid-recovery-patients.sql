# Write your MySQL query statement below
WITH first_positive AS (
    SELECT patient_id, MIN(test_date) AS positive_date
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
),
first_negative_after AS (
    SELECT ct.patient_id, MIN(ct.test_date) AS negative_date
    FROM covid_tests ct
    JOIN first_positive fp
        ON ct.patient_id = fp.patient_id
    WHERE ct.result = 'Negative'
      AND ct.test_date > fp.positive_date
    GROUP BY ct.patient_id
)
SELECT 
    fp.patient_id,
    p.patient_name,
    p.age,
    DATEDIFF(fn.negative_date, fp.positive_date) AS recovery_time
FROM first_positive fp
JOIN first_negative_after fn
    ON fp.patient_id = fn.patient_id
JOIN patients p 
    ON p.patient_id = fn.patient_id
ORDER BY recovery_time, patient_name
