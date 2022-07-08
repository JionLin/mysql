

/*
另外要根据 英文需要翻译成对应的中文 
子查询是由内往外查还是由外往内查 
1.简单的,由外往内查,复杂的 由内往外查 
2.相关子查询,由外往内查 
1-5   1 1 1 1 1
6-10  1 1 4 4 4
11-15 1 3 4 3 2
16-20 1 2 2 1 1


*/
#1.查询和Zlotkey相同部门的员工姓名和工资
SELECT last_name,salary 
	FROM employees 
		WHERE department_id IN(
											SELECT department_id 
											FROM employees  
											WHERE last_name ='Zlotkey'
											);

#2.查询工资比公司平均工资高的员工的员工号，姓名和工资。
SELECT employee_id,last_name,salary 
FROM employees 
WHERE salary >(
						SELECT AVG(salary) 
						FROM employees
						);

#3.选择 工资大于所有JOB_ID = 'SA_MAN'的员工的工资的 员工的last_name, job_id, salary 
SELECT last_name, job_id, salary 
 FROM employees 
 WHERE salary > ALL( SELECT (salary) FROM employees WHERE JOB_ID = 'SA_MAN');

#4.查询 和姓名中包含字母u的员工在相同部门的员工的 员工号和姓名 
SELECT employee_id,last_name 
FROM employees 
WHERE department_id IN (
										SELECT department_id 
										FROM employees 
										WHERE last_name 
										LIKE '%u%' 
										);

#5.查询 在部门的location_id为1700的部门工作的员工的 员工号
-- 方式1 
SELECT e.employee_id FROM employees e 
LEFT JOIN departments d 
on e.department_id= d.department_id
 WHERE d.location_id ='1700' ;
-- 方式2 
SELECT employee_id FROM employees
WHERE department_id in (
									SELECT department_id from departments WHERE location_id =1700
									)

#6.查询管理者是King的员工姓名和工资 
SELECT last_name,salary,manager_id 
FROM employees 
WHERE manager_id IN(
 SELECT employee_id FROM employees WHERE last_name ='King'
 );
#7.查询工资最低的员工信息: last_name, salary
SELECT last_name,salary
 FROM employees WHERE salary IN (
																SELECT MIN(salary) FROM employees );


#8.查询平均工资最低的部门信息  需要 4种 
-- 方式1

SELECT * FROM departments
							WHERE department_id IN(
																		SELECT
																			department_id 
																		FROM
																			employees 
																		GROUP BY department_id HAVING AVG( salary ) =(
																					SELECT MIN( avg_sal ) 
																					FROM
																					( SELECT AVG( salary ) avg_sal 
																					FROM employees 
																					GROUP BY department_id ) alias_emp)
															)
-- 方式2 
SELECT * FROM departments
							WHERE department_id IN(
														SELECT
															department_id 
														FROM
															employees 
														GROUP BY department_id HAVING AVG( salary ) <= ALL
														(
																	SELECT AVG( salary ) avg_sal 
																		FROM employees 
																		GROUP BY department_id ) 
															)
	
-- 	 方式3 

SELECT d.* FROM departments d ,
(
SELECT AVG( salary ) avg_sal,department_id
				FROM employees 
				GROUP BY department_id 
				ORDER BY avg_sal 
				LIMIT 0,1 
				) t_dep_avg_sal 
				WHERE d.department_id =t_dep_avg_sal.department_id;
				
-- 	方式4 

SELECT * FROM departments
							WHERE department_id IN(
														SELECT
															department_id 
														FROM
															employees 
														GROUP BY department_id HAVING AVG( salary )=
														(
																	SELECT AVG( salary ) avg_sal 
																		FROM employees 
																		GROUP BY department_id ORDER BY  avg_sal LIMIT 0,1 ) 
															)

				

#9.查询平均工资最低的部门信息和该部门的平均工资(相关子查询) 需要 4种 
-- 方式1  子查询
SELECT d.*,
(SELECT AVG(salary) FROM employees WHERE department_id =d.department_id) avg_sal
FROM departments d WHERE department_id IN (
																		SELECT department_id FROM employees 
																		GROUP BY department_id
																		 HAVING AVG(salary) =(
																											SELECT MIN(avg_sal) FROM (
																																						SELECT AVG(salary) avg_sal
																																						 FROM employees 
																																						GROUP BY department_id
																																						) t_dept_avg_sal)
																											)


-- 方式2 子查询
SELECT d.*,
(SELECT AVG(salary) FROM employees WHERE department_id =d.department_id) avg_sal
FROM departments d 
WHERE department_id IN (
							SELECT department_id FROM employees 
							GROUP BY department_id 
							HAVING AVG(salary) <=ALL(																																												
																				SELECT AVG(salary) avg_sal
																				 FROM employees 
																				GROUP BY department_id
																		)
															)
 
-- 方式3  子查询 

SELECT d.*,
(SELECT AVG(salary) FROM employees WHERE department_id =d.department_id) avg_sal
	FROM departments  d
	WHERE department_id IN (
												SELECT department_id FROM employees 
												GROUP BY department_id
												 HAVING AVG(salary) =(																																												
																							SELECT AVG(salary) avg_sal
																							 FROM employees 
																							GROUP BY department_id
																							ORDER BY avg_sal LIMIT 0,1
																					)
									)


