select employee_info['phone_numbers'] ,
        f.*
from employee_variant , lateral flatten(employee_info['phone_numbers']) f;


select employee_info['phone_numbers'] ,
        f.value
from employee_variant , lateral flatten(employee_info['phone_numbers']) f;

select employee_info['skills'],
f.value['proficiency_level']::string as proficiency_level,
f.value['skill_name']::string as skill_name,
from employee_variant , lateral flatten (employee_info['skills']) f;

select * from employee_variant;

select employee_info['employee_name'],
pn.value::string ,
s.value['skill_name'] as skill_name,
s.value['proficiency_level'] as proficiency_level
from employee_variant ,
lateral flatten(employee_info['phone_numbers']) pn,
lateral flatten(employee_info['skills']) s;