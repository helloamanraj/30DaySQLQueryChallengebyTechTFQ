Solution1:

```sql
select * from Day_Indicator

with cte as (
select *, substring(Day_Indicator, (((dayofweek(dates) + 5)%7) +1), 1) as week_day
from day_indicator 
)

select product_id, dates from cte
where week_day = 1
```