use hrms.schedule;

create or replace table employee_dim_merge(
employee_id number ,
first_name string,
last_name string,
email string,
phone_number string,
hire_date date,
job_id string,
salary number(8,2),
commission_pct number(8,2),
manager_id integer,
department_id integer,
last_updated_ts timestamp,
last_inserted_ts timestamp 
);

create or replace task task_employee_dim_merge
warehouse = compute_wh
schedule = '3600 minutes'
as 
merge into  employee_dim_merge em 
using hr.employees e 
on em.employee_id = e.employee_id
when matched then 
update set em.salary  = e.salary,
last_updated_ts = current_timestamp()
when not matched then 
insert values(
e.employee_id  ,
e.first_name ,
e.last_name ,
e.email ,
e.phone_number ,
e.hire_date ,
e.job_id ,
e.salary ,
e.commission_pct ,
e.manager_id ,
e.department_id ,
null,
current_timestamp()
);

show tasks like '%merge%';

alter task TASK_EMPLOYEE_DIM_MERGE resume;

execute task TASK_EMPLOYEE_DIM_MERGE;

select * from employee_dim_merge;

select count(*) from employee_dim_merge
union all
select count(*) from hr.employees;

update employee_dim_merge
set salary = 0;

show tasks;

alter task TASK_EMPLOYEE_DIM_MERGE suspend;