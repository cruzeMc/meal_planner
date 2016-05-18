/*=========================================WINDOWS USERS USING XAMPP================================================
TO CONNECT TO XAMPP MYSQL SERVER, WE NEED TO FIND THE MYSQL CLIENT (THE CLIENT IS A NORMAL PROGRAM BY THE NAME: mysql.exe ) THAT IS IN THE DEFAULT LOCATION: C:/xampp/mysql/bin

TO NAVIGATE TO THIS DIRECTORY:  cd \
THEN:
cd xampp
cd mysql
cd bin

ONCE IN THIS FOLDER THEN YOU CAN CONNECT USING THE MYSQL CLIENT. THE COMMAND IS:

mysql -h localhost -u root -p

YOU WILL BE PROMPTED FOR A PASSWORD:
Enter password:


IF YOU SET A PASSWORD, THEN ENTER IT. OTHERWISE JUST PRESS ENTER IF THERE NO PASSWORD SET. ONCE IN THE DATABASE SERVER, YOU SHOULD SEE A PROMPT LIKE THIS:
mysql>

TO LIST THE DATABASES, USE THE COMMAND:
show databases;


TO CHOOSE A DATABASE, USE THE COMMAND:
use <database name>;
FOR EXAMPLE, IN CLASS OUR DATABASE WAS, comp3161 , SO WE WOULD TYPE:
use comp3161;

TO EXECUTE A THE SQL SCRIPT WE TYPE:
\. <path to the sql file>

FOR EXAMPLE. IF YOUR FILE IS IN A FOLDER BY THE NAME m ON THE C DRIVE, AND THE NAME OF YOUR FILE IS msbgroup.sql, THEN WE WILL TYPE:
\. C:\m\comp3161.sql

NB: THIS IS ONE TIME THAT WE DO NOT USE A SEMI-COLON TO END THE STATEMENT.

=====================================WINDOWS USERS  USING WAMPP=====================================

WAMPP IS EASIER ALL YOU HAVE TO DO IS CLICK ON WAMPP ICON IN THE TASKBAR THEN: MYSQL -> MySQL Console


=========================================LINUX=========================================================
To install, use the command in the terminal :  sudo apt-get install mysql-server

You should be prompted to put a password. PLEASE remember your password. 
OR DON'T put a password.

The server will be started automatically. To log in mysql server enter the command:

mysql -h localhost -u root -p

YOU WILL BE PROMPTED FOR A PASSWORD:
Enter password:


IF YOU SET A PASSWORD, THEN ENTER IT. OTHERWISE JUST PRESS ENTER IF THERE NO PASSWORD SET. ONCE IN THE DATABASE SERVER, YOU SHOULD SEE A PROMPT LIKE THIS:
mysql>


EXECUTE SCRIPT
\. <path to the sql file>

EXAMPLE:

\. /home/<username>/file.sql

*/

/*===================================== CREATE DATABASE AND SELECT IT ======================*/
create database comp3161;
use comp3161;


/*======================= CREATING TABLES ===================================================*/
create table employee(
	empid int auto_increment not null,
	empfname varchar(20),
	emplname varchar(20),
	emplage int,
	empstreet varchar(50),
	empcity varchar(50),
	primary key(empid) 
);

describe employee;

alter table employee change empid empid varchar(5) not null;  
alter table employee change emplage empage int;
alter table employee add column empstart date after empage;
alter table employee add column empend date after empstart;


create table company(
	companyid varchar(3),
	companyname varchar(20),
	compcity varchar(50),
	primary key(companyid)
);


create table works(
	empid varchar(5),
	companyid varchar(3),
	salary decimal(8,2),
	primary key(empid,companyid),
	foreign key(empid) references employee(empid) on delete cascade on update cascade,
	foreign key(companyid) references company(companyid) on delete cascade on update cascade
);


create table supervise(
  	supervisorid varchar(5),
 	 empid varchar(5),
  	primary key(supervisorid,empid),
  	foreign key (empid) references employee(empid) on delete cascade,
  	foreign key ( supervisorid ) references employee(empid) on delete cascade
);

/*===================== INSERTING VALUES IN TABLES=================================== */
insert into employee (empid,empfname,emplname,empage,empstart,empstreet,empcity) values ('E0000','Shereen','Brown',23,'2009-09-24','chanceberry','Kingston');
insert into employee values ('E0001','Donna','Wilks',45,'2009-09-24','2009-09-25','Novado','Algeris');
insert into employee (empid,empfname,emplname,empage,empstart,empstreet,empcity) values ('E0002','David','Mullings',34,'2007-09-24','Jenkins','Jericho');

insert into company values('C00','Bankers Hill','Jericho');
insert into company values('C01','Financial Servs','Dante');

insert into works values('E0000','C00',45000.00);
insert into works values('E0001','C01',55000.00);
insert into works values('E0002','C00',65000.45);


insert into supervise(supervisorid,empid) values('E0001','E0000');
insert into supervise(supervisorid,empid) values('E0001','E0002');


/*======================== QUERIES ================================*/

