/*DDL -Data defenition language
Create
Alter
drop
truncate
*/

/**********************To create a Database*************************/
create database queries_with_syntax
go
use queries_with_syntax
go
/****************To create a Table*****************************/
/* 
CREATE TABLE TheNameOfYourTable (
	  ID INT NOT NULL IDENTITY(1,1), --pk
	  DateAdded DATETIME DEFAULT(getdate()) NOT NULL,
	  Description VARCHAR(100) NULL,
	  IsGood BIT DEFAULT(0) NOT NULL,
	  TotalPrice MONEY NOT NULL,  
	  CategoryID int NOT NULL REFERENCES Categories(ID),
	  PRIMARY KEY (ID)
	);
*/

CREATE TABLE stud(
Id int identity(1,1),
Name varchar(20),
Course varchar(10),
Location varchar(20),
Age tinyint,
Gender char(1),
fees bigint
);
go

create table temp1(
xxx int,
yyyy char(5),
zzzz varchar(10),
dob date);
go

create table temp2(
i int,
c char(4),
g char(1));
go

--calculated table 
create table calculated_table
(low int,
high int,
myavg as (low+high)/2   --we can have a column with formula
);


/***********Alter**************/

--------------To add a column
/*
Alter table Tablename
add columnname dtype
*/
alter table stud
add temp_col int;
go

alter table stud
add city varchar(20),
state  varchar(50),
country varchar(20);  ---multiple column addition
go
------------To add a auto increment
/*
ALTER TABLE 'tableName'
ADD 'NewColumn' INT IDENTITY(1,1);
*/
alter table stud
add temp_id int identity(1,1);--this wont work coz we already have a pk
go
------------To add a column with computed value
/*
ALTER TABLE dbo.Products
ADD RetailValue AS (QtyAvailable * UnitPrice * 1.5);
*/
alter table stud
add Age_fees as (Age + fees);
go

----------To delete/drop a column
/*
ALTER TABLE table_name
DROP COLUMN column_name;
*/
alter table stud
drop column temp_col;
go
---------To modify a column
/*
ALTER TABLE table_name
ALTER COLUMN column_name column_dtype;
*/
alter table stud
alter column course char(10);
go

/**********Rename***********/
/* Alter doesnt work
sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN';
*/

exec sp_rename 'stud.ID' ,'Roll_no'; --be aware changing pk will change constraint.

/* alter table name
exec sp_rename 'old_table_name', 'new_table_name';
*/

/**************DROP***************************/
/* -deletes the entire table
Drop table tablename
*/
drop table temp1;
go
/**************Truncate******************************/
/*Keeps the structure of the table
Truncate table tablenmae
*/
truncate table temp2;  --use select * or alt+f1 to verify
go
-----------------------------------------------------------------------------------------------------------------------------------------
/*DML - data manipulation language
Insert
update
delete
select - also called as DRL/DSL -->Data Retrieval Language/Data Selection Language
*/

/*************Inserting data to a table**************/
/*
Insert into Tablename
(colum1, col2,....)
values
(val1,val2..),
(val1,val2...);
*/

Insert into stud
(Name, Course,Location, Age,Gender,fees)
values
('Akshay', 'MBA','Pallakad',24,'M',100000),
('Anisha', 'ECE','Chennai',20,'F',1000521),
('Algates', 'ECE','Coimbatore',10,'M',52421),
('Balaji', 'DSP','Pondy',25,'M',54545),
('GokulDheep', 'ECE','Coimbatore',20,'M',1200000),
('Jim', 'ECE','Coimbatore',45,'M',451124),
('Goutham', 'PGPDS','Chennai',25,'M',10101010),
('Pranesh', 'MBA','Coimbatore',25,'M',457896522),
('Rekha', 'PGDM','Chennai',20,'F',47895671),
('Aparna', 'BSC','Thrissur',25,'F',488615474);
go

/******************UPDATE******************************************/
/*
Update tablename
set col1 = val1, col2 =val2
where  condition;
*/
update stud
set name = 'Goutham Flexy', age = 26
where id = 7;
go
/***********************DELETE************************************/
/* -row lvl operation
delete from tablename
where  condition
*/
delete from stud
where id = 0;--u can change the condition
go

delete from stud
where 1 = 1 --deletes all records
go
/**********************SELECT**************************************/
/*
select col1,col2, col3.. or *(to select everything)
from tablename
where condition
groupby col1, col2
order by col1, col2 ,....[asc|desc]

*/

select name, age, course
from stud;
go

select * 
from stud;
go

select *
from stud
where id = 7;
go


select *
from stud
where age >=20
order by age asc, name desc
go

/**advanced
select id,name,age,fees
from stud
where age >20
group by name,age,fees,id  --groupby has to be defined bfr order by
order by name
go
**/
select top(5) ID  --displays top 5 records--similar to limit 
from stud;
go

select top(5)* 
from stud;
go

select * into stud_copy  --creates a copy of student table
from stud;

------To remove duplicate rows
/*
select  distinct * into t2 from t1;
	delete from t1;
	insert into t1 select *  from t2;
	drop table t2;
*/

/*DCL -data control Language
Grant
Revoke
*/

/*TCL -Transcation control language
Commit
rollback
savepoint
*/

/****************************AGGREGATE FN*******************************/
/*
Sum()
AVG()
count()
MAX()
MIN()
*/

select min(Roll_no)
from stud
go

select max(Age)
from stud
go

select sum(Age_fees)
from stud
go

select avg(age)
from stud;
go

select count(Name)
from stud;
go

select len(Name) as lent,Name, Age
from stud;

select len(Name) as lent, Name , Age
from stud
where len(Name) >4;

select max(Roll_no) as max_id, min(Age) as Min_Age
from stud;

/******************************Operators**********************************************************/
/*
=
>,>=
<,<=
<>,!=
Like---> % , _
In-->to specify multiple possible values for a column
between->between an inclusive range
*/

select * 
from stud
where roll_no = 7;
go

select * 
from stud
where roll_no >7;
go

select * 
from stud
where roll_no >=7;
go

select * 
from stud
where roll_no <7;
go

select * 
from stud
where roll_no <= 7;
go

select * 
from stud
where roll_no <> 7;
go

select * 
from stud
where roll_no != 7;
go


/*The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

There are two wildcards used in conjunction with the LIKE operator:

% - The percent sign represents zero, one, or multiple characters

_ - The underscore represents a single character

Examples:

WHERE CustomerName LIKE 'a%' -- Finds any values that starts with "a"
WHERE CustomerName LIKE '%a' -- Finds any values that ends with "a"
WHERE CustomerName LIKE '%or%' -- Finds any values that have "or" in any position
WHERE CustomerName LIKE '_r%' -- Finds any values that have "r" in the second position
WHERE CustomerName LIKE 'a_%_%' -- Finds any values that starts with "a" and are at least 3 characters in length
WHERE ContactName LIKE 'a%o' -- Finds any values that starts with "a" and ends with "o"
*/
select * 
from stud
where name like 'G%'
go

select * 
from stud
where name like '%m'
go

select * 
from stud
where name like '%u%'
go

select * 
from stud
where name like '__m'
go

select * 
from stud
where name like 'G_k%'
go

select * 
from stud
where name like 'R%a'
go
--IN
select * 
from stud
where age in (20,21,25)
go
--between
select * 
from stud
where age between 25 and 30--'and'logical operator(or, and , not)/both limits inclusive
go

/***********************String functions**********************************/
/*
Upper
lower
datalength
len--doesnt count right side empty spaces
ltrim---remove space from left side of string
Rtrim - remove space from right side of string
*/
select upper('goutham') as name_upper_case; 
go

select lower('GOUtham') as name_Lower_case;
go

select datalength('   Goutham   ') as name_with_spaces; --totally there are 13 inc space
go

select len('   Goutham   ') as name_with_spaces; --doesn't count spaces on the right side
go

select ltrim('   Goutham   ') as name_ltrim
go

select ltrim('   Goutham   ') as name_rtrim
go

--to verify above operations
select len(ltrim('   Goutham   '))as name_ltrim  --trims left free space(len doesn't count right side space) but it exists
go

select len(rtrim('   goutham  ')) as name_trim; --trims right spaces
go

/*******Advanced String fn*********/
/* substring --subsets a strings
charindex -return charcter index
concat
reverse
replace  */

/*
SUBSTRING ( expression ,start , length )  
*/
select substring(name , 1 ,4) 
from stud;
go

/*
CHARINDEX ( expressionToFind , expressionToSearch [ , start_location ] )   
*/
select charindex('B','wide ball' ) --not case-sensitive 

select charindex('B','Its wide, because it was a overhead bouncer' ,10)

select substring('Im a monkey',(charindex('monkey','Im a monkey')),6)

/*
CONCAT ( string_value1, string_value2 [, string_valueN ] )  
*/
select concat('Happy', 'birthday') as bday_wish
go

/*
REVERSE ( string_expression )  
*/

select reverse('yxelf') as psn_id;
go

/*
REPLACE ( string_expression , string_pattern , string_replacement )  
*/

select replace('ttteeewww', 'ew', '00');
go

/************Variable Decalration********************/
declare @a int
set @a = 5
select @a 

declare @b int, @c int
set @b = 56 
set @c = 25
select @b + @c
