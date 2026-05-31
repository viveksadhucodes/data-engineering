-- ==========================================
-- BASIC QUERIES
-- ==========================================

-- 1. Select all columns from the Employee table.

SELECT *
FROM emp ;

-- 2. Select only the name and salary columns from the Employee table.

SELECT name,salary 
FROM emp;

-- 3. Select employees who are older than 30.

SELECT *
FROM emp
WHERE age>30 ;

-- 4. Select the names of all departments.

SELECT name
FROM dept ;

-- 5. Select employees who work in the IT department.

SELECT e.name,d.name
FROM emp e
JOIN dept d
ON e.dept_id=d.dept_id 
WHERE d.name="IT" ;

-- ==========================================
-- STRING MATCHING QUERIES
-- ==========================================

-- 6. Select employees whose names start with 'J'.

SELECT *
FROM emp 
WHERE name LIKE 'J%' ;

-- 7. Select employees whose names end with 'e'.

SELECT *
FROM emp
WHERE name LIKE '%e' ;

-- 8. Select employees whose names contain 'a'.

SELECT *
FROM emp
WHERE name LIKE '%a%' ;

-- 9. Select employees whose names are exactly 9 characters long.

SELECT 	*
FROM emp
WHERE LENGTH(name) = 9 ;

-- 10. Select employees whose names have 'o' as the second character.

SELECT *
FROM emp
WHERE name LIKE '_o%' ;

-- ==========================================
-- DATE QUERIES
-- ==========================================

-- 11. Select employees hired in the year 2020.

SELECT *
FROM emp
WHERE year(hire_date) = '2020' ;

-- 12. Select employees hired in January of any year.

SELECT *
FROM emp
WHERE month(hire_date) = '01' ;

-- 13. Select employees hired before 2019.

SELECT *
FROM emp
WHERE year(hire_date) < '2019' ;

-- 14. Select employees hired on or after March 1, 2021.

SELECT *
FROM emp
WHERE hire_date >= '021-03-01' ;

-- 15. Select employees hired in the last 2 years.

SELECT *
FROM emp
ORDER BY year(hire_date) DESC LIMIT 2 ;

-- ==========================================
-- AGGREGATE QUERIES
-- ==========================================

-- 16. Select the total salary of all employees.

SELECT SUM(salary) as total_salary
FROM emp ;

-- 17. Select the average salary of employees.

SELECT AVG(salary) as average_salary
FROM emp ;

-- 18. Select the minimum salary in the Employee table.

SELECT MIN(salary) as min_salary
FROM emp ;

-- 19. Select the number of employees in each department.

SELECT COUNT(emp_id) as total_emp_by_dept
FROM emp 
GROUP BY dept_id ;

-- 20. Select the average salary of employees in each department.

SELECT AVG(salary) as avg_salary_by_emp_each_dept
FROM emp 
GROUP BY dept_id ;

-- ==========================================
-- GROUP BY QUERIES
-- ==========================================

-- 21. Select the total salary for each department.

SELECT SUM(salary) AS deptwise_salaries
FROM emp 
GROUP BY dept_id ;

-- 22. Select the average age of employees in each department.

SELECT AVG(age) as avg_age
FROM emp
GROUP BY dept_id ;

-- 23. Select the number of employees hired in each year.

SELECT COUNT(emp_id) as no_of_emp
FROM emp
GROUP BY year(hire_date) ;

-- 24. Select the highest salary in each department.

SELECT MAX(salary) as highest_salary
FROM emp
GROUP BY dept_id ;

-- 25. Select the department with the highest average salary.

SELECT AVG(salary) as avg_salary
FROM emp
GROUP BY dept_id
ORDER BY avg_salary DESC LIMIT 1 ;

-- ==========================================
-- HAVING QUERIES
-- ==========================================

-- 26. Select departments with more than 2 employees.

SELECT COUNT(emp_id) AS emp_count
FROM emp
GROUP BY dept_id
HAVING emp_count> 2 ;

-- 27. Select departments with an average salary greater than 55000.

SELECT AVG(salary) as avg_salary
FROM emp
GROUP BY dept_id 
HAVING avg_salary > 55000 ;

-- 28. Select years with more than 1 employee hired.

SELECT COUNT(emp_id) as total_count,YEAR(hire_date) AS hire_year
FROM emp
GROUP BY YEAR(hire_date)
HAVING total_count > 1  ;

-- 29. Select departments with a total salary expense less than 100000.

SELECT SUM(salary) as total_salary,dept_id
FROM emp
GROUP BY dept_id 
HAVING total_salary < 100000 ;

-- 30. Select departments with the maximum salary above 75000.

SELECT MAX(salary) as total_salary,dept_id 
FROM emp
GROUP BY dept_id 
HAVING total_salary > 75000 ;