/*PERSONS WHO LIVE IN THE SAME CITY AS WHERE THEY WORK*/
/* PLEASE ALSO NOTE THAT YOU SHOULD EXPLICITLY TELL WHICH ATTRIBUTE YOU ARE JOINING ON */
 select distinct empfname,emplname from employee JOIN company JOIN works ON company.companyid=works.companyid and employee.empcity=company.compcity and employee.empid=works.empid;


/* THIS QUERY SHOWS THE EMPLOYEE THAT LIVES IN CITY WHERE COMPANIES ARE. THAT MEANS EVEN IF THEY DONT WORK AT THE COMPANY, THEY WILL BE STILL LISTED */
/* YOU CAN TEST IT BY ENTERING AN EMPLOYEE THAT LIVES IN JERICHO AND WHO DOES NOT EVEN HAVE A WORK ENTRY */
select empfname, emplname from employee join company on empcity=compcity;


/* USING THE LIKE COMMAND WITH WILDCARD % */

select * from employee where  empfname like '%ee%';
select * from employee where emplname like 'M%';



/*  NAME OF SUPERVISORS (DISTINCT IS USED TO RETURN SINGLE PERSON EVEN IF EMPLOYEE SUPERVISES MULTIPLE PERSONS) */
select distinct empfname,emplname from supervise join employee where supervisorid=employee.empid;

/* PERSONS THAT SHOULD START WORKING SOME DATE IN THE FUTURE || ALSO INTRODUCES AS */
select empfname as 'Employee Name' ,emplname from employee where empstart > now(); 


/*THE COMPANY NAME THAT HAVE AN EMPLOYEE WORKING OVER 60,000 */
select companyname from company where
companyid in (select companyid from works where salary > 60000);


/* UPDATE ALL SALARIES BY  3% */
update works set salary=salary*1.03; 

/*UPDATE SALARIES BY 10% UNLESS THE SALARY BECOMES GREATER THAT 65000 THEN UPDATE BY 3 % */

/*USING CASE. YOU CAN HAVE MULTIPLE WHEN STATEMENTS */
update works set salary=
CASE
when (salary*1.1 > 65000) then (salary*1.03)
else (salary*1.1)
END;


/* PATTERN MATCHING FOR STRING VALUE
RETURN IF COMPANY CITY IS A BAD PLACE OR A GOOD PLACE */
 select company as MyCompany,
case compcity
when "Jericho" then "Bad Place"
when "Dante" then "Good Place"
end as "Pattern"
from company;


/* GET THE AVG OF SALARY AT COMPANIES------------WE NORMALLY USE GROUP BY WITH WITH AGGREGATE FUNCTIONS. OTHER FUNCTIONS:(MIN,MAX,COUNT)*/
select companyid,avg(salary) from works group by companyid; 

/* USING THE EXAMPLE ABOVE WITH GROUP BY AND HAVING WITH AVG SALARY GREATER THAN 75000 */
select companyid,avg(salary) from works group by companyid having avg(salary) < 75000;


/* A VIEW IS A VIRTUAL TABLE IT CAN BE QUERIED AND DROPPED ETC. IT IS DYNAMICALLY CREATED FROM SQL QUERY. CHANGES TO THE TABLE WILL BE REFLECTED IN THE VIEW */

create view empResultsView
as
select * from employee;


/* USING THE BETWEEN CONDITIONAL STATEMENT WITH WHERE CLAUSE || BETWEEN IS INCLUSIVE AND 
THE RANGE HAVE TO BE IN THE CORRECT CHRONOLOGICAL ORDER */
select * from employee where empstart between '2007-09-24' and '2009-09-24';



/* ORDER BY THE EMPLOYEE AGE */
 select * from employee order by empage;


/*==============================WEBSITES AND JOINS===============================================*/
  
   -- WEBSITES:   http://www.w3schools.com/sql/default.asp   AND   http://www.tizag.com/sqlTutorial/
      
  --  JOIN:RETURN ROWS WHEN THERRE IS AT LEAST ONE MATCH IN BOTH TABLES
  --  INNER JOIN:(THE SAME AS JOIN) IF THERE ARE R0WS IN TABLE A THAT DO NO MATCH ROWS IN TABLE B THEY ARE LEFT OUT
   -- LEFT JOIN: RETURN ALL ROWS FROM THE LEFT TABLE,EVEN IF THERE ARE NO MATCHES IN THE RIGHT TABLE
   -- RIGHT JOIN: RETURN ALL ROWS FROM THE RIGHT TABLE,EVEN IF THERE ARE NO MATCHES IN THE LEFT TABLE
  --  FULL JOIN:RETURN ROWS WHEN THERE IS A MATCH IN ONE OF THE TABLES
  --   NB:
  --   The FULL JOIN keyword returns all the rows from the left table (eg.Persons(w3schools)),
   --  and all the rows from the right table (eg. Orders(w3schools)). If there are rows in "Persons" that
   --  do not have matches in "Orders", or if there are rows in "Orders" that do not have matches in "Persons",
  --   those rows will be listed as well.
  
