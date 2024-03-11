-- Solution:
select dates, cast(product_id as varchar) as products 
from orders
union
select dates, string_agg(cast(product_id as varchar),',') as products
from orders
group by customer_id, dates
order by dates, products;