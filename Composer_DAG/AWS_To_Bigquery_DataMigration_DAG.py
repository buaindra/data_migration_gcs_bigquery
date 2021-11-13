#Make the file as DAG Script
from airflow import DAG

#To Schedule the DAG, we need to import datetime
from datetime import datetime

#Import the Operators
#GCP Transfer Service

#Create DAG object through Context Manager
with DAG("Data_Migration_Dag", start_date=datetime(2021, 11, 13)
    ,schedule_interval="@daily", catchup=False) as dag: