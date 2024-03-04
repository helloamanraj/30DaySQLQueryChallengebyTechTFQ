Solution:
```sql
WITH CARS as (SELECT car FROM FOOTER
WHERE car IS NOT NULL
ORDER BY id DESC
LIMIT 1),
lengths as (SELECT length FROM FOOTER
WHERE length IS NOT NULL
ORDER BY id DESC
LIMIT 1),
widths as (SELECT width FROM FOOTER
WHERE width IS NOT NULL
ORDER BY id DESC
LIMIT 1),
heights as (SELECT height FROM FOOTER
WHERE height IS NOT NULL
ORDER BY id DESC
LIMIT 1)
SELECT * FROM CARS,LENGTHS, WIDTHS, HEIGHTS;
```

Solution2:
```sql

select * from 
(select car from footer where car is not null order by id desc limit 1) as Car
cross join (select length from footer where length is not null order by id desc limit 1 ) lenght
cross join (select width from footer where width is not null order by id desc limit 1) Width
cross join (select height from footer where height is not null order by id desc limit 1) Height
```

