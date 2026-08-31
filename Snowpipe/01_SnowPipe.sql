use hrms;

create or replace schema pipe_schema;

create or replace file format csv_pipe_format
type = csv 
skip_header = 0 
field_delimiter = ','
field_optionally_enclosed_by = '"'
null_if = ('NULL','Null','null')
compression = AUTO
empty_field_as_null = true;

create or replace stage aws_pipe_csv_stage
  CREDENTIALS = (
    AWS_KEY_ID = '**'
    AWS_SECRET_KEY = '**'
  )
url = 's3://snowflake-bucket-inv/snowpipe/csv/'
file_format = csv_pipe_format;

list @aws_pipe_csv_stage;

select $1,
$2,
metadata$filename
from @aws_pipe_csv_stage;



create or replace table hrms.pipe_schema.employees_copy
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


create or replace pipe pipe_employee_csv
auto_ingest = true 
as 
copy into employees_copy from @aws_pipe_csv_stage;

show pipes;
show pipes like 'PIPE_EMPLOYEE_CSV';

select system$pipe_status('pipe_employee_csv');

select * from employees_copy;

alter pipe pipe_employee_csv refresh;

select * 
from table (information_schema.copy_history(table_name =>'employees_copy',
                                     start_time => dateadd(hours, -4,
                                                       current_timestamp())
                                            )
            );


alter pipe pipe_employee_csv set pipe_execution_paused = true;

show pipes;

select system$pipe_status('pipe_employee_csv');

select system$pipe_force_resume('pipe_employee_csv');

alter pipe pipe_employee_csv set pipe_execution_paused = false;