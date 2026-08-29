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
from @aws_etl_csv_stage
on_error = abort_statement;

copy into employees_copy
from @aws_etl_csv_stage
on_error = skip_file;

copy into employees_copy
from @aws_etl_csv_stage
on_error = skip_file_6; 

copy into employees_copy
from @aws_etl_csv_stage
on_error = 'SKIP_FILE_10%';

copy into employees_copy
from @aws_etl_csv_stage
on_error = continue;

select * from employees_copy;