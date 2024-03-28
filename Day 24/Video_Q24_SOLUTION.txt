
-- PostgreSQL Solution
select cust_name, email as Valid_emails
from feedback
where email ~ '^[A-Za-z][A-Za-z0-9._-]*@[A-Za-z]+\.[A-Za-z]{2,3}$';



-- Microsoft SQL Server Solution
select * from feedback
where email like '[a-zA-Z]%@[a-zA-Z]%.[a-zA-Z]%'
and email not like '%[^a-zA-Z0-9_.-]%@[a-zA-Z]%.[a-zA-Z]%'
and charindex('.', reverse(email)) between 3 and 4;
