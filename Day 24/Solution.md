Solution1
```sql
select cust_name, email as valid_emails from feedback
WHERE email REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@[A-Za-z]+\\.[A-Za-z]{2,3}$'
```  