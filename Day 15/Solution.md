```sql

with cte as(select Friend1,Friend2 
from Friends
union all
select Friend2,Friend1 
from Friends)

, cte2 as 
(select f.friend1 as Friend1 ,f.Friend2 as Friend2,c.Friend2 as common
from Friends f
left join cte c
on f.Friend1 = c.Friend1 and c.Friend2<>f.Friend2)

select Friend1 ,Friend2, count(common) as mutual_friends
from cte2
group by Friend1 ,Friend2
order by Friend1
```