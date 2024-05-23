Question link: https://www.youtube.com/watch?v=jXKGsMPk1Hg

```sql
create table lifts
(
      id         	  int
    , capacity_kg     int
);

insert into lifts values (1, 300);
insert into lifts values (2, 350);


create table lift_passengers
(
      passenger_name    varchar(50)
    , weight_kg     	int
	, lift_id			int
);

insert into lift_passengers values ('Rahul', 85, 1);
insert into lift_passengers values ('Adarsh', 73, 1);
insert into lift_passengers values ('Riti', 95, 1);
insert into lift_passengers values ('Dheeraj', 80, 1);
insert into lift_passengers values ('Vimal', 83, 2);
insert into lift_passengers values ('Neha', 77, 2);
insert into lift_passengers values ('Priti', 73, 2);
insert into lift_passengers values ('Himanshi', 85, 2);
```


Solution:
```sql
with cte as (
select passenger_name, weight_kg, lift_id, capacity_kg, sum(weight_kg) over (partition by lift_id rows between unbounded preceding and current row) as cum_sum
from lift_passengers as lp
inner join lifts as l on l.id = lp.lift_id
)
,cte2 as (
select * from cte 
where cum_sum < capacity_kg )

select lift_id, group_concat(passenger_name) as passengers from cte2
group by lift_id
```