-- Write a PL/SQL block to print the total number of employees from the employees 
-- table. 
-- Lab 2: Create a PL/SQL block that calculates the total sales from an orders table.
 DECLARE
   TOTAL_EMPLOYEES NUMBER;
BEGIN
	SELECT count(*) INTO total_employees FROM employees;
	dbms_output.put_line('Total number of employees: '||total_employees);
END;

 -- Write a PL/SQL block using an IF-THEN condition to check the department of an 
-- employee. 
-- Lab 2: Use a FOR LOOP to iterate through employee records and display their names. 
DECLARE
    v_dept VARCHAR2(50);
    v_emp_id NUMBER := 101; -- Example employee ID

BEGIN
    -- Retrieve department of employee
    SELECT department INTO v_dept
    FROM employees
    WHERE emp_id = v_emp_id;

    -- Check department using IF-THEN condition
    IF v_dept = 'HR' THEN
        DBMS_OUTPUT.PUT_LINE('Employee belongs to Human Resources.');
    ELSIF v_dept = 'Finance' THEN
        DBMS_OUTPUT.PUT_LINE('Employee belongs to Finance.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee belongs to another department.');
    END IF;
END;

DECLARE
    CURSOR emp_cursor IS SELECT emp_name FROM employees;
BEGIN
    FOR emp_record IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(emp_record.emp_name);
    END LOOP;
END;
-- Write a PL/SQL block using an explicit cursor to retrieve and display employee details. 
-- Create a cursor to retrieve all courses and display them one by one. 
drop table employees;
CREATE TABLE employees (
   employees_id int PRIMARY KEY,
   employees_name VARCHAR(100),
   department_id int not null
);
INSERT INTO employees VALUES (101, 'Alice', 10);
INSERT INTO employees VALUES (102, 'Bob', 20);
INSERT INTO employees VALUES (103, 'Charlie', 30);
INSERT INTO employees VALUES (104, 'Diana', 40);

select * from employees; 
declare
	employees_id emp.employee_id%type;
    employees_name emp.employee_name%type;
    department_id emp.department_id%type;
cursor emp_cursor is select employees_id, employees_name, department_id from emp;
begin
    dbms_output.put_line(' ----- Employees Details  ------ ');
	open emp_cursor;
    	loop
    		fetch emp_cursor into employees_id, employees_name, department_id;
			exit when emp_cursor%notfound;
			dbms_output.put_line(' Employees id : '||employees_id||'      Employees Name : '||employees_name||'      Department Id : '||department_id);
		end loop;
	close emp_cursor;
end;

create table courses 
(
courses_id  int primary key,
courses_name varchar(25),
courses_credits float not null
);
insert into courses values(101,'Graphic_designer',6);
insert into courses values(102,'Full_stack',7);
insert into courses values(103,'Backend_developer',9);
insert into courses values(104,'Digital_marketing',7);
insert into courses values(105,'Content_creator',8);
insert into courses values(106,'Lead_developer',4);
insert into courses values(107,'Social_media_manager',5);
insert into courses values(108,'Cyber_Security',3);
insert into courses values(109,'Full_stack',4);
insert into courses values(110,'Backend_developer',9);


select * from courses;

declare
	course_id courses.course_id%type;
    course_name courses.course_name%type;
    course_credits courses.course_credits%type;
cursor courses_cursor is select course_id, course_name, course_credits from courses;
begin
    dbms_output.put_line(' ----- Courses Details  ------ ');
	open courses_cursor;
    	loop
    		fetch courses_cursor into course_id, course_name, course_credits;
    			exit when courses_cursor%notfound;
    			dbms_output.put_line(' Courses id : '||course_id||'      Courses Name : '||course_name||'      Courses Credits : '||course_credits);
		end loop;
	close courses_cursor;
end;

 -- Perform a transaction where you create a savepoint, insert records, then rollback to 
-- the savepoint. 
-- Lab 2: Commit part of a transaction after using a savepoint and then rollback the remaining 
-- changes

BEGIN
    INSERT INTO courses (course_id, course_name, course_credits)
    VALUES (111, 'Data Structures', 4);

    INSERT INTO courses (course_id, course_name, course_credits)
        VALUES (112, 'PHP Programming', 3);

    SAVEPOINT before_third_insert;

    INSERT INTO courses (course_id, course_name, course_credits) 
    VALUES (113, 'Artificial Intelligence', 6);

    ROLLBACK TO before_third_insert;

    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Transaction complete. Third insert rolled back.');
END;
BEGIN
    INSERT INTO courses (course_id, course_name, course_credits) 
    VALUES (114, 'Cloud Computing', 5);

    SAVEPOINT first_commit_point;

    INSERT INTO courses (course_id, course_name, course_credits) 
    VALUES (115, 'Cybersecurity', 4);

    COMMIT;

    INSERT INTO courses (course_id, course_name, course_credits) 
    VALUES (116, 'Blockchain Technology', 6);

    ROLLBACK;

    DBMS_OUTPUT.PUT_LINE('First insert committed, second insert rolled back.');
END;



