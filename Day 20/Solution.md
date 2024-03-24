Solution1: 
```sql
with cte as(
select *, count(country) over (partition by country ) as cnt, 
row_number() over (partition by country order by age) as row_num
from people
order by id
)

select country, age from cte
where row_num IN (FLOOR((cnt + 1) * 1.0 / 2), CEILING((cnt + 1) * 1.0 / 2));
```

Solution2:
```sql
with cte as(
select *, count(country) over (partition by country ) as cnt, 
row_number() over (partition by country order by age) as row_num
from people
order by id
)

select country, age from cte
where 
(cnt % 2 = 0 AND row_num IN (CEILING(cnt / 2.0), CEILING(cnt / 2.0) + 1)) -- Even count
    OR (cnt % 2 <> 0 AND row_num = CEILING(cnt / 2.0)); -- O
```


