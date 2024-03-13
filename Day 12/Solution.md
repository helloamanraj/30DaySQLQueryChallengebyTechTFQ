Solution1:
```sql
with recursive cte as (
select employee ,manager, row_number() over () as x from company 
where manager = (select employee from company where manager is null)
union all 
select d.employee, d.manager, x from cte c join company d on c.employee = d.manager )


,cte2 as (
select manager , x from cte union select employee,x from cte
)

select concat('team',x) as teams,  group_concat(manager) as members from cte2 group by x order  by x;

```
Solution2:

```sql

with recursive cte as (
select *,if(
Manager='elon', row_number () over(order by if(manager='elon',1,0) desc),0)
rnk
from company
)
, rce as (
    SELECT Employee, Manager, rnk
    FROM cte
    WHERE rnk > 0 AND Manager IS NOT NULL
    UNION ALL
    SELECT cte.Employee, cte.Manager, rce.rnk
    FROM cte
    INNER JOIN rce ON rce.Employee = cte.Manager)

select concat('Team',rnk) Teams, 
group_concat(employee) members
from 
(select employee, rnk from rce
union 
select manager, rnk from rce) k
group by rnk;

```