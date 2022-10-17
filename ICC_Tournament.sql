
create table interview.icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
)
INSERT INTO interview.icc_world_cup values('India','SL','India');
INSERT INTO interview.icc_world_cup values('SL','Aus','Aus');
INSERT INTO interview.icc_world_cup values('SA','Eng','Eng');
INSERT INTO interview.icc_world_cup values('Eng','NZ','NZ');
INSERT INTO interview.icc_world_cup values('Aus','India','India');

select * from interview.icc_world_cup;
----Team_name,matchs_played,no_of_win,no_of_loss


---my solution
Select t2.team_name,sum(t2.matchs_played) matchs_played, sum(t2.no_of_win) no_of_win
,sum(t2.matchs_played)-sum(t2.no_of_win) no_of_loss from
(Select t.team as team_name,count(t.team ) as matchs_played, case when t.team=t.winner then count(1) else 0 end as no_of_win
from 
(Select Team_1 as team,Winner from interview.icc_world_cup union all
Select Team_2 as team,Winner from interview.icc_world_cup ) as t 
group by t.team,t.winner ) as t2 
group by t2.team_name


select * from interview.icc_world_cup;
-------------------
---soluntion credit https://www.youtube.com/watch?v=qyAgWL066Vo&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb

select x.team, count(x.team) as match_played, sum(x.win_flag) as match_won, count(x.team) - sum(x.win_flag) as match_lost from 
(select team_1 as team, case when team_1 = winner then 1 else 0 end as win_flag from interview.icc_world_cup
union all
select team_2 as team, case when team_2 = winner then 1 else 0 end as win_flag from interview.icc_world_cup) x
group by x.team
