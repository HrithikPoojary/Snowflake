use hrms.schedule;
show tasks like '%lvl%';

select system$task_dependents_enable('task_root_lvl0');

show tasks like '%lvl%';

create table task_log(
task_log_id number autoincrement start 1 , increment 1,
task_log_text string,
last_inserted_ts date 
);

alter task task_root_lvl0 suspend;

create task task_log_finalize
warehouse = compute_wh
finalize = task_root_lvl0
as 
begin 

    insert into task_log(task_log_text,last_inserted_ts)
    values('Root task is completed' , current_date);

end;

alter task task_root_lvl0 suspend;

select system$task_dependents_enable('task_root_lvl0');

show tasks;

--error , only involked when the tree task completed
execute task task_log_finalize;

execute task task_root_lvl0;

select * from table(
information_schema.task_history(
scheduled_time_range_start => dateadd('hours',-2,current_timestamp),
scheduled_time_range_end => current_timestamp(),
task_name => 'task_root_lvl0'
)
);

select * from task_log;


alter task task_log_finalize unset finalize;

alter task task_root_lvl0 suspend;

alter task task_log_finalize set finalize = 'task_root_lvl0';




