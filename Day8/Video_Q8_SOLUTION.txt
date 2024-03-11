-- Solution 1 - Using Window function
with cte as 
	(select *
	, sum(case when job_role is null then 0 else 1 end) over(order by row_id) as segment
	from job_skills)
select row_id
, first_value(job_role) over(partition by segment order by row_id) as job_role
, skills
from cte;



-- Solution 2 - WITHOUT Using Window function
with recursive cte as
	(select row_id, job_role, skills 
	 from job_skills where row_id=1
	 union all
	 select e.row_id, case when e.job_role is null then cte.job_role else e.job_role end as job_role
	 , e.skills
	 from job_skills e
	 join cte on e.row_id = cte.row_id + 1
	)
select * from cte;
