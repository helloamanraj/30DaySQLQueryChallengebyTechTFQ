Solution1: 
```sql

with cte as (
select client, auto, repair_date, max(case when indicator = "velocity" then value end) as Velocity,
max(case when indicator = "level" then value end) as level  
from auto_repair
group by client, auto, repair_date
)

select velocity, 
sum(case when level = 'good' then 1 else 0 end) as good,
sum(case when level = 'wrong' then 1 else 0 end) as wrong, 
sum(case when level = 'regular' then 1 else 0 end) as regular
from cte  
group by velocity
order by velocity
```