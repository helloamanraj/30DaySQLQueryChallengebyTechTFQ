Solution1:
```sql

with cte as (
select order_id, STR_TO_DATE(order_time, '%d-%m-%Y %H:%i') as order_time,
STR_TO_DATE(expected_delivery, '%d-%m-%Y %H:%i') as expected_delivery, 
STR_TO_DATE(actual_delivery, '%d-%m-%Y %H:%i') as actual_delivery, no_of_pizzas, price,
case when expected_delivery < actual_delivery then no_of_pizzas else 0 end as flag
from pizza_delivery
)

select date_format((order_time),'%b-%y') as period, 
round(100*sum(CASE
    WHEN TIMESTAMPDIFF(MINUTE, order_time, actual_delivery) > 30 THEN 1
    ELSE 0
END)/count(order_id),2) AS DELAYED_DELIVERY_PERC
, sum(flag) as free_pizzas
from cte
where actual_delivery is not null
group by period
order by MONTH(STR_TO_DATE(CONCAT('01-', period), '%d-%b-%y'))
```