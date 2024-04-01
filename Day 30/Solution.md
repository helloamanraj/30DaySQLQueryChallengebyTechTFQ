Solution1:
```sql

WITH cte AS (
    SELECT student_id,
           'subject1' AS subject_name,
           subject1 AS mark
    FROM student_marks
    UNION ALL
    SELECT student_id,
           'subject2' AS subject_name,
           subject2 AS mark
    FROM student_marks
    UNION ALL
    SELECT student_id,
           'subject3' AS subject_name,
           subject3 AS mark
    FROM student_marks
    UNION ALL
    SELECT student_id,
           'subject4' AS subject_name,
           subject4 AS mark
    FROM student_marks
    UNION ALL
    SELECT student_id,
           'subject5' AS subject_name,
           subject5 AS mark
    FROM student_marks
    UNION ALL
    SELECT student_id,
           'subject6' AS subject_name,
           subject6 AS mark
    FROM student_marks
)
, percentage_mark_cte AS (
    SELECT cte.student_id,
           s.name,
           ROUND(AVG(mark * 1.0), 2) AS percentage_marks 
    FROM cte
    INNER JOIN students s ON cte.student_id = s.roll_no
    GROUP BY cte.student_id, s.name
),
failed_subject_cte AS (
    SELECT cte.student_id,
           GROUP_CONCAT(s.name,',') AS failed_subjects,
           COUNT(s.name) AS nro_failed_subjects 
    FROM cte
    INNER JOIN subjects s ON CONCAT(LEFT(cte.subject_name,1), RIGHT(cte.subject_name,1)) = LOWER(s.id)
    WHERE cte.mark < s.pass_marks
    GROUP BY cte.student_id
)
SELECT p.student_id,
       p.name,
       p.percentage_marks,
       COALESCE(f.failed_subjects, '-') AS failed_subjects,
       CASE 
           WHEN nro_failed_subjects > 0 THEN 'Fail'
           WHEN p.percentage_marks >= 70 THEN 'First Class'
           WHEN p.percentage_marks >= 50 THEN 'Second Class'
           ELSE 'Third Class'
       END AS result
FROM percentage_mark_cte p
LEFT JOIN failed_subject_cte f ON p.student_id = f.student_id;
```