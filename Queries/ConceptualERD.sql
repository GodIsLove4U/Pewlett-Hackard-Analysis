Departments
-
dept_no int pk FK >- Dept_Emp.dept_no
dept_name varchar

Dept_Emp
-
emp_no int pk FK >- Employees.emp_no
dept_no pk
from_date date
to_date date

Employees
-
emp_no int pk FK >- Salaries.emp_no
birth_date date
first_name varchar
last_name varchar
gender varchar
hire_date date

Dept_Manager
-
dept_no int FK >- Departments.dept_no
emp_no int fk - Employees.emp_no
from_date date
to_date date

Titles
-
emp_no int pk FK >- Employees.emp_no
title varchar pk
from_date date
to_date date

Salaries
-
emp_no int pk FK >- Titles.emp_no
salary varchar
from_date date
to_date date