Solution1:
```sql
with cte as (
select *, row_number() over (partition by customer, token_num) as rw from tokens
)
select min(case when rw= 2 then token_num end) as Token_num from cte 
```