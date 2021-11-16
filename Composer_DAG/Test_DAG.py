#Ref: https://airflow.apache.org/docs/apache-airflow/stable/concepts/dags.html
#https://airflow.apache.org/docs/apache-airflow/1.10.10/howto/operator/gcp/transfer.html
#https://cloud.google.com/storage-transfer/docs/reference/rest/v1/transferJobs/create


#Make the file as DAG Script
from airflow import DAG

#To Schedule the DAG, we need to import datetime
from datetime import datetime

#Import the Operators
#GCP Transfer Service

#Create DAG object through Context Manager
with DAG("Data_Migration_Dag", start_date=datetime(2021, 11, 13)
    ,schedule_interval="@daily", catchup=False) as dag: