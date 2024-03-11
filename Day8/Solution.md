Solution1:
```sql
 SELECT 
    *,
    (SELECT job_role 
     FROM job_skills AS b 
     WHERE b.row_id <= a.row_id AND b.job_role IS NOT NULL 
     ORDER BY b.row_id DESC 
     LIMIT 1) AS y
FROM 
    job_skills AS a
ORDER BY 
    row_id;
```

Solution2: 

```sql


select row_id, filled_job_role as job_role, skills from (SELECT 
    t.*,
    COALESCE(
        job_role, 
        (SELECT job_role 
         FROM job_skills 
         WHERE row_id < t.row_id AND job_role IS NOT NULL 
         ORDER BY row_id DESC
         LIMIT 1)
    ) AS filled_job_role
FROM 
    job_skills AS t) as x
    
```
