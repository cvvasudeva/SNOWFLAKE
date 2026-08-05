-- Create Table
CREATE OR REPLACE TABLE EMP_PRACTICE_TABLE
(
    EMP_ID INT,
    EMP_NAME VARCHAR,
    SALARY INT,
    UPDATEON TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Insert Sample Records
INSERT INTO EMP_PRACTICE_TABLE (EMP_ID, EMP_NAME, SALARY)
VALUES
    (101, 'John', 50000),
    (102, 'David', 60000),
    (103, 'Smith', 55000),
    (104, 'Alice', 70000),
    (105, 'Robert', 65000),
    (106, 'Emma', 72000),
    (107, 'Michael', 58000),
    (108, 'Sophia', 80000),
    (109, 'James', 62000),
    (110, 'Olivia', 75000);

-- Verify Data
create table EMP_COPY_PRACTICE as SELECT * FROM EMP_PRACTICE_TABLE;