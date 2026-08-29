create schema hrms.etl;

create or replace file format hrms.etl.csv_etl_format
type = csv 
field_delimiter = ','
field_optionally_enclosed_by = '"'
skip_header = 0
null_if = ('Null' , 'NULL')
trim_space = true 
compression = AUTO;

describe file format hrms.etl.csv_etl_format;