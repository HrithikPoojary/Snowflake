use hrms.etl;

create or replace table employee_object
(
employee_info object 
);

copy into employee_object
from @aws_etl_json_stage
files = ('employee_object.json');

select * from employee_object;

select 
employee_info['employee_id']::string as employee_id,
employee_info['employee_name']::string as employee_name,
employee_info['position']::string as position,
employee_info['address']['city']::string as city,
employee_info['address']['state']::string as state,
employee_info['address']['street']::string  as street,
employee_info['address']['zip_code']::string as zip_code
from employee_object;