#Importing libraries
import datetime as dt
import airflow
from airflow.operators import bash_operator

yesterday = dt.datetime.today() - dt.timedelta(days=1)

default_args = {
    "owner": "indranil pal",
    "depends_on_past": False,
    "email": [""],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": dt.timedelta(minutes=5),
    "start_date": yesterday
}

with airflow.DAG(
    "sample_dag",
    "catchup=False",
    default_args = default_args,
    schedule_interval = dt.timedelta(days=1)
) as dag:
    print_dag_run_conf = bash_operator.BashOperator(
        task_id = "print_dag_run_conf", bash_command="echo {{dag_run.id}}")