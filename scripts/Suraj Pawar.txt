                                       
                                               CREATE AND INSERT COMMAND
                      
create table client (cid number(10) constraints pk_cid primary key,cname varchar2(50) not null,cadd varchar2(50));
create table dept (dno number(10) constraints pk_dno primary key,dname varchar2(50) not null,dcity varchar2(50));
create table project (pid number(10) constraints pk_pid primary key,pname varchar2(50) not null,pcost number(10),cid number(10), constraints fk_project_cid foreign key(cid) references client(cid));
create table employee (eno number(10) constraints pk_eno primary key,ename varchar2(50) not null,esal number(20),dno number(10),constarints fk_emp_dno foreign key(dno) references department(dno),pid number(10),constraints fk_emp_pid foreign key(pid) references project(pid));


INSERT COMMAND:-
 insert into client values(100,'zensar','pune');
 insert into client values(101,'tcs','mumbai');
 insert into client values(102,'ibm','gujrat');
 insert into client values(103,'tech m','dehli');
 insert into client values(104,'zs','gurgoan');
 insert into client values(105,'wipro','pune');

 insert into dept values(10,'IT','pune');
 insert into dept values(11,'HR','pune');
 insert into dept values(12,'SALES','pune');
 insert into dept values(13,'ANALYTICS','pune');
 insert into dept values(14,'PRODUCT','pune');
 
 insert into project values(1,'java',250000,100);
 insert into project values(1,'java',250000,101);
 insert into project values(2,'db',350000,102);
 insert into project values(2,'db',350000,103);
 insert into project values(3,'php',450000,104);
 insert into project values(3,'php',450000,105);
 insert into project values(4,'c++',200000,101);
 insert into project values(4,'c++',200000,102);
 insert into project values(5,'python',560000,105);
 insert into project values(5,'python',560000,104);

insert into employee values(501,'Omkar',500000,10,1);
insert into employee values(502,'prasad',560000,11,2);
insert into employee values(503,'suraj',560000,12,5);
insert into employee values(504,'kiran',560000,13,3);
insert into employee values(505,'pratik',560000,14,null);
insert into employee values(506,'pramod',560000,10,4);
insert into employee values(507,'akash',560000,11,2);
insert into employee values(508,'rohan',560000,12,1);
insert into employee values(509,'ishwar',560000,13,3);
insert into employee values(510,'ganesh',560000,13,4);
 





************************************************************************************************************************************************************************

                                                     JOINS


  JOIN :- DIFFRENT TYPES OF JOIN IN SQL SERVER
          1) CROSS JOIN
          2) INNER JOIN
          3) OUTER JOIN :-LEFT,RIGHT AND FULL OUTER JOIN

              EMP                                                             DEPARTMENTS

  ENO   NAME   GENDER   SALARY   DEPARTMENT_ID(FK)                        ID   DEPARTMENT_NAME  LOCATION   DEPARTMENT_HEAD 
   
   101  AMIT    MALE    40000       10                                    10     IT              PUNE       JAY
   102  AJAY    MALE    50000       10                                    20      PAYROLL         DELHI      SHUBHAM
   103  JAY     MALE    35000       20                                    30     HR              MUMBAI     SARA
   104  NEENA   FEMALE  25000       30                                    40     SALES           GUJRAT     AMIT 
   105  ATUL    MALE    40000      NULL
   106  MEENA   FEMALE  55000      NULL

    INNNER JOIN:-SELECT ENO,NAME,SALARY,DEPARTMENT_NAME FROM EMP  INNER JOIN DEPARTMENTS  ON(EMP.DEPARTMENT_ID=DEPARTMENTS.ID);

     ENO   NAME  SALARY  DEPARTMENT_NAME 
     101   AMIT  40000     IT
     102   AJAY  50000     IT
     103  JAY     MALE     PAYROLL
     104  NEENA   FEMALE   HR 


   CROSS JOIN:- SELECT ENAME,DEPARTMENT_NAME FROM EMP  CROSS JOIN  DEPARTMENTS;

    NAME   DEPARTMENT_NAME                      
   
    AMIT       IT  
    AMIT       PAYROLL
    AMIT       HR
    AMIT       SALES
    AJAY       IT  
    AJAY       PAYROLL
    AJAY       HR
    AJAY       SALES
    JAY        IT  
    JAY        PAYROLL
    JAY       HR
    JAY       SALES
    ------SO ON---------

    RIGHT OUTER:-SELECT ID,DEPARTMENT_NAME,LOCATION,DEPARTMENT_HEAD,ENAME FROM EMP  RIGHT OUTER JOIN DEPARTMENTS  ON(EMP.DEPARTMENT_ID=DEPARTMENTS.ID);

      ID DEPARTMENT_NAME LOCATION DEPARTMENT_HEAD ENAME
      10   IT              PUNE     JAY             AMIT
      10   IT              PUNE     JAY            AJAY
      20   PAYROLL        DELHI     SHUBHAM        JAY
      30   HR              MUMBAI    SARA          NEENA
      40   SALES           GUJRAT    AMIT           NULL
  
       
    LEFT OUTER:-   SELECT ENO,ENAME,SALARY,DEPARTMENT_HEAD FROM EMP  LEFT OUTER JOIN DEPARTMENTS  ON(EMP.DEPARTMENT_ID=DEPARTMENTS.ID);

      ENO   ENAME    SALARY  DEPARTMENT_HEAD   
      101  AMIT      40000       JAY  
      102  AJAY      50000       JAY
      103  JAY       35000       SHUBHAM
      104  NEENA     25000       SARA
      105  ATUL      40000       NULL
      106  MEENA     55000       NULL


