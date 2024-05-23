Solution1:
```sql

With cte as (
select student_id, subject1 as Marks , 'S1' from student_marks
union 
select student_id, subject2  as Marks, 'S2'  from student_marks
union 
select student_id, subject3 as Marks, 'S3'  from student_marks
union 
select student_id, subject4 as Marks, 'S4' from student_marks
union 
select student_id, subject5 as Marks, 'S5' from student_marks
union 
select student_id, subject6 as Marks, 'S6' from student_marks
)
, cte2 as( 
select student_id, sd.name as student_name , round(avg(marks) over (partition by student_id),1) as percentage_marks, marks, s.name as subject ,pass_marks,
case when marks < pass_marks then 1 else 0 end as flag
from cte 
inner join subjects as s on cte.s1 = s.id
inner join students as sd on cte.student_id = sd.roll_no
order by student_id
)

,cte3 as (select  student_id,
           GROUP_CONCAT(subject) AS failed_subjects
           from cte2
where flag = 1           
group by student_id
)
select distinct(cte2.student_id), student_name , percentage_marks, 
coalesce(failed_subjects,'-') as failed_subjects, 
CASE 
           WHEN coalesce(failed_subjects,'-') != '-' THEN 'Fail'
           WHEN percentage_marks >= 70 THEN 'First Class'
           WHEN percentage_marks >= 50 THEN 'Second Class'
           ELSE 'Third Class'
       END AS result
from cte2 
left join cte3 on cte2.student_id = cte3.student_id 
```

























Solution2:
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