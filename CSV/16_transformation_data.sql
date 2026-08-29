use hrms.etl;

create or replace table hrms.etl.employees_copy
(
employee_id number(6),
first_name varchar(20),
last_name varchar(20),
full_name varchar(40),
email varchar(20),
phone_number varchar(20),
hire_dt date,
job_id varchar(10),
salary number(8,2),
salary_band varchar(10),
commission_pct decimal(2,2),
commission_ind varchar(1),
manager_id number(10),
department_id number(10),
file_name varchar(100),
insert_date date default current_date,
update_date date default current_date 
);

create or replace sequence emp_seq start with 1 increment by 1 order;

select * from information_schema.sequences;


copy into hrms.etl.employees_copy
        (
        employee_id,
        first_name,
        last_name,
        full_name,
        email,
        phone_number,
        hire_dt,
        job_id,
        salary,
        salary_band,
        commission_pct,
        commission_ind,
        manager_id,
        department_id,
        file_name)
from (
        select emp_seq.nextval,
                $2,
                $3,
                trim($2 ||' ' || $3),
                $4,
                $5,
                $6,
                $7,
                cast($8 as decimal(8,2)),
                case when cast($8 as decimal(8,2)) between 0 and 1000
                            then 'Band 1'
                     when cast($8 as decimal(8,2)) between 1001 and 2000
                            then 'Band 2'
                     when cast($8 as decimal(8,2)) between 2001 and 3000
                            then 'Band 3'
                     when cast($8 as decimal(8,2)) between 3001 and 4000
                            then 'Band 4'
                     when cast($8 as decimal(8,2)) between 4001 and 5000
                            then 'Band 5'
                     else   'Band 6'
                     end,
                try_cast($9 as decimal(2,2)),
                case when $9 is null then 'Y' else 'N' end,
                $10,
                $11,
                metadata$filename
                from @aws_etl_csv_stage
)
return_failed_only = True
size_limit = 1000000
on_error = continue
pattern = '.*employee.*[.]csv';