FULL OUTER JOIN:- SELECT * FROM EMP  FULL OUTER JOIN DEPARTMENTS  ON(EMP.DEPARTMENT_ID=DEPARTMENTS.ID);

   ENO   ENAME   GENDER   SALARY    ID    DEPARTMENT_NAME  LOCATION   DEPARTMENT_HEAD 
   
   101  AMIT    MALE    40000       10      IT              PUNE       JAY
   102  AJAY    MALE    50000       10      IT             PUNE       JAY
   103  JAY     MALE    35000       20      PAYROLL        DELHI       SHUBHAM
   104  NEENA   FEMALE  25000       30      HR              MUMBAI      SARA
   105  ATUL    MALE    40000      NULL     NULL             NULL      NULL
   106  MEENA   FEMALE  55000      NULL     NULL             NULL       NULL
   NULL NULL    NULL    NULL        40     SALES            GUJRAT     AMIT


MECHNISM OF JOINS:-
                   HASH JOIN   :- 
                   NESTED LOOP :- 
                   MERGE JOINS:-  




************************************FUNCTIONS***************************************************************************************************************************


STRINGS FUNCTIONS:-                                               EMP
                                                               ENAME 
                                                                AJAY
                                                                Ajay ajay
                     1)ASCII() 
                     2)CHAR()
                     3)LTRIM()
                     4)RTRIM()
                     5)LOWER() 
                     6)UPPER()
                     7)REVERSE()
                     8)LEN()
                     9)LEFT()
                     10)RIGHT()
                     11)CHARINDEX()


                     12)SUBSTRING()
                     13)REPLICATE()
                     14)PATIINDEX()
                     15)REPLACE()
                     16)STUFF()
                     17)CONCATE()
                     18)COALESCE()
 
 DATE FUNCTION:-  MM/DD/YYYY
                 1)SELECT DAY('01/12/2021')
                 2)SELECT MONTH('01/12/2021')
                 3)SELECT YEAR('01/12/2021')

                 4)DATEPART:-  SELECT DATEPART(WEEKDAY,'12/10/2021')

                  5)DATEADD:-   SELECT DATEADD (DAY,20,'12/10/2021') 

                 6)DATEDIFF:-  SELECT DATEDIFF(MONTHS,'11/10/2021','01/10/2021')
                                SELECT DATEDIFF(DAY,'11/10/2021','01/10/2021')
 
                 7) DATEFORMATE:- SELECT DATEFORMATE(2015,10,25) AS [DATE]

                 8) EOMONTH :-SELECT EOMONTH('12/10/2021') AS LASTDAY
                              SELECT EOMONTH('12/10/2021',2) AS LASTDAY.

MATHEMATICAL FUNCTIONS:-

                       1) ABS:-SELECT ABS(-101.5)  
                       2)CEILING:-SELECT CEILING(15.2)
                       3)FLOOR:-SELECT FLOOR(15.2)
                       4)POWER:-SELECT POWER(2,3) 
                       5)SQUARE:-SELECT SQUARE(9) 81
                       6)SQRT:-SELECT SQRT(81) 9
                       7)ROUND:-SELECT ROUND(45678.45,-2)=45700
                       8)TRUNC:-SELECT TRUNC(45678.45,-2)=45600

AGGREGATE FUNCTION:-   
                      1)SUM()
                      2)MIN()
                      3)MAX()
                      4)AVG()
                      5)COUNT()
DECODE FUNCTION:-
                    
                     EMP
                ENO FIRST_ENAME  SALARY
                101   STEVEN     50000
                102   CARRY      30000
                103   LEX        35000
                104   PETER      45000
                    

 SELECT FIRST_NAME,SALARY,DECODE(FIRST_NAME,'STEVEN',SALARY+5000,'LEX',SALARY+3000,SALARY) AS INCREMENTSALARY FROM EMP;

       
                       EMP
                ENO FIRST_ENAME  SALARY
                101   STEVEN     55000
                102   CARRY      30000
                103   LEX        38000
                104   PETER      45000
 
