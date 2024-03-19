Solution1:
```sql
with recursive cte as(
select min(serial_no) as mini , max(serial_no) as maxi from invoice

),
rt as (
select serial_no  from invoice  join 
cte where serial_no = mini
union all
select serial_no + 1 from rt join 
cte where serial_no < maxi
)
select serial_no as missing_serial_no from rt
where serial_no not in (select serial_no from invoice)
```