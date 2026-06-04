-- Create Department Table
CREATE TABLE dept (
    dept_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Create Employee Table
CREATE TABLE emp (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT,
    salary DECIMAL(10, 2),
    dept_id INT,
    hire_date DATE
    
);

-- Create Project Table
CREATE TABLE pro (
    project_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    dept_id INT
);

-- Insert values into Department Table
INSERT INTO dept (dept_id, name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

-- Insert values into Employee Table
INSERT INTO emp (emp_id, name, age, salary, dept_id, hire_date) VALUES
(1, 'John Doe', 28, 50000.00, 1, '2020-01-15'),
(2, 'Jane Smith', 34, 60000.00, 2, '2019-07-23'),
(3, 'Bob Brown', 45, 80000.00, 1, '2018-02-12'),
(4, 'Alice Blue', 25, 45000.00, 3, '2021-03-22'),
(5, 'Charlie P.', 29, 50000.00, 2, '2019-12-01');

-- Insert values into Project Table
INSERT INTO pro (project_id, name, dept_id) VALUES
(1, 'Project Alpha', 1),
(2, 'Project Beta', 2),
(3, 'Project Gamma', 1),
(4, 'Project Delta', 3),
(5, 'Project Epsilon', 4);
-- Q1: Display each employee along with the average salary of all employees.

SELECT name,
       salary,
       AVG(salary) OVER() AS avg_salary
FROM emp;

-- Q2: Show each employee along with the average salary of their department.

SELECT name,
       salary,
       AVG(salary) OVER(PARTITION BY dept_id) AS avg_salary
FROM emp;

-- Q3: Assign row numbers to employees based on salary in descending order.

SELECT name,
       salary,
	   ROW_NUMBER() OVER(ORDER BY salary DESC) as rn
       FROM emp ;

-- Q4: Rank employees based on salary using RANK().

SELECT name,
       salary,
	   RANK() OVER(ORDER BY salary DESC) as rn
       FROM emp ;

-- Q5: Rank employees based on salary using DENSE_RANK().

SELECT name,
       salary,
	   DENSE_RANK() OVER(ORDER BY salary DESC) as rn
       FROM emp ;

-- Q6: Find the highest-paid employee in each department.

SELECT name,
       salary,dept_id,
	   MAX(salary) OVER(PARTITION BY dept_id ORDER BY salary DESC) as rn
       FROM emp ;

-- Q7: Find the top 3 highest-paid employees in each department.

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) rn
    FROM emp
)
SELECT *
FROM cte
WHERE rn <= 3;

-- Q8: Show the difference between an employee's salary and their department's average salary.

SELECT *,
	   salary- AVG(salary) OVER(PARTITION BY dept_id ) as diff  
       FROM emp ;

-- Q9: Show each employee's salary as a percentage of their department's total salary expenditure.

SELECT *,
		ROUND(salary*100/SUM(salary) OVER (PARTITION BY dept_id) ,2) AS result
        FROM emp ;

-- Q10: Find the lowest-paid employee in each department.
	
WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY dept_id
               ORDER BY salary
           ) rn
    FROM emp
)
SELECT *
FROM cte
WHERE rn = 1;

-- Q11: Display each employee along with the salary of the employee hired immediately before them.
-- Order by hire_date.

SELECT *,
	   LAG(salary) OVER(ORDER BY hire_date) as prev_salary 
       FROM emp ;

-- Q12: Display each employee along with the salary of the employee hired immediately after them.
-- Order by hire_date.

SELECT *,
	   LEAD(salary) OVER(ORDER BY hire_date) as prev_salary 
       FROM emp ;

-- Q13: Show salary growth compared to the previously hired employee.
-- (Current Salary - Previous Salary)

SELECT *,salary-
	   LAG(salary) OVER() as diff 
       FROM emp ;

-- Q14: Find employees whose salary is greater than the salary of the previously hired employee.
WITH cte AS (
SELECT *,salary-
	   LAG(salary) OVER() as diff 
       FROM emp 
  )
SELECT * 
FROM cte 
WHERE salary > diff ;

-- Q15: Calculate a running total of salaries based on hire_date.

SELECT *,
       SUM(salary)
       OVER(ORDER BY hire_date) AS running_total
FROM emp;

-- Q16: Calculate a running average salary based on hire_date.

SELECT *,
       AVG(salary)
       OVER(ORDER BY hire_date) AS running_total
FROM emp;

-- Q17: Calculate the cumulative salary paid within each department.
-- Order by hire_date within each department.

SELECT *,
       SUM(salary)
       OVER(
           PARTITION BY dept_id
           ORDER BY hire_date
       ) AS cumulative_salary
FROM emp ;

-- Q18: Rank departments based on their total salary expenditure.
-- Use window functions wherever possible.

WITH cte AS 
	( SELECT dept_id,SUM(salary) total_sal
     FROM emp
     GROUP BY dept_id )
SELECT *,RANK() OVER(ORDER BY total_sal ) AS rn
FROM cte ;

-- Q19: Divide all employees into 4 salary buckets using NTILE().
-- Highest salaries should belong to Bucket 1.

SELECT *,
       NTILE(4)
       OVER(ORDER BY salary DESC) bucket
FROM emp ;

-- Q20: Find the second-highest salary employee in every department.

WITH cte AS (
  SELECT *,
  		DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) as ds
  		FROM emp )
SELECT *
FROM cte
WHERE ds =2 ;
