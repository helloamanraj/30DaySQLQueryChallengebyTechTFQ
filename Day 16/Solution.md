Solution1:
```sql

with cte as (
select month(dates) Month, sum(cases_reported) as total_case, sum(sum(cases_reported)) over (order by month(dates) rows between unbounded preceding and current row) as running_sum from covid_cases
group by month(dates)
)
select Month, round(100*(total_case)/lag(running_sum) over (),1) as PERCENTAGE_INCREASE
from cte
```