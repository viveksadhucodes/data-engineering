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

-- ==========================================
-- ORDER BY QUERIES
-- ==========================================

-- 31. Select all employees ordered by their salary in ascending order.

SELECT *
FROM emp
ORDER BY salary ;

-- 32. Select all employees ordered by their age in descending order.

SELECT *
FROM emp
ORDER BY age DESC ;

-- 33. Select all employees ordered by their hire date in ascending order.

SELECT * 
FROM emp
ORDER BY hire_date ;

-- 34. Select employees ordered by their department and then by their salary.

SELECT * FROM emp
ORDER BY dept_id ASC, salary ASC;

-- 35. Select departments ordered by the total salary of their employees.

SELECT SUM(SALARY) as total_salary_by_dept
FROM emp
GROUP BY dept_id
ORDER BY total_salary_by_dept ;

-- ==========================================
-- JOIN QUERIES
-- ==========================================

-- 36. Select employee names along with their department names.

SELECT e.emp_id,e.name,d.name
FROM emp e
JOIN dept d
ON e.dept_id=d.dept_id ;

-- 37. Select project names along with the department names they belong to.

SELECT p.name,d.name
FROM Project p
JOIN dept d
ON p.dept_id=d.dept_id ;

-- 38. Select employee names and their corresponding project names.
SELECT e.name AS employee_name, d.name AS department_name, p.name AS project_name
FROM emp e
JOIN dept d ON e.dept_id = d.dept_id
JOIN Project p ON d.dept_id = p.dept_id
ORDER BY e.name;

-- 39. Select all employees and their departments, including those without a department.

SELECT e.emp_id,e.name,d.name
FROM emp e
LEFT JOIN dept d
ON e.dept_id=d.dept_id ;

-- 40. Select all departments and their employees, including departments without employees.

SELECT e.emp_id,e.name,d.name
FROM emp e
RIGHT JOIN dept d
ON e.dept_id=d.dept_id ;

-- 41. Select employees who are not assigned to any project.

SELECT e.name
FROM emp e
LEFT JOIN Project p
ON e.dept_id=p.dept_id 
WHERE p.project_id=NULL ;

-- 42. Select employees and the number of projects their department is working on.

SELECT COUNT(p.project_id) as no_of_proj,e.dept_id,e.name
FROM emp e
JOIN Project p
ON e.dept_id=p.dept_id 
GROUP BY e.dept_id,e.name ;

-- 43. Select the departments that have no employees.

SELECT d.name 
FROM dept d
LEFT JOIN emp e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;

-- 44. Select employee names who share the same department with 'John Doe'.

SELECT name 
FROM emp 
WHERE dept_id = (SELECT dept_id FROM emp WHERE name = 'John Doe')
  AND name != 'John Doe';

-- 45. Select the department name with the highest average salary.

SELECT d.name,AVG(e.salary) AS avg_salary
FROM emp e
JOIN dept d
ON e.dept_id=d.dept_id 
GROUP BY e.dept_id
ORDER BY avg_salary DESC LIMIT 1 ;

-- ==========================================
-- NESTED AND CORRELATED QUERIES
-- ==========================================

-- 46. Select the employee with the highest salary.

SELECT name,salary
FROM emp 
WHERE salary = (SELECT MAX(salary) FROM emp) ;

-- 47. Select employees whose salary is above the average salary.

SELECT name,salary
FROM emp 
WHERE salary >(SELECT AVG(salary) FROM emp) ;

-- 48. Select the second highest salary from the Employee table.

SELECT name,salary
FROM emp 
WHERE salary >(SELECT AVG(salary) FROM emp) 
ORDER BY salary LIMIT 2 ;

-- 49. Select the department with the most employees.

SELECT d.name,COUNT(emp_id) as emp_cnt 
FROM emp e
JOIN dept d
ON d.dept_id=e.dept_id 
GROUP BY d.dept_id 
ORDER BY emp_cnt DESC LIMIT 1 ;

