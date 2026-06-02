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