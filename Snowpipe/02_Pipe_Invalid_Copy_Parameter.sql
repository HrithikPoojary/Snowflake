use hrms.pipe_schema;


-- not allowed 
create or replace pipe pipe_employee_copy
auto_ingest = true
as 
copy into employees_copy from @aws_pipe_csv_stage
on_error = abort_statement;

--allowed and skip entire file if any one is malformed. 
create or replace pipe pipe_employee_csv
auto_ingest = true 
as 
copy into employees_copy
from @aws_pipe_csv_stage
on_error = skip_file;

--allowed and skips only malformed rows

create or replace pipe pipe_employee_copy
auto_ingest = True 
as 
copy into employees_copy
from @aws_pipe_csv_stage
on_error = continue;

--not allowed 
create or replace pipe pipe_employee_csv
auto_ingest = true
as 
copy into employees_copy
from @aws_pipe_csv_stage
validation_mode = 'return_all_errors';


--not allowed 
create or replace pipe pipe_employee_csv
auto_ingest = true
as 
copy into employees_copy
from @aws_pipe_csv_stage
files = ('employee_part_005.csv');

--not allowed
create or replace pipe pipe_employee_copy
auto_ingest = true 
as 
copy into employees_copy
from @aws_pipe_csv_stage
force = TRUE;


--not allowed (due to deletion delayand it will cause performance issue)
create or replace pipe pipe_employee_csv
auto_ingest = true 
as
copy into employees_copy
from @aws_pipe_csv_stage
purge = true;


--not allwed 
create or replace pipe pipe_employee_copy
auto_ingest = true 
as 
copy into employees_copy
from @aws_pipe_csv_stage
size_limit = 2000;

--not allowed 
create or replace pipe pipe_employee_csv
auto_ingest = true
as 
copy into employees_copy
from @aws_pipe_csv_stage
return_failed_only = true;

--not allowed 
create or replace pipe pipe_employee_csv
auto_ingest = true
as 
copy into employees_copy
from @aws_pipe_csv_stage
validation_mode = return_errors;


select system$pipe_status('pipe_employee_copy');

alter pipe pipe_employee_copy set pipe_execution_paused = True;

select system$pipe_force_resume('pipe_employee_copy');

select information_schema.copy_history(table_name =>'employee_copy',
start_time => dateadd(day,-2,current_timestamp()));

select information_schema.validate_pipe_load()