WINDOW FUNCTION OR ANALYTICS FUNCTION:-
                                       1)ROW_NUMBER()
                                       2)RANK()
                                       3)DENSE_RANK()
                             
               STUDENTS      
    SNO  SNAME    MARKS                  
    
    1     AMAR   60  1     1   1
    2     VIJAY  60  1     1   2
    3     NEENA  60  1     1   3
    4     VINA   50  4     2   4
    5     kunal  40  5     3   5
    6     ATUL   40  5     3   6
 
************************************************************************************************************************************************************************
                                    DATE FUNCTIONS
                      
select sysdate from dual;

select sysdate + 365 from dual;

select sysdate -2 from dual;

select first_name,hire_date,trunc (sysdate-hire_date)as exp_days from employees

select first_name,hire_date,trunc((sysdate-hire_date)/365) as exp_years from employees;    -- q. find employees experiences in years.

select months_between (sysdate,hire_date) as months from employees;

select add_months(sysdate,5) from dual;

select hire_date,add_months(hire_date,5) as addmonths from employees;                        

select next_day(sysdate,'sunday') from dual;                               


select hire_date,next_day(hire_date,'sunday') as days from employees;                -- q. find joining after first hoilday of every employees.

select last_day(sysdate) from dual;

select hire_date,last_day(hire_date) as lastday from employees;                       -- q. find  joining after first salary of every employees.

select round(sysdate,'month') from dual;

select hire_date,round(hire_date,'month') as roundmonths from employees;

select hire_date,round(hire_date,'year') as roundyears from employees; 

select trunc(sysdate,'month') as data from dual;

select hire_date as data 
from employees 
where to_char(hire_date,'mon')='aug';                                                 -- q. whose employees join in aug months.

select hire_date,trunc(hire_date,'year') as data
from employees
where trunc(hire_date,'year')='1-jan-98';                                            --  q. whose employees join in 1998 year.

***********************************************************************************************************************************************************************


************************************************SUBQUERY**************************************************************************************************************

-SUBQUERY :-
              -1) SINGLE ROW SUBQUERY  :-    =,>=,<=,>,<,!=
              -2) MULTIPLE ROW SUBQUERY :-   IN,ANY,ALL
              

SELECT * FROM employees WHERE salary = (SELECT salary FROM employees WHERE upper(first_name)= 'LEX' );
SELECT * FROM employees WHERE salary >= (SELECT salary FROM employees WHERE upper(first_name)= 'LEX' );
SELECT * FROM employees WHERE salary <= (SELECT salary FROM employees WHERE upper(first_name)= 'LEX' );
SELECT * FROM employees WHERE salary < (SELECT salary FROM employees WHERE upper(first_name)= 'LEX' );
SELECT * FROM employees WHERE salary > (SELECT salary FROM employees WHERE upper(first_name)= 'LEX' );
SELECT * FROM employees WHERE salary != (SELECT salary FROM employees WHERE upper(first_name)= 'LEX' );

SELECT * FROM employees WHERE salary IN (SELECT max(salary) FROM employees WHERE first_name like 'A%' );
SELECT * FROM employees WHERE salary > any  (SELECT salary FROM employees WHERE first_name like 'S%');
SELECT * FROM employees WHERE salary > all (SELECT salary FROM employees WHERE first_name like 'S%')
IN  (2400,1200,1000);


----------COOREALTED SUBQUERY---
     
     create table emp1(eno number(10)primary key,ename varchar2(60),salary number(15));      --e2.salary    >=     e1.salary
    
     insert into emp1 values(1,'jay',2000)                                                    --2000    <=     2000     5th max
     insert into emp1 values(2,'ajay',4000)                                                   --4000           4000     3rd max
     insert into emp1 values(3,'Aay',6000)                                                    --6000           6000     2nd max
     insert into emp1 values(4,'ajit',3000)                                                   --3000           3000     4th max        
     insert into emp1 values(5,'meena',7000)                                                  --7000           7000     1st max
SELECT * FROM emp1
    SELECT DISTINCT salary from emp1 e1 WHERE 2= (SELECT COUNT(DISTINCT salary) FROM emp1 e2 WHERE e1.salary <= e2.salary);
   
 *************PAIRWISE SUBQUERY**********   

--- pairwise subquery is used to code optimised and pass two column values

