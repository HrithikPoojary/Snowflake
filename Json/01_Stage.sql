use hrms.etl;

create or replace file format json_file_format
type = json;


create or replace stage aws_etl_json_stage
  CREDENTIALS = (
    AWS_KEY_ID = '***'
    AWS_SECRET_KEY = '**'
  )
url = 's3://snowflake-bucket-inv/loadingdata/json/'
file_format = json_file_format;

list @aws_etl_json_stage;