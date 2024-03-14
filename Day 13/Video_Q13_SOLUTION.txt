
select mng.name as manager, count(emp.name) as employee
from employee_managers emp
join employee_managers mng on emp.manager = mng.id
group by mng.name
order by employee desc;
