Solution1:
```sql

with cte as (
select * , lag(grp) over (order by date) as prev_grp from (select date, group_concat(vendor) as grp from sales
group by date) as x
)

, cte2 as 
(select date, grp from cte
union all
select date, prev_grp as grp from cte
)

,cte3 as (
select * from cte2
where grp is not null
)
SELECT 
    date,
    SUBSTRING_INDEX(SUBSTRING_INDEX(grp, ',', n), ',', -1) AS grp
FROM cte3
CROSS JOIN
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) AS numbers
WHERE 
    n <= 1 + LENGTH(grp) - LENGTH(REPLACE(grp, ',', ''))
```