create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));


insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')

--Question 
--Need to find most visited floor,total_visits, resources used
with resources as (select name,count(1) as total_visits,
				  string_agg(distinct resources,',') as resources from entries group by name),
floor_visit as(select name,floor,count(1) as no_of_floor_visit,rank() over(
partition by name order by count(1) desc) from entries group by name,floor)
select t1.name,t1.total_visits,t1.resources,t2.floor as most_visited_floor
from resources t1 join floor_visit t2 on t1.name = t2.name where rank=1 order by name
