# 1.显示所有员工的姓名，部门号和部门名称。
SELECT e.last_name,e.department_id,d.department_name 
FROM employees e LEFT JOIN departments d 
ON e.department_id =d.department_id;

# 2.查询90号部门员工的job_id和90号部门的location_id
SELECT e.job_id,d.location_id FROM employees e  
JOIN departments d 
ON e.department_id =d.department_id
WHERE e.department_id ='90' ;


# 3.选择所有有奖金的员工的 last_name , department_name , location_id , city 107
SELECT e.last_name , d.department_name , d.location_id , l.city
 FROM employees e LEFT JOIN departments d 
ON e.department_id = d.department_id 
LEFT JOIN locations l  on d.location_id =l.location_id 
WHERE e.commission_pct IS NOT NULL;
desc employees;


# 4.选择city在Toronto工作的员工的 last_name , job_id , department_id , department_name 
SELECT e.last_name, e.job_id , e.department_id , d.department_name 
 FROM employees e JOIN departments d 
on e.department_id =d.department_id JOIN locations l 
on d.location_id =l.location_id 
WHERE l.city='Toronto';


# 5.查询员工所在的部门名称、部门地址、姓名、工作、工资，其中员工所在部门的部门名称为’Executive’

SELECT d.department_name, l.street_address, e.last_name, 
e.job_id, e.salary
 FROM employees e 
JOIN  departments d  ON e.department_id =d.department_id
 JOIN locations l 
 on d.location_id =l.location_id  WHERE d.department_name ='Executive';



# 6.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式 
-- employees Emp# manager Mgr#
-- kochhar 		101 king 		100
SELECT e.last_name "employees" ,e.employee_id "Emp#",
e2.last_name "manager" ,e2.employee_id "Mgr#" 
FROM employees e  LEFT JOIN employees e2 ON 
e2.employee_id =e.manager_id;


# 7.查询哪些部门没有员工 16 条  
SELECT d.department_id,d.department_name,e.employee_id 
FROM departments d LEFT JOIN employees e ON 
d.department_id =e.department_id
 WHERE e.department_id IS NULL; 
 
 SELECT d.department_id
FROM departments d LEFT JOIN employees e ON e.department_id = d.`department_id` WHERE e.department_id IS NULL

# 8. 查询哪个城市没有部门 16条 
desc locations;
DESC departments;

SELECT l.location_id ,d.department_id,l.city FROM  locations l 
LEFT JOIN departments d  on d.location_id=l.location_id  
WHERE d.location_id IS NULL;
# 9. 查询部门名为 Sales 或 IT 的员工信息 39条 
SELECT
	e.last_name,
	e.department_id,
	d.department_name 
FROM
	employees e
	LEFT JOIN departments d ON e.department_id = d.department_id 
WHERE
	d.department_name IN ( 'Sales', 'IT' );
	
	SELECT employee_id,last_name,department_name
FROM employees e,departments d
WHERE e.department_id = d.`department_id`
AND d.`department_name` IN ('Sales','IT');


