
-- Load data to emp_transaction table
insert into emp_transaction
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



-- SOLUTION PostgreSQL
select employee
, basic, allowance, others
, (basic + allowance + others) as gross
, insurance, health, house 
, (insurance + health + house) as total_deductions
, (basic + allowance + others) - (insurance + health + house) as net_pay
from crosstab('select emp_name, trns_type, sum(amount) as amount
			   from emp_transaction
			   group by emp_name, trns_type
			   order by emp_name, trns_type'
			  ,'select distinct trns_type from emp_transaction order by trns_type')
	as result(employee varchar, Allowance numeric, basic numeric, health numeric
			 , house numeric, insurance numeric, others numeric)




-- SOLUTION Microsoft SQL Server (Similar works for Oracle too, just replace [] with "")
select Employee
, Basic, Allowance, Others
, (Basic + Allowance + Others) as Gross
, Insurance, Health, House
, (Insurance + Health + House) as Total_Deductions
, ((Basic + Allowance + Others) - (Insurance + Health + House)) as Net_Pay
from 
    (
        select t.emp_name as Employee, t.trns_type, t.amount
        from emp_transaction t
        
    ) b
pivot 
    (
        sum(amount)
        for trns_type in ([Allowance],[Basic],[Health],[House],[Insurance],[Others])
    ) p;
