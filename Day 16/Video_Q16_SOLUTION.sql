
with cte as 
		(select extract(month from dates) as month
		, sum(cases_reported) as monthly_cases
		from covid_cases
		group by extract(month from dates)),
	cte_final as
		(select *
		, sum(monthly_cases) over(order by month) as total_cases
		from cte)
select month
, case when month > 1 
			then cast(round((monthly_cases/lag(total_cases) over(order by month))*100,1) as varchar)
	   else '-' end as percentage_increase
from cte_final;
