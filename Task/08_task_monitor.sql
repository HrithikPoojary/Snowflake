use hrms.schedule;


select * from table(
information_schema.task_history(
scheduled_time_range_start => dateadd('hours',-2, current_timestamp()),
scheduled_time_range_end => current_timestamp(),
task_name => 'task_root_lvl0',
error_only => false
)
);


select * from table(
information_schema.task_history(
scheduled_time_range_start => dateadd('hours',-2, current_timestamp()),
scheduled_time_range_end => current_timestamp(),
task_name => 'task_root_lvl0',
error_only => true
)
);

show tasks like '%lvl%';

alter task task_root_lvl0 suspend;
