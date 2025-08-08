### Setting up Airflow

- Make sure you in correct repo (cd to get it it)
    - You can check by ```pwd```
- ```mkdir airflow-home```
    - This creates a folder in VScode called 'airflow-home'

```export AIRFLOW_VERSION=3.0.2```
```export PYTHON_VERSION=3.12```
```pip install "apache-airflow[postgres,amazon]"=="${AIRFLOW_VERSION}" \
  --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt" ```

- initialize airflow db ```airflow db init```

-create an admin user (obviously this is testing it)
airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com
    --password admin123