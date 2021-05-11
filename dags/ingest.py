import json
import os
from datetime import datetime
from pathlib import Path

from airflow import DAG
from airflow.operators.postgres_operator import PostgresOperator

from config import Config
from loader import Loader
from utilsfile import config_reader

cfg = Config()
PARENT_PATH = os.fspath(Path(__file__).parents[1])
CONFIG_PATH = os.path.join(
    PARENT_PATH,
    "configurations",
    "settings.ini")

FILE_TEMP_STORE = os.path.join(PARENT_PATH,config_reader(CONFIG_PATH, "db_config")["filename"])
INSERT = os.path.join(PARENT_PATH,config_reader(CONFIG_PATH, "db_config")["insert"])

sql = Loader()
sql_query_data = f"""{sql.load(INSERT)}"""


dag_params = {
    'dag_id': 'Ingest',
    'start_date': datetime(2021, 5, 8),
    'schedule_interval': None
}

with DAG(**dag_params, template_searchpath=[cfg.dir_dag_template]) as dag:
    create_extension_task = PostgresOperator(
        task_id='create_extension',
        sql="create_extension.sql",
        postgres_conn_id="connections"
    )

    create_target_table = PostgresOperator(
        task_id='create_table',
        sql="create_target_tables.sql",
        postgres_conn_id="connections"
    )

    insert_target_table = PostgresOperator(
        task_id='insert_target_table',
        sql=sql_query_data.format(json.dumps(json.loads(sql.load(FILE_TEMP_STORE)), ensure_ascii=False).replace("'", "''")),
        postgres_conn_id="connections"
    )

    insert_target_dm_action_type = PostgresOperator(
        task_id='insert_target_dm_action_type',
        sql="insert_target_dm_action_type.sql",
        postgres_conn_id="connections"
    )

    insert_target_dm_yy_mm_dd = PostgresOperator(
        task_id='insert_target_dm_yy_mm_dd',
        sql="insert_target_dm_yy_mm_dd.sql",
        postgres_conn_id="connections"
    )

    insert_target_dm_dob = PostgresOperator(
        task_id='insert_target_dm_dob',
        sql="insert_target_dm_dob.sql",
        postgres_conn_id="connections"
    )    
    
    insert_target_dm_product = PostgresOperator(
        task_id='insert_target_dm_product',
        sql="insert_target_dm_product.sql",
        postgres_conn_id="connections"
    )

    insert_target_dm_users = PostgresOperator(
        task_id='insert_target_dm_users',
        sql="insert_target_dm_users.sql",
        postgres_conn_id="connections"
    )

    insert_target_ft_tbl = PostgresOperator(
        task_id='insert_target_ft_tbl',
        sql="insert_target_ft_tbl.sql",
        postgres_conn_id="connections"
    )

    insert_target_ft_order_fulfilled_cancelled = PostgresOperator(
        task_id='insert_target_ft_order_fulfilled_cancelled',
        sql="insert_target_ft_order_fulfilled_cancelled.sql",
        postgres_conn_id="connections"
    )

    create_extension_task >> create_target_table >> insert_target_table >> insert_target_dm_yy_mm_dd >> [insert_target_dm_action_type,insert_target_dm_dob,insert_target_dm_product,insert_target_ft_order_fulfilled_cancelled] >> insert_target_dm_users >> insert_target_ft_tbl
