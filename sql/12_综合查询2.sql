-- 需求1:公司要求，员工档案要包括以下这些信息: 编号 ， 姓名 ， 工资 ， 生日
CREATE TABLE emp(
employee_id INT ,
last_name VARCHAR(50),
salary DECIMAL(10,2),
birth DATETIME
);
-- 需求2:怎么样?数据库表创建好了?那麻烦你帮我把下面这些数据保存起来吧?
ALTER TABLE emp MODIFY birth DATE;
DESC emp;
INSERT INTO emp(last_name,salary,birth) VALUES 
('马云',2025.33,'1973-8-12'),
('李彦宏', 3209.49,'1986-7-14'),
('马化腾', 1436.12,'1964-8-10');
SELECT * FROM emp;


-- 需求3:呀!对不起，我忘记了，表格中还需要保存“ 手机号 ”!能修改一下表格吗?
ALTER TABLE emp ADD COLUMN phone VARCHAR(20);
-- 需求4:呀!对不起，我又忘记了，公司还需要维护“部门”数据，同时记录每个员工是属于哪个部门的!
ALTER TABLE emp ADD COLUMN dept_id INT;
DESC emp;
ALTER TABLE emp ADD COLUMN dept_name VARCHAR(50);

-- 需求5:有一位同事辞职了，请帮我把他从系统中删除吧!他的员工编号是:5
SELECT * FROM emp;
DELETE FROM emp WHERE employee_id =5;
-- 需求6:有一位同事涨工资了，涨了200块钱，同时他手机号也改了，新的手机号是:13586705312。请帮 我改一下吧，你真是个好人!这位同事的编号是17。
UPDATE emp set salary=salary+300,phone='13586705312' WHERE employee_id =17;


-- 需求7:公司要打印报表，请帮我把全部信息都打印出来吧!
-- 需求8:有同事要补办工牌，请帮我把他的全部信息都调取出来，他的编号是:63
SELECT * FROM emp WHERE employee_id =63;
-- 需求9:Linda快过生日了，帮我查一下她生日的具体日期和手机号吧!
SELECT birth ,phone FROM emp WHERE last_name='Linda';
-- 需求10:公司要调查薪酬情况，请帮我查询一下工资在2000到5000之间的员工信息，以及工资在3000以 上的人数!
SELECT last_name,employee_id FROM emp WHERE salary BETWEEN 2000 AND 5000;
SELECT COUNT(*) FROM emp WHERE salary >3000;
-- 需求11:听说有些同事的工资正好是1000、3000或5000，帮我查查他们是谁吧?
SELECT last_name FROM emp WHERE salary IN(1000,3000,5000);
-- 需求12:公司开年会，要让名字里有字母o的同事表演节目，帮我查一下吧!
SELECT * from emp WHERE last_name LIKE '%o%';
-- 需求13:糟糕，有些同事的手机号是空的，帮我查询一下是哪些人吧!
SELECT last_name from emp WHERE last_name IS NULL;
-- 需求14:市场部的主管想了解他们部门员工的工资，帮我查一下吧!哦，对了，要按顺序显示哦!市场 部的部门名称是:Sales
SELECT salary FROM emp WHERE dept_name ='Sales' ORDER BY salary DESC;
-- 需求15:上述查询返回的记录太多了，查看起来很不方便，怎么样能够实现分页查询呢?
SELECT salary FROM emp WHERE dept_name ='Sales' ORDER BY salary DESC LIMIT 0,10;