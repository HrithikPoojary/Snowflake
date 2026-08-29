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


show stages;

use hrms.etl;

copy into hrms.etl.employees_copy
from @AWS_ETL_CSV_STAGE;

copy into hrms.etl.employees_copy
from @AWS_ETL_CSV_STAGE
force = True;

truncate table employees_copy;

delete from employees_copy where employee_id = 120;

select *  from hrms.etl.employees_copy; where employee_id = 120;

list @aws_etl_csv_stage;

