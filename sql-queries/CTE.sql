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

-- Q9: Using a CTE, find employees earning more than their department average salary.

WITH dept_avg AS (
    SELECT dept_id,
           AVG(salary) AS avg_salary
    FROM emp
    GROUP BY dept_id
)
SELECT e.*
FROM emp e
JOIN dept_avg d
ON e.dept_id = d.dept_id
WHERE e.salary > d.avg_salary;

-- Q10: Using a CTE, find the highest-paid employee in each department.

WITH ranked_emp AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) rn
    FROM emp
)
SELECT *
FROM ranked_emp
WHERE rn = 1;

-- Q11: Using a CTE and ROW_NUMBER(), find the second-highest-paid employee in each department.

WITH ranked_emp AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) rn
    FROM emp
)
SELECT *
FROM ranked_emp
WHERE rn = 2;

-- Q12: Using a CTE and DENSE_RANK(), find the third-highest salary in each department.

WITH ranked_emp AS (
    SELECT *,
           DENSE_RANK() OVER(
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) rn
    FROM emp
)
SELECT *
FROM ranked_emp
WHERE rn = 1;

-- Q13: Using a CTE and RANK(), rank employees department-wise based on salary.

WITH cte AS ( SELECT * , RANK() OVER(PARTITION BY dept_id ORDER BY salary ) AS rn 
             FROM emp )
SELECT * from cte WHERE rn=1;

-- Q14: Using a CTE and LAG(), display each employee along with the previous employee's salary based on hire_date.

WITH cte AS ( SELECT * ,
             LAG(salary) OVER( ORDER BY hire_date) AS rn FROM emp)
SELECT * from cte ;

-- Q15: Using a CTE and LEAD(), display each employee along with the next employee's salary based on hire_date.

WITH cte AS ( SELECT * ,
             LEAD(salary) OVER( ORDER BY hire_date) AS rn FROM emp)
SELECT * from cte ;

-- Q16: Using a CTE, calculate a running total of salaries ordered by hire_date.

WITH cte AS ( SELECT * ,
             SUM(salary) OVER( ORDER BY hire_date) AS rn FROM emp)
SELECT * from cte ;

-- Q17: Using multiple CTEs, find employees whose salary is greater than both:
-- (a) company average salary
-- (b) department average salary

WITH cte1 AS ( SELECT AVG(salary) avg_sal FROM emp ) , dept_avg AS ( SELECT dept_id,AVG(salary) ds FROM emp GROUP by dept_id ) 

SELECT * 
FROM emp e
JOIN dept_avg d 
ON e.dept_id=d.dept_id
WHERE e.salary > ( SELECT avg_sal FROM cte1 )
AND e.salary > d.ds ;

-- Q18: Using multiple CTEs, find the department with the highest total salary expenditure.

WITH dept_sal AS (
    SELECT dept_id,
           SUM(salary) total_salary
    FROM emp
    GROUP BY dept_id
)
SELECT *
FROM dept_sal
ORDER BY total_salary DESC
LIMIT 1;

-- Q19: Using multiple CTEs, rank departments based on total salary expenditure.

WITH dept_sal AS (
    SELECT dept_id,
           SUM(salary) total_salary
    FROM emp
    GROUP BY dept_id
)
SELECT *,RANK() OVER(ORDER BY total_salary) AS rn 
FROM dept_sal;

-- Q20: Using multiple CTEs and window functions, find the top 3 highest-paid employees in every department.
WITH ranked_emp AS (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) rn
    FROM emp
)
SELECT *
FROM ranked_emp
WHERE rn <= 3;