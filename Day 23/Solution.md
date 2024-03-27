Solution1:
```sql

with recursive cte as (
		with cte_data as (
			select row_number() over (order by arrival_time) as rn, bus_id, (select count(1) from passengers as p
			where p.arrival_time <= b.arrival_time) as total_passengers, capacity 
			from buses as b
            )
            
        select rn ,bus_id, capacity, total_passengers,
        least(capacity, total_passengers) as onboarded_bus,
        least(capacity, total_passengers) as total_onboarded 
        from cte_data
        where rn = 1
		
        union all
        
        select d.rn, d.bus_id, d.capacity, d.total_passengers
			 , least(d.capacity,(d.total_passengers - cte.total_onboarded)) as onboarded_bus
			 , cte.total_onboarded + least(d.capacity,(d.total_passengers - cte.total_onboarded)) as total_onboarded
			 from cte 
			 join cte_data d on d.rn = cte.rn+1
        )    
        
 select bus_id, onboarded_bus as passengers_cnt from cte
 order by bus_id
 ```
 Solution2:
 ```sql

 with cte as (
 select b.bus_id, b.arrival_time as bus_arrival, p.arrival_time as passenger_arrival , capacity,passenger_id,
 case when (b.arrival_time - p.arrival_time) = min(b.arrival_time - p.arrival_time) over (partition by passenger_id) then 1 else 0 end as diff
 from buses as b
 join passengers as p on p.arrival_time <= b.arrival_time
 )
 
 ,cte2 as ( 
select
bus_id, max(bus_arrival) as arrival_time, max(capacity)  as capacity
,sum(diff) as cnt
from cte
group by bus_id
)
,cte3 as (
select *,
case when cnt - capacity < 0 then lag(cnt - capacity) over(order by arrival_time) else cnt - capacity end as diff
from cte2
)
select bus_id
,case when capacity < cnt then capacity else diff end as passenger_cnt
from cte3
```