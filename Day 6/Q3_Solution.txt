-- Solution INCLUDING the first test marks
select *
from (select *, lag(marks,1,0) over(order by test_id) as prev_test_mark
	from student_tests) x
where x.marks > prev_test_mark;



-- Solution EXCLUDING the first test marks
select *
from (select *, lag(marks,1,marks) over(order by test_id) as prev_test_mark
	from student_tests) x
where x.marks > prev_test_mark;