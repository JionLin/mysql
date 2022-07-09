
# 2、创建表offices
CREATE TABLE offices(
officeCode int,
city varchar(30),
address varchar(50),
country varchar(50),
postalCode varchar(25)
);
# 3、创建表employees

CREATE TABLE  employees(
empNum int ,
lastName varchar(50),
firstName varchar(50),
mobile varchar(25),
code int,
jobTitle varchar(50),
birth date,
note  varchar(255),
sex varchar(5)
)
# 4、将表employees的mobile字段修改到code字段后面 
ALTER TABLE  employees MODIFY   mobile varchar(25) AFTER `code`;
DESC employees;
# 5、将表employees的birth字段改名为birthday
ALTER TABLE  employees CHANGE   birth  birthday date  ;

# 6、修改sex字段，数据类型为char(1)
ALTER TABLE  employees MODIFY sex char(1);
# 7、删除字段note
ALTER TABLE  employees DROP COLUMN note;
# 8、增加字段名favoriate_activity，数据类型为varchar(100) 
ALTER TABLE  employees  ADD COLUMN favoriate_activity varchar(100) ;
# 9、将表employees的名称修改为 employees_info
RENAME  TABLE employees TO employees_info;

SHOW TABLES FROM test03_company;
SHOW CREATE DATABASE test03_company;
CREATE DATABASE `test03_company` ;
SELECT VERSION();
show variables like 'character_%';
show variables like 'collation_%';


