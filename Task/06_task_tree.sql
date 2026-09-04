use database hrms;

use schema schedule;

create or replace task task_multi_sql
warehouse = compute_wh
as 
begin 
    create table pirates(name varchar(100) , bounty number);
    insert into pirates values('Luffy',1000);
end;

execute task task_multi_sql ;

select * from pirates;

show tasks;


--Task Tree

create or replace table task_analytics(
task_id number,
lvl_id varchar(30),
task_name varchar(30),
update_date timestamp
);

create or replace sequence seq_task_analytics
start with 1 , increment by 1 order;

--root task 
create or replace task task_root_lvl0
warehouse = compute_wh
schedule = '3600 minutes'
as 
begin 
    insert into task_analytics values(seq_task_analytics.nextval,
                                'lvl0',
                                'Task_root_lvl0',
                                current_timestamp
                                );
end;

--child tasks
create or replace task c_lvl1_a
warehouse = compute_wh
--scheduce = '1 minute' (error)
after task_root_lvl0
as 
begin 
    insert into task_analytics values(seq_task_analytics.nextval,
                                     'lvl1',
                                     'c_lvl1_a',
                                     current_timestamp
                                    );
end;

create or replace task c_lvl1_b
warehouse = compute_wh
--scheduce = '1 minute' (error)
after task_root_lvl0
as 
begin 
    insert into task_analytics values(seq_task_analytics.nextval,
                                     'lvl1',
                                     'c_lvl1_b',
                                     current_timestamp
                                    );
end;



create or replace task c_lvl1_c
warehouse = compute_wh
--scheduce = '1 minute' (error)
after task_root_lvl0
as 
begin 
    insert into task_analytics values(seq_task_analytics.nextval,
                                     'lvl1',
                                     'c_lvl1_c',
                                     current_timestamp
                                    );
end;



create or replace task c_lvl1_d
warehouse = compute_wh
--scheduce = '1 minute' (error)
after task_root_lvl0
as 
begin 
    insert into task_analytics values(seq_task_analytics.nextval,
                                     'lvl1',
                                     'c_lvl1_d',
                                     current_timestamp
                                    );
end;

--grand child tasks

create or replace task gc_lvl2_e
warehouse = compute_wh
--scheduce = '1 minute' (error)
after c_lvl1_a
as 
begin 
    insert into task_analytics values(seq_task_analytics.nextval,
                                     'lvl2',
                                     'gc_lvl2_e',
                                     current_timestamp
                                    );
end;



create or replace task gc_lvl2_f
warehouse = compute_wh
--scheduce = '1 minute' (error)
after c_lvl1_a
as 
begin 
    insert into task_analytics values(seq_task_analytics.nextval,
                                     'lvl2',
                                     'gc_lvl2_f',
                                     current_timestamp
                                    );
end;


--grand grand child

create or replace task ggc_lvl3_g
warehouse = compute_wh
--scheduce = '1 minute' (error)
after gc_lvl2_e
as 
begin 
    insert into task_analytics values(seq_task_analytics.nextval,
                                     'lvl3',
                                     'ggc_lvl3_g',
                                     current_timestamp
                                    );
end;


create or replace task ggc_lvl3_h
warehouse = compute_wh
after gc_lvl2_e
as 
begin 
    insert into task_analytics values(seq_task_analytics.nextval,
                                     'lvl3',
                                     'ggc_lvl3_h',
                                     current_timestamp);
end ;



show tasks like '%lvl%';

drop task task_root_lvl0;


alter task C_LVL1_A resume;
alter task C_LVL1_B resume;
alter task C_LVL1_C resume;
alter task C_LVL1_D resume;
alter task GC_LVL2_E resume;
alter task GC_LVL2_F resume;
alter task GGC_LVL3_G resume;
alter task GGC_LVL3_H resume;

select system$task_dependents_enable('task_root_lvl0');


alter task TASK_ROOT_LVL0 suspend;

execute task task_root_lvl0;

select * from task_analytics order by 1 ;

alter task task_root_lvl0 suspend;

select system$task_dependents_enable('task_root_lvl0');

show tasks like '%lvl%';

execute task task_root_lvl0;

truncate table task_analytics;
select * from task_analytics order by 1 ;










