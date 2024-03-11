Solution1:
```sql


select s.emp_id, s.emp_name, x.trns_type
, case when x.trns_type = 'Basic' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Allowance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Others' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Insurance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Health' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'House' then round(base_salary * (cast(x.percentage as decimal)/100),2) end as amount	   
from salary s
cross join (select income as trns_type, percentage from income
			union
			select deduction as trns_type, percentage from deduction) x;
```

Solution2:

```sql


with cte as(
select emp_name as employee,
max(case when trns_type= 'Basic' then amount end) as Basic,
max(case when trns_type= 'Allowance' then amount end) as Allowance,
max(case when trns_type= 'Others' then amount end) as Others,
max(case when trns_type= 'Insurance' then amount end) as Insurance,
max(case when trns_type= 'Health' then amount end) as Health,
max(case when trns_type= 'House' then amount end) as House
from emp_transaction
group by emp_name 
)

select employee, basic, allowance, Others 
, (basic+ allowance + Others) as Gross,
Insurance, Health, House, 
(Insurance + Health + House) as Total_Deductions 
from cte

```