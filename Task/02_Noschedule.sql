use database hrms;
use schema schedule;

create or replace task task_create_table_no_sche
warehouse = compute_wh
as
create or replace table employees_nosche
as select * from hr.employees;

drop table employees;

show tasks like '%TASK%';

alter task task_create_table_no_sche resume;

execute task task_create_table_no_sche;

show tables;