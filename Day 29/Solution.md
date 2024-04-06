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
Solution2:
```sql

with cte as (
select *,
       row_number() over(order by times) as rn,
       row_number() over(partition by status order by times) as rn1,
	   row_number() over(order by times)- row_number() over(partition by status order by times) as diff
from login_details
order by times)
,cte2 as (
select min(times) as times,status,diff
from cte
group  by status,diff
)
,cte3 as (
select *,lead(status) over(order by times) as ld,lead(times) over(order by times) as ld1
from cte2
)
select times as log_on,
        ld1 as log_off,
        minute(timediff(ld1,times)) as  duration
 from cte3
 where status ="on" and ld="off"
```
