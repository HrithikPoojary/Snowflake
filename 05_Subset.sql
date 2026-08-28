use hrms.etl;

create or replace table employee_subset(
employee_id number(6),
first_name varchar(30),
last_name varchar(30),
department_id number(10)
);

select * from employee_subset;

copy into employee_subset
from @aws_etl_csv_stage;

select t.$1, t.$2 , t.$3 , $11 from @aws_etl_csv_stage t;

copy into employee_subset
from (select t.$1,t.$2,t.$3 ,t.$11 from @aws_etl_csv_stage t);

select * from employee_subset;

select $1 from @aws_etl_csv_stage;


create or replace table employee_subset(
employee_id number(6),
first_name varchar(30),
last_name varchar(30),
department_id number(4),
file_name varchar(50)
);


copy into employee_subset
from (select $1,$2,$3,$11, metadata$filename from @aws_etl_csv_stage);

select * from employee_subset;

CREATE OR REPLACE TABLE employee_subset (
    employee_id NUMBER(6) autoincrement start 1 increment 1,
    first_name VARCHAR(60),
    last_name VARCHAR(60),
    department_id NUMBER(4),
    file_name VARCHAR(50)
);

select * from employee_subset;

copy into employee_subset(first_name, last_name , department_id , file_name)
from (select $2,$3,$11,metadata$filename from @aws_etl_csv_stage);

select * from employee_subset;



