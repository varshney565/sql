-- ============================================================
-- TOPIC: DQL — WHERE (filtering rows)
-- (all SELECTs — 100% safe, all live)
-- ============================================================
 
-- Basic condition
SELECT * FROM employees WHERE age > 30;
 
 
 
-- ============================================================
-- TOPIC: DQL — AS (aliasing)
-- ============================================================
 
-- Column alias — just a cleaner header on the result
SELECT name AS employee_name, salary AS monthly_pay FROM employees;
 
-- Table alias — "e" now stands in for "employees" for the rest of the query
SELECT e.name, e.salary FROM employees AS e WHERE e.salary > 80000;
 
 
 
 
 
-- BETWEEN (range, inclusive both ends)
SELECT name, age FROM employees WHERE age BETWEEN 27 AND 31;








 
-- IN (avoids stacking ORs)
SELECT * FROM employees WHERE department_id IN (1, 3);








 
-- AND / OR / NOT
	-- AND
	SELECT * FROM employees WHERE department_id = 1 AND salary > 80000;
 
	-- OR
	SELECT * FROM employees WHERE department_id = 1 OR department_id = 3;
 
	-- NOT IN
	SELECT name, department_id FROM employees WHERE department_id NOT IN (1, 2);
    
    
    
    
    
    
 
-- IS NULL (the only correct way to check for missing values)
SELECT name FROM employees WHERE department_id IS NULL;
 
 
 
 
 
 
 
 
 
-- ============================================================
-- TOPIC: DQL — LIKE (pattern matching)
-- % = any number of characters | _ = exactly one character
-- (all SELECTs — 100% safe, all live)
-- ============================================================
 
-- Starts with a specific letter
SELECT name FROM employees WHERE name LIKE 'A%';
 
-- Ends with a specific letter
SELECT name FROM employees WHERE name LIKE '%a';
 
-- Contains a substring anywhere in the middle
SELECT name FROM employees WHERE name LIKE '%an%';
 
-- Second character is a specific letter
SELECT name FROM employees WHERE name LIKE '_i%';
 
-- Exact length match
SELECT name FROM employees WHERE name LIKE '____';
 
-- Starts with a letter AND is an exact length
SELECT name FROM employees WHERE name LIKE 'S_____';
 
-- NOT LIKE — the opposite match
SELECT name FROM employees WHERE name NOT LIKE 'A%';
 
-- Combine LIKE with another condition
SELECT name, salary FROM employees WHERE name LIKE '%a' AND salary > 60000;
 
 
 
 
 
 
 
 
-- ============================================================
-- TOPIC: DQL — SELECT (the basics)
-- ============================================================
 
-- All columns
SELECT * FROM employees;
 
-- Specific columns
SELECT name, salary FROM employees;
 
-- SELECT without FROM — useful for quick tests
SELECT 4 * 2;
SELECT NOW();
 
 
 
 
 
 
 
 
 
-- ============================================================
-- TOPIC: DQL — ORDER BY (sorting)
-- ============================================================
 
-- Ascending (default — don't need to write ASC)
SELECT name, salary FROM employees ORDER BY salary;
 
-- Descending
SELECT name, salary FROM employees ORDER BY salary DESC;








-- ============================================================
-- TOPIC: DQL — LIMIT (cutting a result down to N rows)
-- ============================================================
 
-- Top 3 highest earners
SELECT name, salary FROM employees ORDER BY salary DESC LIMIT 3;
-- Result: Rahul (95000), Karan (91000), Shivam (85000)
 
-- LIMIT with an offset — skip the first N, then take the next M
-- syntax: LIMIT offset, count
SELECT name, salary FROM employees ORDER BY salary DESC LIMIT 1, 1;
-- Result: skips Rahul (rank 1), returns Karan — the 2nd highest earner










 
 
-- ============================================================
-- TOPIC: DQL — DISTINCT (unique values only)
-- ============================================================
 
SELECT DISTINCT department_id FROM employees;
-- Result: 1, 2, 3, 4, NULL — 5 distinct values. NULL counts as its own value.
 
 
 
 
 
 
 
 
 
 
 
-- ============================================================
-- TOPIC: DQL — GROUP BY
-- ============================================================
 
-- How many employees per department
SELECT department_id, COUNT(*) AS num_employees
FROM employees
GROUP BY department_id;
-- Result: dept 1 -> 4, dept 2 -> 3, dept 3 -> 1, dept 4 -> 1, NULL -> 1
 
-- Average salary per department
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;
-- Result: dept 1 -> 85750.00, dept 2 -> 61666.67, dept 3 -> 60000.00, dept 4 -> 58000.00
 
 
 
-- Q1: total salary paid out per department
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;
 
 
 
 
-- Q2: oldest employee's age in each department
SELECT department_id, MAX(age) AS oldest_age
FROM employees
GROUP BY department_id;
 
-- Q3: WHERE + GROUP BY together.
-- Average salary per department, counting only employees older than 27.
-- Notice the NULL department group disappears here — Aman is 24,
-- so WHERE removes him BEFORE grouping ever happens.
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
WHERE age > 27
GROUP BY department_id;









-- ============================================================
-- TOPIC: DQL — Aggregate functions WITHOUT GROUP BY
-- Without GROUP BY, an aggregate collapses the ENTIRE table into
-- one single row — not one row per department, just one row, period.
-- ============================================================
 
-- Highest salary in the whole company (one number, no grouping)
SELECT MAX(salary) FROM employees;
-- Result: 95000
 
-- A few aggregates together, still just one row back
SELECT COUNT(*) AS total_employees, AVG(salary) AS company_avg_salary, MIN(age) AS youngest
FROM employees;
 
 
 
 
 
 
 
 
 

 
-- ============================================================
-- TOPIC: DQL — HAVING (filtering groups, after GROUP BY)
-- ============================================================
 
-- Departments with more than 1 employee
SELECT department_id, COUNT(*) AS num_employees
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 1;
-- Result: only dept 1 (4 employees) and dept 2 (3 employees) survive
 
-- Q: departments where total salary paid exceeds 150000
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 150000;

