use hrms.etl;

create or replace table employee_variant
(
employee_info variant 
);

select * from employee_variant;

copy into employee_variant
from @aws_etl_json_stage
files = ('employees_multi_json_array.json');



select f.value['employee_id']::string as emp_id,
from employee_variant, lateral flatten(employee_info) f;

select employee_info[0] from employee_array
union all 
select employee_info[1] from employee_array
union all 
select employee_info[2] from employee_array;



