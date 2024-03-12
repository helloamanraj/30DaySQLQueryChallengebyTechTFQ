Solution1:

```sql
with cte as (
select *, lag(marks,1,0) over (order by test_id) as prev_marks,
lead(marks) over (order by test_id) as next_marks
from student_tests
)

select * from (select test_id, case when marks > prev_marks then marks end as marks from cte) as x
where marks is not null
```

Solution2: 

```sql

with cte as (
select *, lag(marks,1,marks) over (order by test_id) as prev_marks
from student_tests
)

select * from ( 
select test_id, case when marks > prev_marks then marks end as marks from cte
) as x
where marks is not null
```
