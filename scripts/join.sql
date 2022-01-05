create database X

create table A (
	id int
)

create table B (
	id int
	)

insert into A (id) values
(1), 
(1), 
(0), 
(1), 
(NULL);

insert into B (id) values
(1), 
(1), 
(0), 
(1), 
(NULL);
/*
	A	B
	1	1
	1	1
	0	0
	1	1
*/
select * from A as a INNER Join A as b on a.id = b.id
select * from A as a LEFT Join A as b on a.id = b.id
select * from A as a RIGHT Join A as b on a.id = b.id
select * from A as a FULL OUTER JOIN A as b on a.id = b.id
