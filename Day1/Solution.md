Solution1: 
```sql


(
SELECT * FROM brands
WHERE 
    custom1 = custom3 
    AND 
    custom2 = custom4
    and
    year in (select distinct year from brands WHERE 
    custom1 = custom3 
    AND 
    custom2 = custom4)
    and
    (SELECT SUBSTRING_INDEX(concat(brand1, brand2), 1, 1)) = (SELECT SUBSTRING_INDEX(concat(brand1, brand2), 1, 1))
LIMIT 1
)

union all
(
SELECT 
    *
FROM 
    brands
WHERE custom1 != custom3 OR custom2 != custom4
    and
    year in (select distinct year from brands WHERE 
    custom1 != custom3 OR custom2 != custom4)
    and
    (SELECT SUBSTRING_INDEX(concat(brand1, brand2), 1, 1)) = (SELECT SUBSTRING_INDEX(concat(brand1, brand2), 1, 1))
)


union all
(
select * from brands
where (brand1 or brand2 is null) and (brand1 or brand2 is null) 
and year in (select distinct year from brands where (brand1 or brand2 is null) and (brand1 or brand2 is null) )
)


```

Solution2:

```sql
with cte as (
select *, case when brand1 > brand2 then concat(brand1, brand2, year) 
else concat(brand2, brand1, year) end as concat 
from brands
)

select brand1, brand2, year, custom1, custom2, custom3, custom4, rw
from (select *, row_number() over (partition by concat order by concat) as rw from cte)
as x
where rw=1 
or
(custom1 != custom3)
 or 
 (custom2 != custom4) 

```


