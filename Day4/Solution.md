Solution1:
```sql

with cte as (
select id, name , rank() over (order by id desc) as rnk, (select location from q4_data where location is not null) as location
from q4_data
where name is not null 
)

select id, name, location from cte
where rnk = 1
```

Solution2: 
```sql
with cte as (
select id, name , rank() over (order by id desc) as rnk, (select location from q4_data where location is not null) as location
from q4_data
where name is not null 
)

select id, name, location from cte
where rnk = 2
```