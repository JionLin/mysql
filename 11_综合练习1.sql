-- 1. 列出emp表中各部门的部门号，最高工资，最低工资
SELECT department_id,MAX(salary),MIN(salary) from employees GROUP BY department_id;
-- 2. 列出emp表中各部门job 含’REP’的员工的部门号，最低工资，最高工资
SELECT department_id,MAX(salary),MIN(salary) from employees  WHERE job_id LIKE '%REP%' GROUP BY department_id;
-- 3. 对于emp中最低工资小于7000的部门中job为'SA_REP'的员工的部门号，最低工资，最高工资
SELECT department_id,MAX(salary),MIN(salary) min_sal  from employees  WHERE job_id ='SA_REP' GROUP BY department_id HAVING min_sal<7000;
-- 4. 写出对上题的另一解决方法 (请补充)
SELECT department_id,MAX(salary),MIN(salary) min_sal  from employees WHERE job_id ='SA_REP'
 AND department_id IN ( SELECT department_id FROM employees GROUP BY department_id HAVING MIN(salary)<7000 ) GROUP BY department_id; 


-- 5. 根据部门号由高而低，工资由低而高列出每个员工的姓名，部门号，工资
SELECT last_name,department_id,salary FROM employees ORDER BY department_id DESC,salary ;
-- 6. 列出'Abel'所在部门中每个员工的姓名与部门号
SELECT last_name,department_id FROM employees WHERE department_id IN (SELECT department_id FROM employees WHERE last_name ='Abel')
-- 7. 列出每个员工的姓名，工作，部门号，部门名
SELECT e.last_name,e.job_id,e.department_id ,d.department_name FROM employees e  LEFT JOIN departments d ON e.department_id=d.department_id;
-- 8. 列出emp中工作为'SH_CLERK'的员工的姓名，工作，部门号，部门名
SELECT d.department_name,d.department_id,e.last_name,e.job_id FROM departments d ,(
SELECT    department_id  , last_name,job_id FROM employees WHERE job_id ='SH_CLERK')  e WHERE e.department_id=d.department_id;
-- 9. 对于emp中有管理者的员工，列出姓名，管理者姓名(管理者外键为mgr)
DESC employees;
SELECT emp.last_name emp_name,mgr.last_name mgr_name FROM employees emp JOIN employees mgr ON emp.manager_id=mgr.employee_id;
-- 10. 对于dept表中，列出所有部门名，部门号，同时列出各部门工作为'SH_CLERK'的员工名与工作
SELECT d.department_id,d.department_name,e.employee_id,e.job_id FROM departments d ,
(SELECT department_id,employee_id,job_id  FROM employees WHERE job_id ='SH_CLERK') e  WHERE d.department_id=e.department_id;

select dept.department_name as 部门名,dept.department_id as 部门号,emp.last_name as 员工名,emp.job_id as 工作 from departments dept,employees emp 
where dept.department_id = emp.department_id and emp.job_id = 'SH_CLERK';

-- 11. 对于工资高于本部门平均水平的员工，列出部门号，姓名，工资，按部门号排序    
SELECT e1.department_id,e1.last_name,e1.salary FROM employees e1 WHERE e1.salary>
(SELECT AVG(salary) FROM employees e2 WHERE e1.department_id=e2.department_id GROUP BY department_id)
  ORDER BY e1.department_id ;
	
	SELECT e1.department_id,e1.last_name,e1.salary FROM employees e1,
(SELECT AVG(salary) avg_sal,department_id FROM employees e2  GROUP BY department_id) e2
 WHERE e1.salary > e2.avg_sal AND e1.department_id=e2.department_id ;

-- 12. 对于emp，列出各个部门中 工资高于本部门平均水平的 员工数和部门号，按部门号排序 
SELECT COUNT(a.salary),a.department_id FROM employees a 
WHERE a.salary > (SELECT AVG(salary) FROM employees e2 WHERE a.department_id=e2.department_id )
GROUP BY a.department_id
ORDER BY a.department_id;

-- 13. 对于emp中工资高于本部门平均水平，人数多于1人的，列出部门号，高于部门平均工资的人数，按部门号排序 
SELECT * FROM (
SELECT department_id,COUNT(*) count_num FROM employees e1 WHERE salary >(
SELECT AVG(salary) FROM employees e2 WHERE e1.department_id =e2.department_id
)GROUP BY department_id 
) e3 WHERE e3.count_num>1
ORDER BY department_id;



-- 14. 对于emp中工资高于本部门平均水平，且其人数多于3人的，列出部门号，部门人数，按部门号排序 相关子查询 

SELECT * FROM (
SELECT COUNT(*) count_num,department_id FROM employees e1 WHERE e1.salary>(
SELECT AVG(salary) FROM employees e2 WHERE e1.department_id= e2.department_id
) GROUP BY department_id )e3  WHERE e3.count_num>3 ORDER BY e3.department_id ;


-- 15. 对于emp中低于自己工资至少5人的员工，列出其部门号，姓名，工资，以及工资少于自己的人数 

