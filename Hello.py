import pandas as pd
import snowflake.connector as sf
from snowflake.connector.pandas_tools import write_pandas

# 1. Load the CSV file into a Pandas DataFrame
# Ensure column names are uppercase to match Snowflake's default naming convention
df = pd.read_csv("C:/Users/cvvas/Downloads/employees100.csv")
df.columns = [col.upper() for col in df.columns]

# 2. Establish connection to Snowflake
connection=sf.connect(user='vasudevasfd1',
                      password='Vasudeva.sfd@2',
                      account='VSVIQPA-PNB64616',
                      database='MYDB',
                      schema='MYSCHEMA'
                      )
print(df)
try:
    # 3. Write DataFrame directly into Snowflake
    success, nchunks, nrows, _ = write_pandas(connection, df, 'employee_data_data', auto_create_table=True)
  
    if success:
        print(f"Successfully loaded {nrows} rows across {nchunks} chunk(s)!")
    else:
        print("Data upload failed.")

finally:
    # 4. Always close the connection
    connection.close()



    

