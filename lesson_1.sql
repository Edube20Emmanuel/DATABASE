ALTER DATABASE myDB READ ONLY = 0;

USE myDB;

create table employees(employee_id int,first_name varchar(50), last_name varchar(50),gender varchar(6),position varchar(50),salary decimal(15,2));

select * from employees

insert into employees
values (1,'Edube','Emma','Male','Data Scientist',20000000),
	   (2,'Oscar','Ondongkara','Male','Network Engineer',21000000),
       (3,'Mukama','Joseph','Male','System Designer',17000000),
       (4,'Kixa','Angella','Female','Front End Designer',16000000),
       (5,'Joy','Awori','Female','Data Analyst',18000000);
       
select * from employees;

## Inser value with missing values
insert into employees(employee_id,first_name,last_name) values(6,'Nsubuga','Emma');

SET SQL_SAFE_UPDATES = 0;

UPDATE employees SET gender = 'Male' WHERE employee_id = 6;

select * from employees;

## Updating multiple missing values at a go
UPDATE employees SET 
	position = 'Bio Engineer',
    salary = 19000000
WHERE employee_id = 6;

select * from employees;

## DELECTING A ROW IN THE TABLE
DELETE FROM employees WHERE employee_id = 3;
select * from employees;