-- 方式4 相关子查询 
SELECT e.department_id,e.department_name ,t_dept_avg_sal.avg_sal
FROM departments e ,(
							SELECT AVG(salary) avg_sal,department_id
										 FROM employees 
										GROUP BY department_id
										ORDER BY avg_sal LIMIT 0,1
) t_dept_avg_sal WHERE e.department_id=t_dept_avg_sal.department_id;




#10.查询平均工资最高的 job 信息 需要 4种 
--  方式1 
SELECT * FROM jobs WHERE job_id IN(
SELECT job_id FROM
employees   GROUP BY job_id 
HAVING MAX(salary)IN
(
						SELECT MAX(avg_sal) FROM (
						SELECT AVG(salary) avg_sal FROM employees GROUP BY job_id)
						 t_emp_avg_sal))
-- 方式2  3层 
SELECT * FROM jobs WHERE job_id IN(
SELECT job_id FROM
employees   GROUP BY job_id 
HAVING MAX(salary)>=ALL
(
SELECT AVG(salary) avg_sal FROM employees GROUP BY job_id)
)
		
-- 方式3 子查询  3层 
SELECT * FROM jobs WHERE job_id IN(
SELECT job_id FROM
employees   GROUP BY job_id 
HAVING MAX(salary)=
(
SELECT AVG(salary) avg_sal FROM employees GROUP BY job_id ORDER BY avg_sal DESC LIMIT 0,1)
)						 
--  方式4 相关子查询 
SELECT j.* FROM jobs j ,
(SELECT AVG(salary) avg_sal,job_id FROM employees GROUP BY job_id ORDER BY avg_sal DESC LIMIT 0,1) t_job_avg_sal 
WHERE j.job_id =t_job_avg_sal.job_id

#11.查询平均工资高于公司平均工资的部门有哪些? 后面看  
SELECT department_id,department_name FROM departments ;
SELECT AVG(salary) avg_sal  FROM employees e ,
(
SELECT AVG(salary) avg_sal_dep FROM employees GROUP BY department_id
) e2 
WHERE e.avg_sal>e2.avg_sal_dep
;


#12.查询出公司中所有 manager 的详细信息

SELECT emp.employee_id,emp.last_name,emp.manager_id,emp.department_id FROM employees emp  JOIN
employees mgr on emp.manager_id =mgr.employee_id;

#13.各个部门中 最高工资中最低的那个部门的 最低工资是多少? 题目没看懂  



#14.查询平均工资最高的部门的 manager 的详细信息: last_name, department_id, email, salary 
SELECT last_name, department_id, email, salary  FROM employees WHERE department_id IN (
SELECT department_id FROM employees 
GROUP BY department_id
HAVING MAX(salary) >= ALL (
SELECT MAX(avg_sal) FROM (
SELECT AVG(salary) avg_sal FROM employees GROUP BY department_id) t_dept_avg_sal))


#15. 查询部门的部门号，其中不包括job_id是"ST_CLERK"的部门号
SELECT department_id,department_name FROM departments WHERE department_id IN(
SELECT  DISTINCT department_id FROM employees WHERE job_id <> 'ST_CLERK' );
#16. 选择所有没有管理者的员工的last_name 
SELECT last_name FROM employees WHERE employee_id emp  NOT IN 
(SELECT manager_id FROM employees mgr WHERE emp.manager_id =mgr.employee_id )
#17.查询员工号、姓名、雇用时间、工资，其中员工的管理者为 'De Haan'
SELECT employee_id,last_name,hire_date,salary,manager_id FROM employees WHERE manager_id IN
(
SELECT manager_id FROM employees WHERE last_name ='De Haan'
)

#18.查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资(相关子查询)
SELECT e1.employee_id,e1.last_name,e1.salary FROM employees e1,
(SELECT AVG(salary) avg_sal,department_id FROM employees GROUP BY department_id) e2
WHERE e1.department_id =e2.department_id AND e1.salary>e2.avg_sal;
#19.查询每个部门下的部门人数大于 5 的部门名称(相关子查询)
SELECT DISTINCT department_id FROM employees e1 WHERE 5<= (SELECT COUNT(*) FROM employees e2 WHERE e1.department_id =e2.department_id)


#20.查询每个国家下的部门个数大于 2 的国家编号(相关子查询)
SELECT location_id FROM departments d WHERE 2<
(SELECT  COUNT(*) FROM locations l WHERE l.location_id =d.location_id)

-- 查询员工的id,salary,按照department_name 排序
SELECT e1.employee_id,e1.salary FROM employees e1 ORDER BY
(SELECT department_name FROM departments d 
WHERE e1.department_id =d.department_id) DESC


-- 若employees表中employee_id与job_history表中employee_id相同的数目不小于2，输出这些相同id的员工的employee_id,last_name和其job_id
SELECT employee_id,last_name,job_id FROM employees e WHERE  2<= (SELECT COUNT(*) FROM job_history j WHERE j.employee_id =e.employee_id )



