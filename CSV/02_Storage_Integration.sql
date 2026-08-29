create or replace storage integration aws_s3_int
type = external_stage
storage_provider = s3
enabled = TRUE 
storage_aws_role_arn = '**'
storage_allowed_locations = ('s3://snowflake-bucket-inv/')
storage_blocked_locations = ('s3://snowflake-bucket-inv/secret_folder/')
comment = 'Demo creating storage integration';


alter storage integration aws_s3_int set enabled = FALSE;

alter storage integration aws_s3_int set storage_allowed_locaions = ('path1' , 'path2');

describe integration aws_s3_int;