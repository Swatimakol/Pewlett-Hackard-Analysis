-- Creating tables for PH employees
CREATE TABLE Departments (
dept_no VARCHAR(4) NOT NULL,
dept_name VARCHAR(40) NOT NULL,
PRIMARY KEY(dept_no),
UNIQUE(dept_name)
);

--- Creating a second table 

CREATE TABLE Employees (
emp_no INT NOT NULL,
birth_date DATE NOT NULL,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
gender VARCHAR(100) NOT NULL,
hire_date DATE not null,
PRIMARY KEY(emp_no)

);



--- Thirda table using foreign keys

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
);

-- Another table 
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

--- title table 
DROP TABLE title CASCADE;
CREATE TABLE title (
  emp_no INT NOT NULL,
  title VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  PRIMARY KEY (emp_no, title, from_date)
);

-- Department employees table 

CREATE TABLE dept_emp (
emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM employees;
SELECT * FROM title;

--------------------------

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';


-- CHCEK FOR RETIREMENT CRITERIA

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--- TO COUNT THE RETIRING PEOPLE
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- CREATE A NEW TABLE FROM EXISTING ONE

DROP TABLE retirement_info;
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
INTO new_table
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no;

SELECT * FROM new_table;

-------------Assignment

--- retrive emp_no, first_name, and last_name and place it new table

SELECT emp_no, first_name, last_name
INTO intial_info
FROM employees;

---- test the table
SELECT * FROM intial_info;


----- Left join title table and intial_info
DROP TABLE retirement_titles CASCADE;
SELECT i.emp_no, i.first_name, i.last_name, 
ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM intial_info AS i
FULL JOIN title AS ti
ON i.emp_no = ti.emp_no;

SELECT * FROM retirement_titles;

---- Next past of challenge

---- retrive data from retirement_tiltles into enw table

SELECT emp_no, first_name, last_name, title
INTO new_data
FROM retirement_titles;

-- Test the new table
SELECT * FROM new_data;

---- new try deliverable 1
DROP TABLE test_table;
SELECT e.emp_no, e.first_name, e.last_name,
ti.title, ti.from_date, ti.to_date
INTO test_table
FROM employees AS e
INNER JOIN title AS ti
ON e.emp_no = ti.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

SELECT * FROM test_table;

-- Use Dictinct with Orderby to remove duplicate rows
DROP TABLE nameyourtable;
SELECT DISTINCT ON (tt.emp_no) tt.emp_no,
tt.first_name,
tt.last_name,
tt.title
INTO nameyourtable
FROM test_table AS tt
ORDER BY tt.emp_no ASC, tt.to_date DESC;

SELECT * FROM nameyourtable;


---- tryin it out
DROP TABLE unique_title;
SELECT ny.emp_no,
ny.first_name, 
ny.last_name,
ny.title,
rt.to_date
INTO unique_title
FROM nameyourtable AS ny
INNER JOIN retirement_titles AS rt
ON ny.emp_no = rt.emp_no
ORDER BY rt.to_date DESC;

SELECT * FROM unique_title;


-------
DROP TABLE store_count;
SELECT COUNT(title), title
INTO store_count
FROM unique_title
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









