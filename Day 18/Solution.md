Solution1:
```sql
SELECT name AS employee_name, COUNT(DISTINCT event_name) as No_of_Events
FROM employees AS e 
INNER JOIN events AS et ON e.id = et.emp_id 
GROUP BY name 
HAVING COUNT(DISTINCT event_name) = (SELECT COUNT(DISTINCT event_name) FROM events)
```
