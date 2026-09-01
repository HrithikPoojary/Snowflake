use database hrms;

create or replace schema schedule;

use hrms.schedule;

create or replace task task_create_table
warehouse = 'compute_wh'
schedule = '10 minute'  
as 
create or replace table hrms.schedule.employees
as select * from hr.employees;

show tasks;

show tasks like '%TASK%';

describe task task_create_table;

alter task task_create_table resume;

alter task task_create_table suspend;

desc task task_create_table;

use hrms.schedule;
show tables like 'EMPLOYEES';

show tables;

alter task task_create_table resume;

desc task task_create_table;

execute task task_create_table;

show tables;

create or replace task task_create_table
warehouse = compute_wh
schedule = 'using cron 0 7 * * 1-5 America/Chicago'
as 
create or replace table employees 
as select * from hr.employees;

drop task <task_name>


