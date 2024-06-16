```sql
CREATE TABLE color_table (
    id INT PRIMARY KEY,
    colors VARCHAR(255)
);

-- Insert data into the table
INSERT INTO color_table (id, colors) VALUES
(1, 'Red,Green,Blue'),
(2, 'Orangered,Periwinkle');
```

Solution1:
```sql
select id,  substring_index(substring_index(colors, ',', n.digit + 1 ),',',-1) as color
from color_table
inner join 
(select 0 as digit union all select 1 union all select 2 union all select 3) as n
on length(replace(colors, ',', '')) <=  length(colors) - n.digit
order by id
```

Solution2:

```sql

set @row := -1;

select id,  substring_index(substring_index(colors, ',', n.digit + 1 ),',',-1) as color
from color_table
inner join 
( SELECT @row := @row + 1 AS digit
        FROM information_schema.columns
        LIMIT 3) as n
on length(replace(colors, ',', '')) <=  length(colors) - n.digit
order by id
```