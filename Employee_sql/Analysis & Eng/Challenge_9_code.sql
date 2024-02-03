--Creating tables for EmployeeSQL
CREATE TABLE departments (
    dept_no VARCHAR(100) NOT NULL,
    dept_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (dept_no)
);

CREATE TABLE title (
    title_id VARCHAR(100) NOT NULL,
    title VARCHAR(255) NOT NULL,
    PRIMARY KEY (title_id)
);

CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no)
);

CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(100) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR(100) NOT NULL,
    emp_no INT NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


------- CSV manually uploaded to PG

-- Question 1
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

-- Question 2
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- Question 3
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager dm
JOIN departments d ON dm.dept_no = d.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

-- Question 4 
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no;

-- Question 5
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- Question 6
SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- Question 7
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- Question 8
SELECT last_name, COUNT(*) as frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
