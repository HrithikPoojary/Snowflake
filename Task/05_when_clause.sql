use database hrms;
use schema schedule;


create or replace task task_create_table
warehouse = compute_wh
schedule = '1 minute'
when 1 = 2
as 
create or replace table employees_when
as select * from hr.employees;

show tasks;

alter task task_create_table resume;

execute task task_create_table;

show table like '%WHEN%';

describe task task_create_table;

--true

create or replace task task_create_table_true
warehouse = compute_wh
schedule = '1 minute'
when true 
as 
create or replace table employees_when_true
as select * from hr.employees;

show tasks like '%true%';

alter task task_create_table_true resume;

execute task task_create_table_true;
show tables like '%when%';

show tasks;

alter task TASK_CREATE_TABLE_TRUE suspend;