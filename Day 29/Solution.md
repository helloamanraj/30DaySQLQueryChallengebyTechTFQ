Solution1: 
```sql
with cte as (
select *, LAG(status,1) over (order by times) as previous_status from login_details
)

select *, (case when  previous_status='on' then 1 else 0 end) as checks,
sum(case when status='on' and previous_status='off' then 1 else 0 end) over (order by times) as group_key from cte

  select min(times) as log_on,max(times) as log_off, sum(checks) as Duration from cte
  group by group_key
```  