Question link: https://www.youtube.com/watch?v=4Z67GTTWuzc


Solution:
```sql

SET @row := -1;

with deri_tab as (
SELECT
    TRIM(value) AS name_part, 
    CAST(REGEXP_REPLACE(value, '[^0-9]+', '') AS UNSIGNED) AS rw
FROM (
    SELECT
        SUBSTRING_INDEX(SUBSTRING_INDEX(name, ',', seq.digit + 1), ',', -1) AS value
    FROM
        arbitrary_values
    INNER JOIN (
        SELECT @row := @row + 1 AS digit
        FROM information_schema.columns
        LIMIT 21
    ) seq ON LENGTH(REPLACE(name, ',', '')) <= LENGTH(name) - seq.digit
    ORDER BY seq.digit
) AS x
)

,cte as (
    SELECT 
        FLOOR((SQRT(8 * (ROW_NUMBER() OVER () - 1) + 1) - 1) / 2) + 1 AS group_num, 
        name_part
    FROM deri_tab
)
SELECT 
    group_num, 
    GROUP_CONCAT(name_part ORDER BY name_part SEPARATOR ', ') AS names
FROM 
    cte
GROUP BY 
    group_num
ORDER BY 
    group_num;
```