use hrms.etl;

create or replace table employee_array
(
employee_info array 
);


copy into employee_array
from @aws_etl_json_stage
files = ('employee_array.json');

select employee_info[0]::string as phone1,
        employee_info[1]::string phone2,
        employee_info[2]::string phone3,
        employee_info[3]::string phone4, --null (no index value)
from employee_array;


with recursive seq as(
select employee_info[0] as phone, 1 as lvl from employee_array 
union all
select employee_info[lvl] , lvl+1 as lvl from seq s
        cross join employee_array
        where s.lvl < (select array_size(employee_info) from employee_array)
)
select phone::string from seq;


