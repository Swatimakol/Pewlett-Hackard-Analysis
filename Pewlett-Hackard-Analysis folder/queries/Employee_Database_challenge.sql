-- Creating first tables for all the departments

CREATE TABLE Departments (
dept_no VARCHAR(4) NOT NULL,
dept_name VARCHAR(40) NOT NULL,
PRIMARY KEY(dept_no),
UNIQUE(dept_name)
);

--- Creating a second table for employees

CREATE TABLE Employees (
emp_no INT NOT NULL,
birth_date DATE NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
gender VARCHAR(100) NOT NULL,
hire_date DATE not null,
PRIMARY KEY(emp_no)
);



--- Third table for department managers using forgien keys

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
);


--- Fourth table for salaries
CREATE TABLE dept_emp (
emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
);

--- Fifth table for Department employees
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

--- Sixth table for Titles of employess;
DROP TABLE title CASCADE;
CREATE TABLE title (
  emp_no INT NOT NULL,
  title VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  PRIMARY KEY (emp_no, title, from_date)
);

--- Visualizing all tables

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM title;
SELECT * FROM dept_emp;

-------------------------------------


------------- ASSIGNMENT ------------
------------  DELEVERABLE 1 ---------


-------------------------------------

DROP TABLE retirement_titles;
SELECT e.emp_no, e.first_name, e.last_name,
ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN title AS ti
ON e.emp_no = ti.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
DROP TABLE unique_titles;
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;

SELECT * FROM unique_titles;


----- Store title Count
DROP TABLE store_count;
SELECT COUNT(title), title
INTO store_count
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM store_count;

---------- Deliverale 2------
DROP TABLE mentor_eligibilty;
SELECT DISTINCT ON(e.emp_no)e.emp_no, e.first_name, e.last_name,
de.from_date, de.to_date,
ti.title
INTO mentor_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN title AS ti ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

SELECT * FROM mentor_eligibilty;











