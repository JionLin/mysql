# 1.显示系统时间(注:日期+时间)
SELECT NOW() FROM DUAL;
# 2.查询员工号，姓名，工资，以及工资提高百分之20%后的结果(new salary)
SELECT employee_id,last_name,salary,salary *(1.2) "new salary" FROM employees;
# 3.将员工的姓名按首字母排序，并写出姓名的长度(length)
SELECT last_name,LENGTH(last_name) FROM employees ORDER BY last_name DESC;
# 4.查询员工id,last_name,salary，并作为一个列输出，别名为OUT_PUT
SELECT CONCAT(employee_id,' , ',last_name,' , ',salary) "OUT_PUT" FROM employees;
# 5.查询公司各员工工作的年数、工作的天数，并按工作年数的降序排序
SELECT  DATEDIFF(SYSDATE(),hire_date)/365 workYears, DATEDIFF(SYSDATE(),hire_date) workday  FROM employees ORDER BY workYears DESC;
DESC employees;
# 6.查询员工姓名，hire_date , department_id，满足以下条件:雇用时间在1997年之后，department_id 为80 或 90 或110, commission_pct不为空
SELECT e.last_name,e.hire_date,d.department_id FROM employees e JOIN 
departments d  ON e.department_id = d.department_id
WHERE d.department_id in(80,90,100) and e.commission_pct IS  NOT NULL AND YEAR(e.hire_date )>=1997;
# 7.查询公司中入职超过10000天的员工姓名、入职时间
SELECT last_name,hire_date FROM employees  WHERE DATEDIFF(NOW(),hire_date) >10000;
# 8.做一个查询，产生下面的结果
<last_name> earns <salary> monthly but wants <salary*3>

SELECT CONCAT(last_name, ' earns ', TRUNCATE(salary, 0) , ' monthly but wants ',
TRUNCATE(salary * 3, 0)) "Dream Salary"
FROM employees;
-- 1）当 D 大于0，是对数值 X 的小数位数进行操作；
-- 
-- 2）当 D 等于0，是将数值 X 的小数部分去除，只保留整数部分；
-- 
-- 3）当 D 小于0，是将数值 X 的小数部分去除，并将整数部分按照 D 指定位数，用 0 替换。


# 9.使用case-when，按照下面的条件: 
job                 grade 
AD_PRES 						 A
ST_MAN               B
IT_PROG              C
SA_REP               D
ST_CLERK             E

SELECT last_name Last_name,job_id, CASE job_id
	WHEN 'AD_PRES' THEN
		'A'
		WHEN 'ST_MAN' THEN
		'B'
		WHEN 'IT_PROG' THEN
		'C'
		WHEN 'SA_REP' THEN
		'D'
		WHEN 'ST_CLERK' THEN
		'E'
		ELSE 'F'
END  "Grade" 
   FROM employees;
