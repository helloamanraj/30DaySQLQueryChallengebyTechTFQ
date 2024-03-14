Solution1:
```sql
select a.name, count(b.id) as emp_count from employee_managers as a
join employee_managers as b on a.id = b.manager
group by a.name
order by emp_count desc
```