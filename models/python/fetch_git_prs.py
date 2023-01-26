import requests
import pandas as pd

def model(dbt, spark):
    dbt.config(
        materialized='table',
        catalog='hive_metastore',
        create_notebook=False,
        cluster_id='0408-145556-egmplhh0',
        packages = ['requests', 'pandas'] # how to import python libraries in dbt's context
    )
    # github username
    owner = "matt-winkler"
    headers = {'Authorization': 'token ' + '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'}
    # url to request
    url = f"https://api.github.com/repos/{owner}/databricks_dbt_demo_project/pulls"
    # make the request and return the json
    user_data = requests.get(url, headers=headers).json()
    # load the user_data to a dictionary
    df = pd.DataFrame(user_data, index=[0])

    return df
