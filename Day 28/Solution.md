Solution1:
```sql
with recursive cte as 
(
select id,items, length(items)-length(replace(items,",",""))+1 as cnt from item
union
select id,items,cnt-1 from cte
where cnt >1
)
,cte2 as (
select *,substring_index(items,",",cnt),
        length(substring_index(substring_index(items,",",cnt),",",-1)) as word_length
 from cte)
 
select id,group_concat(word_length order by cnt) as lengths 
from cte2
group by id;
```
Solution2:
```sql

with recursive cte as (
		select 1 as digits
        union all
        select digits+1 as digits from cte
        where digits <(select max(id) from item)
)
,cte1 as 
(select *,substring_index(substring_index(items,',',digits),',',-1) as vals
from item
join cte 
where digits < LENGTH(items) - LENGTH(REPLACE(items, ',', '')) +2)


select id, items,group_concat(length(vals) order by digits) as len from cte1 group by id, items
```        