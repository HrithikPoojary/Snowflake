use hrms.schedule;

show tasks like '%lvl%';

select * from table(
information_schema.task_dependents(task_name => 'task_root_lvl0',
                                    recursive => false)
);

select name , PREDECESSORS from table(
information_schema.task_dependents(task_name => 'task_root_lvl0',
                                    recursive => false)
);


select name as task_name,
PREDECESSORS as parent_task_name
from table(
information_schema.task_dependents(task_name => 'task_root_lvl0',
                                    recursive => false)
);

select name as task_name,
PREDECESSORS as parent_task_name from table(
information_schema.task_dependents(
task_name => 'c_lvl1_a',
recursive => False 
)
);

select name as task_name,
PREDECESSORS as parent_task_name from table(
information_schema.task_dependents(
task_name => 'ggc_lvl3_h',
recursive => false 
)
);

select name as task_name,
PREDECESSORS as parent_task_name 
from table(
information_schema.task_dependents(
task_name => 'ggc_lvl3_h',
recursive => true 
)
);

