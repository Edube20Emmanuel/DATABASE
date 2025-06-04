Drop database if exists myDB;

### Creating the database
create database if not exists myDB;

## ALTERING THE DATABASE
alter database myDB read only = 1;
## TRY TO DROP A READ ONLY DATABASE
drop database myDB;

## Changing the db to a read and write database
alter database myDB read only = 0;

## Now drop the database 
drop database myDB;

## Then create the database
create database myDB;

## creating tables i  the database
USE myDB;

create table employees (employee_id int, first_name varchar(50), last_name varchar(50),gendee varchar(7));

## Viewing the db
select * from employees;

## ALTERING A DB
alter table employees add column salary decimal(9, 2);
select * from employees;

# Renaming the columns
alter table employees rename column gendee to gender;
select * from employees;

## Shifting the columns to different places
alter table employees add column position varchar(50) after gender;
select * from employees;

## ADDING MULTIPLE COLUMNS IN TABLE
alter table employees
add column age int,
add column marital_status varchar(50);

select * from employees;

## Modifying multiple columns
alter table employees modify age int, modify marital_status varchar(50) after gender;
select * from employees;

## Moving the columns to gender
alter table employees modify age int after gender;
select * from employees;

## Insertin multiple rows into a table
insert into employees values
	(1, 'Emma','Edube','Male',22,'single','Data Scientist',3000000),
	(2,'Mukama','Joseph','Male',22,'Single','System Admin',1500000),
	(3,'Joy','Florence','Female',20,'Single','Data Analyst',1200000),
	(4,'Najuma','Topista','Female',20,'Married','Network Analyst',1300000),
    (5,'Oscar','Odongkara','Male',26,'Married','Network Engineer',1800000);
    
select * from employees;

## Inserting values with some missing values
insert into employees(employee_id,first_name,last_name,position) values
	(6,'Nsubuga','Emma','Bio Statician');
select * from employees;

-- We shall use the update statement to fill in the missing values
SET SQL_SAFE_UPDATES = 0;
UPDATE employees SET gender = 'Male', age = 27, marital_status = 'Married',salary = 1800000 
WHERE employee_id = 6;
SELECT * FROM employees;

## SELECTING THE DATA FROM THE DATABASE
-- Using the selct statement
SELECT * FROM employees;
-- Selecting specific all the full name of those above 1600000
SELECT first_name, last_name FROM employees WHERE salary >= 1600000;
-- Selecting the non null values
SELECT * FROM employees WHERE salary IS NOT NULL;

-- The not operator
SELECT first_name,last_name FROM employees WHERE employee_id != 4;

SELECT * FROM employees;

## Deleting the data from the database
DELETE FROM employees WHERE employee_id = 1;
SELECT * FROM employees;

-- selecting ithe database
USE myDB;
SELECT * FROM employees WHERE salary != 1800000 AND salary != 1300000;
SELECT first_name,last_name,age,gender FROM employees WHERE salary != 1800000 OR salary != 1300000;