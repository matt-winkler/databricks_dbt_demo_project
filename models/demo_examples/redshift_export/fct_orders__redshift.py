import pyspark


def model(dbt, session):
    dbt.config(
        materialized = "table",
        submission_method = "all_purpose_cluster",
        cluster_id = '0426-154059-dox4kjfg'
    )
    df = dbt.ref('fct_orders')

    df.write\
      .format("redshift")\
      .option("dbtable", 'fct_orders')\
      .option("dbschema", 'external_source')\
      .option("tempdir", "s3a://matt-w-ml-workflow-bkt/redshift")\
      .option("url", "jdbc:redshift://dbt-sales-demo.cqs4tgbjld3e.us-east-2.redshift.amazonaws.com:5439")\
      .option("user", 'MATT_W')\
      .option("password", 'G0trul3sFA!Q@')\
      .mode("error")\
      .save()

    df.truncate()

    return df