DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

CREATE TABLE departments(
	dept_no character varying(45) NOT NULL,
	dept_name character varying(45) NOT NULL
);

CREATE TABLE dept_emp(
	emp_no integer NOT NULL,
	dept_no character varying(6) NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL
);

CREATE TABLE dept_manager(
	dept_no character varying(6) NOT NULL,
	emp_no integer NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL
);

CREATE TABLE employees(
	emp_no integer NOT NULL,
	birth_date date NOT NULL,
	first_name character varying(45) NOT NULL,
	last_name character varying(45) NOT NULL,
	gender character varying(1) NOT NULL,
	hire_date date NOT NULL
);


CREATE TABLE salaries(
	emp_no integer NOT NULL,
	salary numeric(10,2) NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL
);


CREATE TABLE titles(
	emp_no integer NOT NULL,
	title character varying(45) NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL
);

---1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees e
LEFT JOIN salaries s
ON s.emp_no = e.emp_no;

---***2. List employees who were hired in 1986.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, e.hire_date
FROM employees e
WHERE EXTRACT (YEAR FROM e.hire_date) = 1986;

---3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT dm.dept_no, d.dept_name, dm.emp_no,e.first_name, e.last_name, dm.from_date, dm.to_date
FROM dept_manager dm
LEFT JOIN departments d
ON dm.dept_no = d.dept_no
LEFT JOIN employees e
ON dm.emp_no = e.emp_no;

---***4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name, 
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON de.dept_no = d.dept_no;

---5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employees e
WHERE e.first_name = 'Hercules'
AND e.last_name LIKE 'B%';

---***6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees e 
JOIN dept_emp de
ON (e.emp_no = de.emp_no)
JOIN departments d
ON (de.dept_no = d.dept_name)
WHERE d.dept_name = 'Sales';

---***7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN dept_emp de
ON (e.emp_no = de.emp_no)
JOIN departments d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

---8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT e.last_name, COUNT (e.last_name) AS "Last Name Count"
FROM employees e
GROUP BY e.last_name
ORDER BY "Last Name Count" DESC;