-- 50. Select employees who earn more than the average salary of their department.

SELECT e1.name
FROM emp e1
WHERE e1.salary > (
    SELECT AVG(e2.salary) 
    FROM emp e2 
    WHERE e2.dept_id = e1.dept_id
);

-- 51. Select the nth highest salary (for example, 3rd highest).

SELECT DISTINCT salary 
FROM emp 
ORDER BY salary DESC 
LIMIT 2, 1;

-- 52. Select employees who are older than all employees in the HR department.

SELECT name
FROM emp
WHERE age > ( SELECT MAX(age) FROM emp e JOIN dept d ON e.dept_id = d.dept_id WHERE d.name = 'HR' );

-- 53. Select departments where the average salary is greater than 55000.

SELECT dept_id, AVG(salary) AS avg_sal
FROM emp
GROUP BY dept_id
HAVING avg_sal > 55000;

-- 54. Select employees who work in a department with at least 2 projects.

SELECT name 
FROM emp 
WHERE dept_id IN (
    SELECT dept_id 
    FROM Project 
    GROUP BY dept_id 
    HAVING COUNT(project_id) >= 2
);

-- 55. Select employees who were hired on the same date as 'Jane Smith'.

SELECT name
FROM emp 
WHERE hire_date = (SELECT hire_date FROM emp WHERE name='Jane Smith' ) ;



-- ==========================================
-- COMBINED MODERATE DIFFICULTY QUERIES
-- ==========================================

-- 56. Select the total salary of employees hired in the year 2020.

SELECT SUM(salary) AS total_sal 
FROM emp
GROUP BY YEAR(hire_date) ;


-- 57. Select the average salary of employees in each department, ordered by the average salary in descending order.

SELECT AVG(salary) AS avg_salary
FROM emp
GROUP BY dept_id
ORDER BY avg_salary DESC ;

-- 58. Select departments with more than 1 employee and an average salary greater than 55000.
SELECT dept_id, COUNT(emp_id) AS emp_cnt, AVG(salary) AS avg_salary
FROM emp
GROUP BY dept_id
HAVING emp_cnt > 1 AND avg_salary > 55000;

-- 59. Select employees hired in the last 2 years, ordered by their hire date.

SELECT name
FROM emp
ORDER BY YEAR(hire_date) DESC LIMIT 2 ;

-- 60. Select the total number of employees and the average salary for departments with more than 2 employees.

SELECT dept_id, COUNT(emp_id) AS emp_cnt, AVG(salary) AS avg_salary
FROM emp
GROUP BY dept_id
HAVING emp_cnt > 2 ;

-- 61. Select the name and salary of employees whose salary is above the average salary of their department.

SELECT name,salary
FROM emp e1
WHERE salary > (SELECT AVG(salary) FROM emp e2 WHERE e1.dept_id=e2.dept_id ) ;

-- 62. Select the names of employees who are hired on the same date as the oldest employee in the company.

SELECT name
FROM emp 
WHERE date(hire_date) = (SELECT date(hire_date) FROM emp ORDER BY hire_date DESC LIMIT 1 ) ;

-- 63. Select the department names along with the total number of projects they are working on, ordered by the number of projects.
SELECT d.name AS department_name, COUNT(p.project_id) AS total_projects
FROM dept d
LEFT JOIN Project p ON d.dept_id = p.dept_id
GROUP BY d.dept_id, d.name
ORDER BY total_projects ASC;

-- 64. Select the employee name with the highest salary in each department.

SELECT name
FROM emp e1
WHERE salary >=(SELECT MAX(salary) FROM emp e2 WHERE e1.dept_id=e2.dept_id ) ;

-- 65. Select the names and salaries of employees who are older than the average age of employees in their department.

SELECT name,salary
FROM emp e1
WHERE salary > (SELECT AVG(age) FROM emp e2 WHERE e1.dept_id=e2.dept_id ) ;
