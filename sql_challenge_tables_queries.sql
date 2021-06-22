create table departments(
	dept_no varchar primary key not null,
	dept_name varchar not null
);

COPY departments(dept_no, dept_name)
FROM 'C:\Users\nmack\Desktop\sql_challenge\departments.csv'
DELIMITER ','
CSV HEADER;

select * from departments

create table dept_manager(
	dept_no varchar not null,
	emp_no int not null
);

COPY dept_manager(dept_no, emp_no)
FROM 'C:\Users\nmack\Desktop\sql_challenge\dept_manager.csv'
DELIMITER ','
CSV HEADER;

select * from dept_manager

create table dept_emp(
	emp_no int not null,
	dept_no varchar not null
);

COPY dept_emp(emp_no, dept_no)
FROM 'C:\Users\nmack\Desktop\sql_challenge\dept_emp.csv'
DELIMITER ','
CSV HEADER;

select * from dept_emp

create table employees(
	emp_no int not null,
	emp_title_id varchar not null,
	birth_date date not null,
	first_name varchar not null,
	last_name varchar not null,
	sex varchar not null,
	hire_date date not null
);

COPY employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM 'C:\Users\nmack\Desktop\sql_challenge\employees.csv'
DELIMITER ','
CSV HEADER;

select * from employees

create table salaries(
	emp_no int not null,
	salary int not null
);

COPY salaries(emp_no, salary)
FROM 'C:\Users\nmack\Desktop\sql_challenge\salaries.csv'
DELIMITER ','
CSV HEADER;

select * from salaries

create table titles(
	title_id varchar not null,
	title varchar 
);

COPY titles(title_id, title)
FROM 'C:\Users\nmack\Desktop\sql_challenge\titles.csv'
DELIMITER ','
CSV HEADER;

select * from titles

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.

select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
Inner Join salaries on employees.emp_no=salaries.emp_no

--2. List first name, last name, and hire date for employees who were hired in 1986.

select * from employees where hire_date >= '1986/01/01'

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

select employees.emp_no, employees.last_name, employees.first_name, employees.emp_title_id, dept_manager.dept_no
from employees
Inner Join dept_manager on employees.emp_no=dept_manager.emp_no

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no
from employees
Inner Join dept_emp on employees.emp_no=dept_emp.emp_no

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

select employees.last_name, employees.first_name, employees.sex
from employees
where (first_name = 'Hercules' AND last_name like 'B%')

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no
from employees
Inner Join dept_emp on employees.emp_no=dept_emp.emp_no
where dept_no = 'd007'

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no
from employees
Inner Join dept_emp on employees.emp_no=dept_emp.emp_no
where (dept_no = 'd007' OR dept_no = 'd005')

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

Select employees.last_name, count(*)
From employees
Group By employees.last_name
Order By count desc;
