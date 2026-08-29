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

copy into employees_copy
from 's3://snowflake-bucket-inv/loadingdata/csv/'
credentials =  (aws_key_id = '**',
                aws_secret_key = '**')
file_format = csv_file_format;

select * from employees_copy;