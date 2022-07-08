#1.where子句可否使用组函数进行过滤?  NO
#2.查询公司员工工资的最大值，最小值，平均值，总和 
SELECT MAX(salary),MIN(salary),AVG(salary),SUM(salary) FROM employees;
#3.查询各job_id的员工工资的最大值，最小值，平均值，总和
SELECT job_id,MAX(salary),MIN(salary),AVG(salary),SUM(salary) FROM employees GROUP BY job_id; 
#4.选择具有各个job_id的员工人数
SELECT COUNT(*),job_id FROM employees GROUP BY job_id;
# 5.查询员工最高工资和最低工资的差距(DIFFERENCE)
SELECT MAX(salary),MIN(salary),(MAX(salary)-MIN(salary)) "DIFFERENCE" FROM employees;
# 6.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内 

SELECT MIN(salary) as "minsal" FROM employees WHERE manager_id IS NOT NULL  GROUP BY manager_id HAVING minsal>=6000
# 7.查询所有部门的名字，location_id，员工数量和平均工资，并按平均工资降序
SELECT d.department_name ,d.location_id,COUNT(employee_id), AVG(e.salary) "avgsalary"
FROM departments d LEFT JOIN employees e 
ON d.department_id =e.department_id
LEFT JOIN locations l 
ON d.location_id =l.location_id 
GROUP BY d.department_name ,d.location_id
ORDER BY avgsalary DESC
DESC employees;
DESC job_grades;
# 8.查询每个工种、每个部门的部门名、工种名和最低工资
SELECT d.department_name, MIN(salary),e.job_id FROM departments d 
LEFT JOIN  employees e 
ON e.department_id =d.department_id
GROUP BY d.department_name,e.job_id;