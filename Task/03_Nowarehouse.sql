use database hrms;

use schema schedule;


create or replace task task_create_table_noware
schedule = '10 minute'
as 
create or replace table employee_noware
as select * from hr.employees;

desc task task_create_table_noware;

execute task task_create_table_noware;

show tables;
drop table employee_noware;

create or replace task task_create_table_noware
user_task_managed_initial_warehouse_size = 'XLARGE'
schedule = '10 minute'
as 
create or replace table employee_noware
as select * from hr.employees;

show tables;

alter task task_create_table_noware resume;

execute task task_create_table_noware;

