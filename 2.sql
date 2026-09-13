-- ---------- CRUD on TABLE STRUCTURE ----------

-- CREATE
-- CREATE TABLE employees (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     name VARCHAR(100) NOT NULL,
--     age INT,
--     department_id INT,
--     salary INT,
--     manager_id INT,
--     join_date DATE
-- );

-- READ
-- DESC employees;

-- UPDATE

	-- Adding a column
	-- ALTER TABLE employees ADD email VARCHAR(255);
    
    -- Droping a column
    -- ALTER TABLE employees DROP COLUMN email;
    
    -- Modify a column
    -- ALTER TABLE employees MODIFY COLUMN name VARCHAR(200);

	-- Renaming a column
    -- ALTER TABLE employees RENAME COLUMN name TO full_name;



-- DROP and TRUNCATE
	-- {delete will remove entries as well as the entire schema but truncate will only remove the entries}
	-- DROP
	-- DROP TABLE employees;

	-- TRUNCATE
	-- TRUNCATE TABLE employees;


-- RENAME
-- RENAME TABLE employees TO sales_employees;


-- List down all the tables
-- Show tables;









-- ---------- CRUD on ROW DATA ----------

-- CREATE
-- INSERT INTO employees (id, name, age, department_id, salary, manager_id, join_date)
-- VALUES (11, 'Test User', 30, 1, 60000, NULL, '2024-01-01');

-- READ
-- SELECT * FROM employees;

-- UPDATE
-- UPDATE employees SET salary = 65000 WHERE id = 11;

-- DELETE
-- DELETE FROM employees WHERE id = 11;
-- ============================================================


-- ===== DATABASE: create once, then just USE it every session =====
CREATE DATABASE IF NOT EXISTS temp;
USE temp;


-- ===== RESET: safe to re-run any time =====
DROP TABLE IF EXISTS employee_projects;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;


-- ===== BASELINE SETUP =====

-- 1. Departments
CREATE TABLE departments (
    id MEDIUMINT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) UNIQUE NOT NULL,
    location VARCHAR(100)
);

INSERT INTO departments (id, department_name, location) VALUES
(1, 'Engineering', 'Bangalore'),
(2, 'Sales', 'Mumbai'),
(3, 'HR', 'Delhi'),
(4, 'Marketing', 'Pune'),
(5, 'Finance', 'Chennai');

-- 2. Employees
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT,
    department_id INT,
    salary INT,
    manager_id INT,
    join_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL,
    -- ^ if a department is deleted, its employees survive with department_id = NULL
    FOREIGN KEY (manager_id) REFERENCES employees(id) ON DELETE SET NULL
);

INSERT INTO employees (id, name, age, department_id, salary, manager_id, join_date) VALUES
(1, 'Shivam', 29, 1, 85000, NULL, '2019-03-12'),
(2, 'Kashish', 27, 1, 72000, NULL, '2020-07-01'),
(3, 'Rahul', 34, 1, 95000, NULL, '2017-01-15'),
(4, 'Priya', 31, 2, 68000, NULL, '2018-05-20'),
(5, 'Arjun', 26, 2, 55000, NULL, '2021-09-10'),
(6, 'Neha', 40, 3, 60000, NULL, '2015-11-03'),
(7, 'Aman', 24, NULL, 45000, NULL, '2022-02-18'),
(8, 'Divya', 29, 4, 58000, NULL, '2019-08-25'),
(9, 'Karan', 35, 1, 91000, NULL, '2016-04-30'),
(10, 'Simran', 27, 2, 62000, NULL, '2020-12-01');

-- manager_id set separately so the self-reference has something to point to
UPDATE employees SET manager_id = 1 WHERE id IN (2, 3, 9);
UPDATE employees SET manager_id = 4 WHERE id IN (5, 10);

-- 3. Projects
CREATE TABLE projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(150) NOT NULL,
    budget INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE
    -- ^ if a department is deleted, its projects are deleted too
);

INSERT INTO projects (id, project_name, budget, department_id) VALUES
(1, 'Payment Gateway', 500000, 1),
(2, 'Mobile App', 300000, 1),
(3, 'Ad Campaign Q3', 150000, 4),
(4, 'CRM Revamp', 200000, 2),
(5, 'Internal Wiki', 50000, 3);

-- 4. Which employee works on which project (many-to-many)
CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

INSERT INTO employee_projects (emp_id, project_id) VALUES
(1, 1), (1, 2),
(2, 1),
(3, 2),
(4, 4),
(5, 4),
(6, 5),
(8, 3),
(9, 1), (9, 2),
(10, 4);
