```sql
WITH cte AS (
    SELECT *,
           login_date - CAST(DENSE_RANK() OVER (PARTITION BY user_id ORDER BY user_id, login_date) AS SIGNED) AS date_group
    FROM user_login
)
SELECT user_id,
       MIN(login_date) AS start_date,
       MAX(login_date) AS end_date,
       (MAX(login_date) - MIN(login_date)) + 1 AS consecutive_days
FROM cte
GROUP BY user_id, date_group
HAVING COUNT(*) >= 5 
    AND (MAX(login_date) - MIN(login_date)) >= 4
ORDER BY user_id, date_group;
```


