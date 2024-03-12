Solution1:
```sql

WITH cte AS (
    SELECT hotel,year,rating, AVG(rating) OVER(PARTITION BY hotel ORDER BY hotel) AS avg_rating
, stddev(rating) over(partition by hotel  ORDER BY hotel) as std_dev  
    FROM  hotel_ratings
),
cte1 AS (
    SELECT  * , (avg_rating + std_dev) as positive , 
    (avg_rating - std_dev ) as negative from cte
	
),cte2
as
(
Select *, CASE WHEN rating <= positive and rating >=negative THEN 1 else 0 end as flag from cte1
)
select hotel,year,rating from cte2 
where flag != 0
order by hotel desc, year asc

```

Solution2:
```sql
with cte as (
select hotel, year, rating ,round(avg(rating) over (partition by hotel order by year),2) as avg_rating
from hotel_ratings
)
,
cte2 as 
(select *, avg_rating -1 as min_avg, avg_rating + 1 as max_avg
from cte
)

select hotel, year, rating from cte2
where rating > min_avg and rating < max_avg 
```