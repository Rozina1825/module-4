-- Lab 1: Create a new database named school_db and a table called students with the 
-- following columns: student_id, student_name, age, class, and address. 
-- Lab 2: Insert five records into the students table and retrieve all records using the SELECT 
-- statement. 
create schema school_db;

create table student
(
student_id int not null unique,
student_name varchar(25) not null,
age int not null,
class varchar(25) not null ,
address varchar(25) not null 
);

insert into student value(1,'rozina',14,8,'saudi arabia'),
(2,'mehrin',15,9,'chicgo'),
(3,'kammo',17,12,'egypt'),
(4,'amrin',13,7,'spain'),
(5,'sana',17,12,'Turkey');

drop table student;

drop table student;
drop schema school_db;

select student_name,age from student;
-- Lab 1: Create a table teachers with the following columns: teacher_id (Primary Key), 
-- teacher_name (NOT NULL), subject (NOT NULL), and email (UNIQUE). 
-- Lab 2: Implement a FOREIGN KEY constraint to relate the teacher_id from the 
-- teachers table with the students table. 

create table teachers
(
teacher_id int primary key,
teacher_name varchar(25) not null,
subject varchar(25) not null,
email varchar(25) unique
);

CREATE TABLE students 
(
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id)
);

select*from teachers;
select*from students;
-- Lab 1: Create a table courses with columns: course_id, course_name, and 
-- course_credits. Set the course_id as the primary key. 
-- Lab 2: Use the CREATE command to create a database university_db. 

create table course

(
course_id int primary key,
course_name varchar(25) not null,
course_credits float not null
);

create schema university_db
-- Lab 1: Modify the courses table by adding a column course_duration using the ALTER 
-- command. 
-- Lab 2: Drop the course_credits column from the courses table.

alter table  course add column course_duration int  not null;

alter table course drop course_credits;

-- Drop the teachers table from the school_db database. 
-- Drop the students table from the school_db database and verify that the table has 
-- been removed. 

drop table school_db.students;
drop table school_db.teachers;

-- Insert three records into the courses table using the INSERT command. 
-- Update the course duration of a specific course using the UPDATE command. 
-- Delete a course with a specific course_id from the courses table using the DELETE 
-- command.
 
insert into course value(1,'Bba','4');
insert into course value(2,'Bsc','3');
insert into course value(3,'Btech','3');


update course set course_duration = '5 'where course_id = 2;

delete from course where course_id = 3;

-- Retrieve all courses from the courses table using the SELECT statement. 
-- Sort the courses based on course_duration in descending order using ORDER BY. 
-- Limit the results of the SELECT query to show only the top two courses using LIMIT. 

select * from course;
select * from course order by course_duration desc;
select * from course order by course_duration desc limit 2;

-- Create two new users user1 and user2 and grant user1 permission to SELECT 
-- from the courses table. 
-- Revoke the INSERT permission from user1 and give it to user2. 

create user user1 identified by'password1';
create user user2 identified by 'password2';
use school_db;
grant select on course to user1;

-- Insert a few rows into the courses table and use COMMIT to save the changes. 
-- Insert additional rows, then use ROLLBACK to undo the last insert operation. 
-- Create a SAVEPOINT before updating the courses table, and use it to roll back 
-- specific changes. 
select * from course;
insert into course value (4, 'Data Science Basics', '6 ');
insert into course value(5, 'Cloud Computing', '5 ');
COMMIT;
select * from course; 
insert into course value(6, 'Cybersecurity', '4 ');
ROLLBACK;
-- Create two tables: departments and employees. Perform an INNER JOIN to 
-- display employees along with their respective departments. 
-- Lab 2: Use a LEFT JOIN to show all departments, even those without employees. 

create table department
(
department_id int primary key,
department_name varchar(25)
);

insert into department value (1,'HR');
insert into department value (2,'finance');
insert into department value (3,'IT');
select*from department;

create table employees
(
    employees_id int primary key,
    employees_name varchar(100),
    employees_salary int not null,
    department_id int,
    foreign key (department_id) references department(department_id)
);

insert into employees value (101,'alex',1);
insert into employees value (102,'finny',2);
insert into employees value (103,'anna',3);
select*from employees;

insert into employees values(101,'alex',30.000,1);
insert into employees values(102,'finny',21.000,2);
insert into employees values(103,'ana',15.000,2);

select employees.employees_name, department.department_name
from employees
INNER JOIN department ON employees.department_id = department.department_id;

SELECT department.department_name, employees.employees_name
FROM department
LEFT JOIN employees ON department.department_id = employees.department_id;

-- Group employees by department and count the number of employees in each 
-- department using GROUP BY. 
-- Lab 2: Use the AVG aggregate function to find the average salary of employees in each 
-- department. 

select department_id ,count(*) as employees_count from employees group by department_id;

ALTER TABLE employees ADD COLUMN employees_salary DECIMAL(10,2);

update employees set employees_salary = 20000 where employees_id = 101;
update employees set employees_salary = 10000 where employees_id = 102;
update employees set employees_salary = 25000 where employees_id = 103;
update employees set employees_salary = 15000 where employees_id = 104;
select * from employees;

select department_id, avg(employees_salary) as average_salary from employees group by department_id;

-- Lab 1: Write a stored procedure to retrieve all employees from the employees table based
-- on department.
-- Lab 2: Write a stored procedure that accepts course_id as input and returns the course
-- details
DELIMITER $$

CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(50))
BEGIN
    SELECT * FROM employees WHERE department = dept_name;
END $$

DELIMITER ;
 -- Create a view to show all employees along with their department names. 
--  Modify the view to exclude employees whose salaries are below $50,000. 

CREATE TABLE employees (
    employees_id INT PRIMARY KEY,
    employees_name VARCHAR(100),
    department_names VARCHAR(100),
    employees_salary DECIMAL(10,2)
);
CREATE VIEW EmployeesDepartmentView AS
SELECT employees_id, employees_name, department_names, employees_salary
FROM employees;

create table department
(
department_id int primary key,
department_name varchar(25)
);
DROP VIEW EmployeesDepartmentView;
DESC employees;

CREATE VIEW EmployeesDepartmentView AS
SELECT employees_id, employees_name, department_names, employees_salary
FROM employees
WHERE employees_salary >= 50000;
SELECT * FROM EmployeesDepartmentView;
















