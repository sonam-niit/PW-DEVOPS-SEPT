DB_CONFIG = {
    # 'host': 'localhost',
    'host': 'mysql', # DB Service which is mysql mentioned in compose file
    'user': 'root',
    'password': 'admin',
    'database': 'flaskapp'
}

## My Mysql-connector-python version is 9.2
## My local mysql version is 8.4 
## pip uninstall mysql-connector-python 
## pip install mysql-connector-python==8.4.0
