Solution:
```sql

with cte as (
select t.*, id as hut_1, name as hut1_name,  altitude as h1_altitude from trails as t
join mountain_huts
as mt on t.hut1 = mt.id
),
cte2 as (
select hut1,hut1_name,h1_altitude, hut2, name as hut2_name, altitude as h2_altitude
from cte as c
join mountain_huts as m_h on c.hut2 = m_h.id
)

, cte3 as (
select 
case when alt_flag = 1 then hut1 else hut2 end as start_hut,
case when alt_flag= 1 then hut1_name else hut2_name end as start_hut_name,
case when alt_flag= 1 then hut2 else hut1 end as end_hut,
case when alt_flag= 1 then hut2_name else hut1_name end as end_hut_name
from (
select *, case when h1_altitude > h2_altitude then 1 else 0 end as alt_flag from cte2) as x
)

select t2.start_hut_name, t2.end_hut_name as middle_hut, t3.end_hut_name as end_hut 
from cte3 as t1
join cte3 as t2 on t1.start_hut = t2.end_hut
join cte3 as t3 on t2.end_hut = t3.start_hut
```