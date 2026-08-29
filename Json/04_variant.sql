use hrms.etl;

create or replace table employee_variant
(
employee_info variant 
);

copy into employee_variant
from @aws_etl_json_stage
files = ('employee_E105.json');

select employee_info['employee_id']::string as employee_id, 
        employee_info['employee_name']::string as employee_name,
        employee_info['position']::string as position,
        employee_info['phone_numbers'][0]::string as phone_numbers1,
        employee_info['phone_numbers'][1]::string as phone_numbers2,
        employee_info['address']['street']::string as street,
        employee_info['address']['city']::string as city,
        employee_info['address']['state']::string as state,
        employee_info['address']['zip_code']::string as zip_code,
        cast(employee_info['skills'][0]['skill_name'] as varchar(20)) as skill_name1,
        cast(employee_info['skills'][0]['proficiency_level']as varchar(20)) as proficiency_level1,
        cast(employee_info['skills'][1]['skill_name']as varchar(20)) as skill_name2,
        cast(employee_info['skills'][1]['proficiency_level']as varchar(20)) as proficiency_level2,
        cast(employee_info['skills'][2]['skill_name']as varchar(20)) as skill_name3,
        cast(employee_info['skills'][2]['proficiency_level']as varchar(20)) as proficiency_level3,
from employee_variant;