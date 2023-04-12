CREATE TABLE A (id int)

INSERT INTO A VALUES 
(1),
(1),
(0),
(1),
(NULL)

SELECT * 
FROM A as a
FULL OUTER JOIN A as b ON a.id=b.id


CREATE TABLE B (id int)

INSERT INTO B VALUES 
(1),
(2),
(3),
(4),
(5)

SELECT * 
FROM B as a
FULL OUTER JOIN B as b ON a.id=b.id


inner join - it is the result of nested loop comparison of base table with the joining table
left join - inner join + whatever leftover in base TABLE
right
outer join - inner +


nested loop
merge join
hash join

https://www.youtube.com/watch?v=pJWCwfv983Q












