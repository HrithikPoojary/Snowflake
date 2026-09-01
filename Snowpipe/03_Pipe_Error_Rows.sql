use hrms.pipe_schema;

create or replace table hrms.pipe_schema.employees_copy_error
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

create or replace pipe pipe_employee_copy_error
auto_ingest = True 
as 
copy into employees_copy_error
from @aws_pipe_csv_stage;

list @aws_pipe_csv_stage;

show pipes;

select system$pipe_status('pipe_employee_copy_error');

select * from employees_copy_error;

select * from table(information_schema.copy_history(table_name=>'employees_copy',
start_time => dateadd(hours,-2,current_timestamp()))
);

drop pipe pipe_employee_copy_error;


select * from table(
information_schema.validate_pipe_load(
pipe_name => 'pipe_employee_copy_error',
start_time => dateadd(hours , -1 , current_timestamp())
                                    )
                );