---notation:-    =,!=

   SELECT * FROM emp1 WHERE eno,ename =(SELECT eno,ename from emp1 where eno=1);
   
   SELECT * FROM emp1 WHERE eno=(SELECT eno FROM emp1 WHERE eno=1)
   OR
   ename=(SELECT ename FROM emp1 WHERE eno=1)
   
   SELECT * FROM emp1 WHERE (eno,ename) =(SELECT eno,ename from emp1 where eno=1);
    
 ----FIND Nth HIGHEST SALARY DEPT WISE   
    
SELECT * FROM (SELECT first_name,salary,department_id,DENSE_RANK() OVER(PARTITION BY  department_id ORDER BY salary DESC)as r FROM employees)WHERE r=&n;

select * from tab;
***********************************************************************************************************************************************************************
                      CHARACTER FUNCTIONS

                        case-manipulation function

select first_name,lower(first_name) from employees;

select first_name,  upper(first_name) from employees;

select * from employees where upper(first_name)='DAVID'

select first_name, initcap(first_name) from employees; 


                        character-manipualtion function
                        
  select employee_id, concat(first_name,last_name) as fullname from employees; 
  
  select first_name, salary from employees where substr(first_name,4)='na';       q. find which emp has first_name having 4th letter starting with 'n'.
  
  select length(first_name) from employees;
  
  select first_name, instr (first_name,'S') as data from employees;                 ans.tells postion of S in first_name of employees.
                        
  select salary ,lpad(salary ,12 '*' ) as data from employees; 
  
  select salary,rpad(salary,5,'*')as data from employees;
  
  select first_name,replace(first_name,'S','T') as data from employees;              ans. replace S into T form employees.
  
  select first_name, trim ('S' from first_name) as data from employees;               ans. remove S from first_name of employees.

***********************************************************************************************************************************************************************
               SLOVED QUERY 

select distinct salary from employees;

select  sum(avg(salary)) from employees where department_id=90 group by department_id;

select department_id, sum(salary) from employees having sum(salary)>20000 group by department_id order by department_id;

select  distinct department_id, trunc(avg(salary)) as data from employees group by department_id order by department_id ;

select department_id,first_name,sum(salary) from employees where department_id >80 having sum(salary)>15000 group by department_id,first_name;

select distinct salary, sum(salary) from employees group by salary;

select distinct avg(salary) from employees;

select distinct hire_date,to_char(hire_date,'yyyy'),max(salary) from employees where to_char(hire_date,'yyyy')='1987' group by hire_date, to_char(hire_date,'yyyy');

select department_id, max(salary)from employees where department_id>30 group by department_id having max(salary)>2000 order by department_id.

select to_char(hire_date,'dd-mon-yyyy  HH:MI:SS PM') from employees;

select to_date(to_date('1-jan-2021'),'day-month-yyyy') from dual;

select commission_pct,nvl2(commission_pct,'fulltime emp','inter emp') as bonus from employees;

select first_name,last_name,nullif(length(first_name),length(last_name))as data from employees;

select commission_pct,salary,coalesce(commission_pct,salary,125)as data from employees;

select commission_pct,salary, nvl(commission_pct,2000)+salary as bonus from employees;

select commission_pct,nvl2(commission_pct,'inter emp','fulltime emp')as bonus from employees;

select first_name,last_name,nullif(length(first_name),length(last_name))as data from employees;

select commission_pct,salary,coalesce(commission_pct,salary,2000)as data from employees;

select commission_pct,salary,nvl(commission_pct,salary,2000)as data from employees;

***********************************************************************************************************************************************************************

*****************************************************logical operator**************************************************************************************************

select * from dept where dno between 10 and 20;

select * from employee where eno in (501,503,506,508);

select * from employee where eno not in (507,506,501);

select * from employee where eno=501 OR eno=503;

select * from employee where eno < 507 AND esal > 10000;

select * from employee where eno=503;

select * from employee where eno!=503;

select * from employee where eno<503;

select * from employee where eno>503;

select * from employee where eno>=503;

select * from employee where eno<=503;

select * from employee where eno<>503;


*********like operator***********

select * from employee where ename like 'o%';

select * from employee where ename like '%r';

select * from employee where ename like '%u%';

*********null and not null************

select * from employee where pid is null;

select * from employee where pid is not null;


********group OR aggregate function******

select sum (pcost) from project;

select min (pcost) from project;

select max (pcost) from project;

select avg (pcost) from project;

select count (pcost) from project;

**********single row function********
select lower(ename) as data from employee;

select upper(ename) as data from employee;

select initcap(ename) as data from employee;

select concat(cname,cadd) as data from client;

************drop,delete,update****************

 delete from client
 where cid=100;

 drop table client;

 truncate table dept;

  update employee 
  set eno=525
  where eno=508;

************schema object***********************

create or replace view v1 as select * from project;

create or replace index x1 on employee(ename);

create synonym emp for employee;

***********************************************************************************************************************************************************************
