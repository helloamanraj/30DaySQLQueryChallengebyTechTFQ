Solution1: 
```sql
with cte as(
select user_id, time_to_sec(timediff(session_endtime, session_starttime)) as time_diff , p.* from user_sessions as u
join post_views as p on u.session_id = p.session_id
)

select post_id, sum((perc_viewed/100) * time_diff) as total_viewtime from cte
group by post_id
```