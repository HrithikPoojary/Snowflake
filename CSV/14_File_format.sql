use hrms.etl;

create or replace table hrms.etl.employees_copy
(
employee_id number(6),
first_name varchar(20),
last_name varchar(20),
email varchar(20),
phone_number varchar(20),
hire_dt date,
job_id varchar(10),
salary number(8,2),
commission_pct decimal(2,2),
manager_id number(10),
department_id number(10)
);


list @aws_etl_csv_stage;

copy into employees_copy
from @aws_etl_csv_stage
file_format = (
type = csv ,
field_delimiter = '|',
skip_header = 1,
null_if = ('Null','NULL'),
field_optionally_enclosed_by = '"'
);

select * from employees_copy;


create or replace file format hrms.etl.csv_file_format
type = csv,
field_delimiter = '|',
field_optionally_enclosed_by = '"',
skip_header = 1,
null_if = ('Null','NULL'),
compression = AUTO
trim_space = True;

copy into employees_copy
from @aws_etl_csv_stage
file_format = csv_file_format;



