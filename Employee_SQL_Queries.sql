--Drop all table at once
DROP TABLE departments,dept_emp, dept_manager, employees, salaries, titles CASCADE;
---Drop table at a time
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

--Create tables by copying the code from the quickdbdiagram sql site
CREATE TABLE departments (
    dept_no varchar  NOT NULL,
    dept_name varchar  NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no
     )
);

CREATE TABLE dept_emp (
    emp_no int   NOT NULL,
    dept_no varchar   NOT NULL,
    CONSTRAINT pk_dept_emp PRIMARY KEY (
        emp_no, dept_no
     )
);

CREATE TABLE dept_manager (
    dept_no varchar   NOT NULL,
    emp_no int   NOT NULL,
    CONSTRAINT pk_dept_manager PRIMARY KEY (
        emp_no, dept_no
     )
);

CREATE TABLE employees (
    emp_no int   NOT NULL,
    emp_title varchar   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar   NOT NULL,
    last_name varchar   NOT NULL,
    sex varchar   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (
        emp_no
     )
);

CREATE TABLE titles (
    title_id varchar   NOT NULL,
    title varchar   NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (
        title_id
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_title_id" FOREIGN KEY("title_id")
REFERENCES "employees" ("emp_title");

--View tables
SELECT * FROM departments
SELECT * FROM dept_emp
SELECT * FROM dept_manager
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles

-- Analysis
--1. List the following details of each employee: employee number, last name, 
--first name, sex, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
LEFT JOIN salaries as s
	ON e.emp_no = s.emp_no
	ORDER BY e.emp_no;
	
--2.List first name, last name, and hire date for employees 
--who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date;

--3.List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name.

SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments as d
		INNER JOIN dept_manager as dm
		ON d.dept_no = dm.dept_no
			INNER JOIN employees as e
			ON dm.emp_no = e.emp_no;


--4.List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
		INNER JOIN dept_emp as de
		ON e.emp_no = de.emp_no
			INNER JOIN departments as d
			ON de.dept_no = d.dept_no;

--5.List first name, last name, and sex for employees whose first name 
--is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name LIKE 'Hercules'
	AND last_name LIKE 'B%'
	ORDER BY (last_name, first_name);

--6.List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
		INNER JOIN dept_emp AS de
		ON e.emp_no = de.emp_no
			INNER JOIN departments as d
			ON de.dept_no = d.dept_no
			WHERE d.dept_name = 'Sales';


--7.List all employees in the Sales and Development departments, including 
--their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
		INNER JOIN dept_emp AS de
		ON e.emp_no = de.emp_no
			INNER JOIN departments as d
			ON de.dept_no = d.dept_no
			WHERE d.dept_name = 'Sales'
				OR d.dept_name = 'Development'
				ORDER BY (de.emp_no);


--8.In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT last_name,  COUNT(last_name)
FROM employees AS e
	GROUP BY last_name
		ORDER BY last_name DESC;





