-- PostgreSQL 
with recursive cte as 
	(
	with cte_data as
		(select row_number() over(order by arrival_time) as rn, bus_id
		, (select count(1) from passengers p 
		  where p.arrival_time <= b.arrival_time) as total_passengers, capacity
		from buses b)
			select rn, bus_id, capacity, total_passengers
			 , least(capacity,total_passengers) as onboarded_bus
			 , least(capacity,total_passengers) as total_onboarded
			 from cte_data where rn=1
			union all
			 select d.rn, d.bus_id, d.capacity, d.total_passengers
			 , least(d.capacity,(d.total_passengers - cte.total_onboarded)) as onboarded_bus
			 , cte.total_onboarded + least(d.capacity,(d.total_passengers - cte.total_onboarded)) as total_onboarded
			 from cte 
			 join cte_data d on d.rn = cte.rn+1
	)
select bus_id, onboarded_bus as passengers_cnt
from cte
order by bus_id;




-- MSSQL 
with cte_data as
		(select row_number() over(order by arrival_time) as rn, bus_id
		, (select count(1) from passengers p 
		  where p.arrival_time <= b.arrival_time) as total_passengers, capacity
		from buses b),
	cte as
		(select rn, bus_id, capacity, total_passengers
		 , case when capacity < total_passengers then capacity else total_passengers end as onboarded_bus
		 , case when capacity < total_passengers then capacity else total_passengers end as total_onboarded
		 from cte_data where rn=1
		union all
		 select d.rn, d.bus_id, d.capacity, d.total_passengers
		 , case when d.capacity < (d.total_passengers - cte.total_onboarded) then d.capacity else (d.total_passengers - cte.total_onboarded) end as onboarded_bus
		 , cte.total_onboarded + case when d.capacity < (d.total_passengers - cte.total_onboarded) then d.capacity else (d.total_passengers - cte.total_onboarded) end as total_onboarded
		 from cte 
		 join cte_data d on d.rn = cte.rn+1)
select bus_id, onboarded_bus as passengers_cnt
from cte
order by bus_id;
