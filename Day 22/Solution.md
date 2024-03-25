Solution1:
```sql

with cte as 
(select home_team as team, result, dates from ipl_results
union all 
select away_team as team, result, dates from ipl_results)

,cte2 as (
select *, row_number() over(partition by team order by dates ) as row1 from cte
)
,
cte3 as (
select  *, row1 - row_number() over(partition by team order by dates) as diff from cte2
WHERE team = result
)

select team , max(cnt) as winn_streak from (select *, count(1) over(partition by diff, team) as cnt from cte3) as x
group by team 
order by winn_streak desc
```