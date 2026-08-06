

CREATE OR REPLACE DATABASE ERICSSON_DB;
USE DATABASE ERICSSON_DB;

CREATE OR REPLACE SCHEMA ERICSSON_SCHEMA;
USE SCHEMA ERICSSON_SCHEMA;


create or replace storage integration s3_int
  type = external_stage
  storage_provider = 's3'
  enabled = true
  storage_aws_role_arn = 'arn:aws:iam::039108689921:role/AWS_ROLE2026'
  storage_allowed_locations = ('s3://s3bucketsflocation/CSV/');


create or replace file format csv_format
  type = csv
  field_delimiter = ','
  skip_header = 1
  field_optionally_enclosed_by = '"'
  null_if = ('', 'NULL')
  empty_field_as_null = true;

 create or replace stage s3_stage
  url = 's3://s3bucketsflocation/CSV/'
  storage_integration = s3_int
  file_format = csv_format;

CREATE OR REPLACE TABLE EMP_STAGE
(
    EMP_ID INT,
    EMP_NAME STRING,
    SALARY NUMBER
);

CREATE OR REPLACE PIPE emp_pipp
AUTO_INGEST = TRUE
AS
COPY INTO EMP_STAGE
FROM @S3_STAGE
FILE_FORMAT = (FORMAT_NAME = CSV_FORMAT)
ON_ERROR = CONTINUE;

CREATE OR REPLACE STREAM EMP_STREAM
ON TABLE EMP_STAGE;

CREATE OR REPLACE TABLE EMP_MASTER
(
    EMP_ID INT,
    EMP_NAME STRING,
    SALARY NUMBER,
    LOAD_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

CREATE OR REPLACE TASK LOAD_EMP_TASK
WAREHOUSE = COMPUTE_WH
SCHEDULE = '1 MINUTE'
WHEN
SYSTEM$STREAM_HAS_DATA('EMP_STREAM')
AS

INSERT INTO EMP_MASTER
(
    EMP_ID,
    EMP_NAME,
    SALARY
)
SELECT
    EMP_ID,
    EMP_NAME,
    SALARY
FROM EMP_STREAM;

ALTER TASK LOAD_EMP_TASK RESUME;




