Question link: https://www.youtube.com/watch?v=d7pZNZbpdo8


```sql
create table emp_attendance
(
	employee 	varchar(10),
	dates 		date,
	status 		varchar(20)
);
insert into emp_attendance values('A1', '2024-01-01', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-02', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-03', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-04', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-05', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-06', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-07', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-08', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-09', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-010', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-06', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-07', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-08', 'ABSENT');
insert into emp_attendance values('A2', '2024-01-09', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-010', 'ABSENT');
```


Solution:
```sql
with cte as (
select *, row_number() over (partition by employee, status order by dates ) as rw, 
dates - row_number() over (partition by employee order by employee) as diff from emp_attendance
order by  employee, dates
)
select employee, min(dates) as from_date, max(dates) as to_date, status from cte
group by employee, status, diff
```