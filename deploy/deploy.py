import os
import snowflake.connector


conn = snowflake.connector.connect(
    account=os.environ["SNOWFLAKE_ACCOUNT"],
    user=os.environ["SNOWFLAKE_USER"],
    password=os.environ["SNOWFLAKE_PASSWORD"],
    role=os.environ["SNOWFLAKE_ROLE"],
    warehouse=os.environ["SNOWFLAKE_WAREHOUSE"],
    database=os.environ["SNOWFLAKE_DATABASE"],
    schema=os.environ["SNOWFLAKE_SCHEMA"]
)


cursor = conn.cursor()

with open("sql/create_emp_practice_table.sql", "r") as file:
    sql_script = file.read()


cursor.execute(sql_script)

print("Table deployment completed successfully")

cursor.close()
conn.close()