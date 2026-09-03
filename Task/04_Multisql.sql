use database hrms;
use schema schedule;

create table employees_cpy (emp_id number , first_name varchar(20), last_name varchar(20));

drop table employees_cpy;

--error 
create or replace task task_create_table_multisql
warehouse = compute_wh
schedule = '1 minute'
as 
create table employees_cpy (emp_id number , first_name varchar(20), last_name varchar(20))
insert into employees_cpy values(1,'Monkey D' , 'Luffy');

drop table employees_cpy;

create or replace task task_create_table_multisql
warehouse = compute_wh
schedule = '1 minute'
as 
begin 

    create table employees_cpy (emp_id number , first_name varchar(20), last_name varchar(20));

    insert into employees_cpy values(10,'Monkey D' , 'Luffy');

end;


alter task task_create_table_multisql resume;

execute task task_create_table_multisql;

select * from employees_cpy;


create or replace procedure sp_task_create_table()
returns string 
as
begin 

    create table employees_cpy (emp_id number , first_name varchar(20), last_name varchar(20));

    insert into employees_cpy values(10,'Roronoa' , 'Zoro');

end;

create or replace task task_create_table_multisql
warehouse = compute_wh
schedule = '1 minute'
as 
call sp_task_create_table();

alter task task_create_table_multisql resume;

execute task task_create_table_multisql;

select * from employees_cpy;

show tables like '%CPY%';








