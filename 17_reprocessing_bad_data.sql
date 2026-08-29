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


copy into hrms.etl.employees_copy
from @aws_etl_csv_stage
on_error = continue;


select * from table(validate(hrms.etl.employees_copy , job_id => '01c6b661-000d-f061-0001-e34a0004021e'));

create or replace table employee_copy_rejected_rows
as select REJECTED_RECORD from table(validate(hrms.etl.employees_copy , job_id => '01c6b661-000d-f061-0001-e34a0004021e'));


select * from employee_copy_rejected_rows;

select split_part(rejected_record,',',1) as emp_id,
        split_part(rejected_record,',',2) first_name,
        split_part(rejected_record,',',3) last_name,
        split_part(rejected_record,',',4) email,
        split_part(rejected_record,',',5) phone_number,
        cast(regexp_replace(split_part(rejected_record,',',6) , '"' , '')  as date ) hire_dt,
        cast(split_part(rejected_record,',',7) as varchar(40) )job_id,
        cast(replace(split_part(rejected_record,',',8) , 'DOLLAR' , '') as decimal(8,2)) as good_record,
        cast(regexp_replace(split_part(rejected_record,',',8) , '[0-9]' , '') as varchar(40)) as good_record,
        replace(split_part(rejected_record,',',9),'Null','NULL') compenssion_pct,
        split_part(rejected_record,',',10) manager_id,
        split_part(rejected_record,',',11) department

from employee_copy_rejected_rows;

select split(rejected_record,',')[0],
        replace(split(rejected_record,',')[1],' "\"' , '')
        from employee_copy_rejected_rows;

insert into employees_copy
select split_part(rejected_record,',',1) as emp_id,
        split_part(rejected_record,',',2) first_name,
        split_part(rejected_record,',',3) last_name,
        split_part(rejected_record,',',4) email,
        split_part(rejected_record,',',5) phone_number,
        cast(regexp_replace(split_part(rejected_record,',',6) , '"' , '')  as date ) hire_dt,
        cast(split_part(rejected_record,',',7) as varchar(40) )job_id,
        cast(replace(split_part(rejected_record,',',8) , 'DOLLAR' , '') as decimal(8,2)) as good_record,
        replace(split_part(rejected_record,',',9),'Null',NULL) compenssion_pct,
        split_part(rejected_record,',',10) manager_id,
        split_part(rejected_record,',',11) department
        from employee_copy_rejected_rows;


        select (split_part(rejected_record,',',6) ) hire_dt from employee_copy_rejected_rows;

        select cast('2006-01-03' as date);


        select * from table(information_schema.copy_history(table_name => 'hrms.etl.employees_copy',
                                            start_time => dateadd(hours,-1,current_timestamp())));

        dateadd(<unit of time> , value , <starting_time>)
        unit of time -> day , month , year , hour 
        value -> positive forward , negative backward
        starting_time -> from which time 