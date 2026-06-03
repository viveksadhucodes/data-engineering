-- Q1: Create a CTE that returns all employees and display its contents.

WITH cte AS (
  SELECT * FROM emp ) 
SELECT * from cte ;

-- Q2: Create a CTE that returns employees with salary greater than 50000.

WITH cte AS ( SELECT * FROM emp WHERE salary > 50000 ) 
SELECT * FROM cte ;

-- Q3: Create a CTE that returns employees hired after '2023-01-01'.

WITH cte AS (
  SELECT * FROM emp WHERE hire_date > '2023-01-01' )
SELECT * FROM cte ;

-- Q4: Using a CTE, find the total number of employees.

WITH cte AS ( SELECT COUNT(*) FROM emp ) 
SELECT * FROM cte ; 

-- Q5: Using a CTE, find the average salary of all employees.

WITH avg_sal AS (
    SELECT AVG(salary) AS avg_salary
    FROM emp
)
SELECT *
FROM avg_sal;

-- Q6: Using a CTE, calculate the total salary expenditure of each department.

WITH cte AS ( SELECT AVG(salary) FROM emp GROUP BY dept_id  ) 
SELECT * FROM cte ;

-- Q7: Using a CTE, find departments whose total salary expenditure exceeds 50000.

WITH cte AS (SELECT AVG(salary) as avg_sal FROM emp GROUP BY dept_id HAVING avg_sal > 50000 ) 
SELECT * FROM cte ;

-- Q8: Using a CTE, find employees earning more than the company average salary.

WITH avg_sal AS (
    SELECT AVG(salary) AS avg_salary
    FROM emp
)
SELECT *
FROM emp
WHERE salary > (SELECT avg_salary FROM avg_sal);