Solution1:
```sql 
with recursive cte as (
		with cte_data as (
		select id, v.emp_id, from_dt, to_dt, 
		l.balance as leave_balance, (DATEDIFF(to_dt, from_dt) + 1) - 2*(week(to_dt) - week(from_dt)) as diff_without_weekends,
        row_number() over(partition by v.emp_id order by v.emp_id,id) as rn
        from vacation_plans as v
		inner join leave_balance as l on v.emp_id = l.emp_id
		)
		select id, emp_id, from_dt, to_dt, leave_balance, diff_without_weekends ,(leave_balance - diff_without_weekends) as remaining_balance , rn from cte_data
        where rn=1
		
        union all
			
		select cd.id, cd.emp_id, cd.from_dt, cd.to_dt, cd.leave_balance, cd.diff_without_weekends
        ,(remaining_balance - cd.diff_without_weekends) as remaining_balance, cd.rn
        from cte join cte_data as cd on cd.rn=cte.rn+1 and cd.emp_id=cte.emp_id
		
        )
        
    Select id, emp_id, from_dt, to_dt, diff_without_weekends as vacation_days, case when remaining_balance >= 0 then
    'Approved' else 'Insufficient Leave Balance' end as Status
    from cte
	```