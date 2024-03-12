Solution: 
```sql
select  dates, product_id as products from orders
union
select 
    dates, group_concat(product_id ORDER BY product_id SEPARATOR ',') as products from orders
group by customer_id, dates
order by dates, products
```