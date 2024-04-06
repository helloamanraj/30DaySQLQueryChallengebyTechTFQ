Solution1: 
```sql
with cte as (
select *, lag(status,1) over (order by times) as prev_status
from login_details 
)
,cte2 as (select * from cte
where times not in (select times from cte where status = 'off' and prev_status = 'off')
)

select min(times) as log_in_time, max(times) as log_out_time,  FLOOR(TIME_TO_SEC(TIMEDIFF(MAX(times), MIN(times))) / 60) as duration
from (select times, status, sum(case when status = 'on' and prev_status = 'off' then 1 else 0 end) over (order by times) as grp 
from cte2) as x
group by grp
```  