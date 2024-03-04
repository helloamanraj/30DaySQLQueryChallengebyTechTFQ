--- VIDEO_Q1 ---

-- Solution 
with cte as
            (select *
            , case when brand1 < brand2 
                              then concat(brand1,brand2,year)
                     else concat(brand2,brand1,year)
              end pair_id
            from brands),
      cte_rn as
            (select * 
            , row_number() over(partition by pair_id order by pair_id) as rn
            from cte)
select brand1, brand2, year, custom1, custom2, custom3, custom4
from cte_rn
where rn = 1 
or (custom1 <> custom3 and custom2 <> custom4);



    