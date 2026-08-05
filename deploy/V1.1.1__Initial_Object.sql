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
    (1000, 'John', 50000),
    (1029, 'David', 60000),
    (1038, 'Smith', 55000),
    (1074, 'Alice', 70000),
    (1075, 'Robert', 65000),
    (1076, 'Emma', 72000),
    (1077, 'Michael', 58000),
    (1078, 'Sophia', 80000),
    (1079, 'James', 62000),
    (1170, 'Olivia', 75000);

-- Verify Data
create table EMP_COPY_PRACTICE as SELECT * FROM EMP_PRACTICE_TABLE;