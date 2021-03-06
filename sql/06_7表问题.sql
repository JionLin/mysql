#1.所有有门派的人员信息 ( A、B两表共有)
SELECT  d.deptName,d.address,e.`name`,e.age FROM t_dept d 
JOIN t_emp e on d.id =e.deptId ;
#2.列出所有用户，并显示其机构信息 (A的全集)
SELECT e.`name`,e.age, d.deptName FROM t_emp e 
LEFT JOIN  t_dept d   on d.id =e.deptId ;
#3.列出所有门派 (B的全集)
SELECT e.`name`,e.age, d.deptName FROM t_emp e 
RIGHT  JOIN  t_dept d   on d.id =e.deptId ;
#4.所有不入门派的人员 (A的独有)
SELECT e.`name`,e.age, d.deptName FROM t_emp e 
LEFT JOIN  t_dept d   on d.id =e.deptId 
WHERE d.id is NULL;
#5.所有没人入的门派 (B的独有)
SELECT e.`name`,e.age, d.deptName FROM t_emp e 
RIGHT  JOIN  t_dept d   on d.id =e.deptId 
WHERE e.deptId is NULL;
#6.列出所有人员和机构的对照关系 (AB全有)
SELECT e.`name`,e.age, d.deptName FROM t_emp e 
LEFT JOIN  t_dept d   on d.id =e.deptId 

UNION ALL
SELECT e.`name`,e.age, d.deptName FROM t_emp e 
RIGHT  JOIN  t_dept d   on d.id =e.deptId 
WHERE e.deptId is NULL;
#MySQL Full Join的实现 因为MySQL不支持FULL JOIN,下面是替代方法 #left join + union(可去除重复数据)+ right join
#7.列出所有没入派的人员和没人入的门派 (A的独有+B的独有)
SELECT e.`name`,e.age, d.deptName FROM t_emp e 
LEFT JOIN  t_dept d   on d.id =e.deptId 
WHERE d.id is NULL
UNION ALL
SELECT e.`name`,e.age, d.deptName FROM t_emp e 
RIGHT  JOIN  t_dept d   on d.id =e.deptId 
WHERE e.deptId is NULL;