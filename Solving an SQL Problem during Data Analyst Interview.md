Question link : https://www.youtube.com/watch?v=TRiWeg3M3oQ


Database 

```sql 


-- Create the 'teams' table
CREATE TABLE teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL
);

-- Create the 'matches' table

drop table matches
CREATE TABLE matches (
    match_id INT PRIMARY KEY,
    host_team INT,
    guest_team INT,
    host_goals INT,
    guest_goals INT,
    FOREIGN KEY (host_team) REFERENCES teams(team_id),
    FOREIGN KEY (guest_team) REFERENCES teams(team_id)
);

-- Insert data into 'teams'
INSERT INTO teams (team_id, team_name)
VALUES
(10, 'Give'),
(20, 'Never'),
(30, 'You'),
(40, 'Up'),
(50, 'Gonna');

-- Insert data into 'matches'
INSERT INTO matches (match_id, host_team, guest_team, host_goals, guest_goals)
VALUES
(1, 30, 20, 1, 0),
(2, 10, 20, 1, 2),
(3, 20, 50, 2, 2),
(4, 10, 30, 1, 0),
(5, 30, 50, 0, 1);
```


Solution

```sql
    
with cte as (
select host_team ,  
case when host_goals > guest_goals then 3 
when host_goals  = guest_goals then 1 end as winner 
from matches    

union all 

select guest_team,  
case when host_goals < guest_goals then 3 
when host_goals  = guest_goals then 1 end as winner 
from matches    
)

select team_id ,team_name , coalesce(sum(winner),0) as total_points from cte as c
right join teams as t on c.host_team = t.team_id
group by team_id, team_name
order by total_points desc
```