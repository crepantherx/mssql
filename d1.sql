CREATE TABLE tab1 
( bf nvarchar(128) default 'sudhir' ,
 fromDate date,
toDate date,
CONSTRAINT CK_from CHECK  (([fromDate]>('1998-10-03') AND [fromDate]<('2018-10-03'))),
CONSTRAINT CK_to CHECK  (([toDate]>('1998-10-03') AND [toDate]<('2018-10-03')))
)

CREATE TABLE tb1 
( bf nvarchar(128) default 'sudhir' ,
 fromDate date,
toDate date,
CONSTRAINT CK_frm CHECK  (NOT ([fromDate]>('1998-10-03') AND [fromDate]<('2018-10-03'))),
CONSTRAINT CK_t CHECK  (NOT ([toDate]>('1998-10-03') AND [toDate]<('2018-10-03')))
)

CREATE TABLE tb2
( bf nvarchar(128) default 'sudhir' ,
 fromDate date CHECK  (NOT ([fromDate]>('1998-10-03') AND [fromDate]<('2018-10-03'))),
 toDate date CHECK  (NOT ([toDate]>('1998-10-03') AND [toDate]<('2018-10-03'))),
)

CREATE TABLE tb3
( bf nvarchar(128) default 'sudhir' ,
 fromDate date default '2021-04-17' CHECK  (NOT ([fromDate]>('1998-10-03') AND [fromDate]<('2018-10-03'))),
 toDate date default '2022-04-17' CHECK  (NOT ([toDate]>('1998-10-03') AND [toDate]<('2018-10-03'))),
)

CREATE TABLE tb4
( 
	bf nvarchar(128) default 'sudhir' ,
 fromDate date default '2021-04-17'  CHECK  (NOT ([fromDate]>('1998-10-03') AND [fromDate]<('2018-10-03'))),
 toDate date default '2022-04-17' CHECK  (NOT ([toDate]>('1998-10-03') AND [toDate]<('2018-10-03'))),
)

INSERT into tb3 (fromDate,toDate) 
values('2021-10-6','2022-11-3')

INSERT into tb3 (bf,toDate) 
values('vimal','2022-11-3')


select * from ipl.deliveries
select * from ipl.matches

select city,venue from ipl.matches
where team1 = 'Royal challengers Bangalore' or team2 = 'Royal challengers Bangalore'
group by city,venue


select batsman,sum(inning) as total_innings, total_runs 
from ipl.deliveries
group by batsman, total_runs
ORDER BY total_runs DESC

select season,winner from ipl.matches
group by season,winner




select * from ipl.deliveries


SELECT batsman, SUM(total_runs) AS total_runs, COUNT(DISTINCT match_id) as total_innings,ROUND(( CAST(sum(total_runs) AS FLOAT)/CAST(count(distinct match_id) AS FLOAT)),2) as avrg
FROM ipl.deliveries
GROUP BY batsman

