CREATE DATABASE test04_emp;
use test04_emp;
CREATE TABLE emp2(
                     id INT,
                     emp_name VARCHAR(15)
);
CREATE TABLE dept2(
                      id INT,
                      dept_name VARCHAR(15)
);


#1. 向表emp2的id列中添加PRIMARY KEY约束
ALTER TABLE emp2 ADD PRIMARY KEY(id);
DESC emp2;
#2.  向表dept2的id列中添加PRIMARY KEY约束
ALTER TABLE dept2 ADD PRIMARY KEY(id);
DESC dept2;

#3.  向表emp2中添加列dept_id，并在其中定义FOREIGN KEY约束，与之相关联的列是dept2表中的id列
ALTER TABLE emp2 ADD COLUMN dept_id int ;
DESC emp2;
ALTER TABLE emp2 ADD CONSTRAINT fk_emp2_deptid FOREIGN KEY(dept_id) REFERENCES dept2(id);

--  练习2
# 1、创建数据库test01_library
# 2、创建表 books，表结构如下: 括号问题 导致的原因
DROP TABLE books;
CREATE TABLE books
(id INT  COMMENT '书编号',
 `NAME` VARCHAR(50) COMMENT '书名',
 `authors`  VARCHAR(100) COMMENT  '作者',
 price FLOAT COMMENT  '价格' ,
 pubdate  YEAR COMMENT  '出版日期',
 note  VARCHAR(100) COMMENT  '说明',
 num  INT COMMENT  '库存'
);


# 3、使用ALTER语句给books按如下要求增加相应的约束
-- 主键
ALTER TABLE books ADD PRIMARY KEY(id);

--  自增
ALTER TABLE books MODIFY id INT AUTO_INCREMENT;

-- 给其他字段添加非空
ALTER TABLE books MODIFY `NAME` VARCHAR(50)  not NULL;
ALTER TABLE books MODIFY `authors`  VARCHAR(100)   not NULL;
ALTER TABLE books MODIFY price FLOAT   not NULL;
ALTER TABLE books MODIFY pubdate  YEAR  not NULL;
ALTER TABLE books MODIFY note  VARCHAR(100)  not NULL;
ALTER TABLE books MODIFY num  INT  not NULL;

DESC books;

--  练习3
#2. 按照下表给出的表结构在test04_company数据库中创建两个数据表offices和employees
CREATE TABLE offices(
                        officeCode int(10),
                        city VARCHAR(50) NOT NULL,
                        address varchar(50),
                        country VARCHAR(50) NOT NULL,
                        postalCode VARCHAR(15) UNIQUE,
                        PRIMARY KEY(officeCode)
);

CREATE TABLE employees(
                          employeeNumber int(11) PRIMARY KEY AUTO_INCREMENT,
                          lastName VARCHAR(50) NOT NULL,
                          firstName VARCHAR(50) NOT NULL,
                          mobie VARCHAR(25) UNIQUE,
                          officeCode INT(10) NOT NULL,
                          jobTital VARCHAR(50) NOT NULL,
                          birth Datetime NOT NULL,
                          note VARCHAR(255) ,
                          sex VARCHAR(5),
                          CONSTRAINT fk_emp  FOREIGN KEY(officeCode) REFERENCES offices(officeCode)
);
DESC employees_info;
#3. 将表employees的mobile字段修改到officeCode字段后面
ALTER TABLE employees MODIFY  mobie VARCHAR(25) AFTER officeCode;
#4. 将表employees的birth字段改名为employee_birth
ALTER TABLE employees CHANGE birth   employee_birth  Datetime;
#5. 修改sex字段，数据类型为CHAR(1)，非空约束
ALTER TABLE employees MODIFY sex CHAR(1) NOT NULL;
#6. 删除字段note
ALTER TABLE employees  DROP COLUMN note;
#7. 增加字段名favoriate_activity，数据类型为VARCHAR(100)
ALTER TABLE employees ADD COLUMN favoriate_activity VARCHAR(100);
#8. 将表employees名称修改为employees_info
ALTER TABLE employees RENAME  employees_info;





-- 扩展练习
-- 练习1
-- (1)创建数据库test04_Market。
-- (2)创建数据表customers，在c_num字段上添加主键约束和自增约 束，在c_birth字段上添加非空约束。
CREATE TABLE customers(
                          c_num INT(11) PRIMARY KEY AUTO_INCREMENT,
                          c_name VARCHAR(50),
                          c_contact   VARCHAR(50),
                          c_city  VARCHAR(50) ,
                          c_birth DATETIME NOT NULL
);
DESC customers_info;
-- (3)将c_contact字段插入c_birth字段后面。
ALTER TABLE customers MODIFY c_contact  VARCHAR(50) AFTER c_birth;
-- (4)将c_name字段 数据类型改为VARCHAR(70)。
ALTER TABLE customers MODIFY c_name VARCHAR(70);
-- (5)将c_contact字段改名为c_phone。
ALTER TABLE customers  CHANGE  c_contact  c_phone  VARCHAR(50);
-- (6)增加c_gender字段，数据类 型为CHAR(1)。
ALTER TABLE customers ADD COLUMN  c_gender CHAR(1);
-- (7)将表名修改为customers_info。
ALTER TABLE customers RENAME customers_info ;
-- (8)删除字段c_city。
ALTER TABLE customers_info DROP COLUMN c_city;

-- (1)创建数据表orders，在o_num字段上添加主键约束和自增约束，在c_id字段上添加外键约束，关联 customers表中的主键c_num。
CREATE TABLE orders(
                       o_num INT(11) PRIMARY key AUTO_INCREMENT,
                       o_date DATE ,
                       c_id INT(11) ,
                       CONSTRAINT c_id_c_num FOREIGN KEY(c_id) REFERENCES customers_info(c_num)
);
DESC orders;
-- (2)删除orders表的外键约束，然后删除表customers。
ALTER TABLE  orders DROP FOREIGN KEY c_id_c_num;

DROP TABLE customers_info;
DESC customers_info;




