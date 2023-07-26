
def model(dbt, session):

    dbt.config(
        materialized="table",
        submission_method="all_purpose_cluster",
        cluster_id='0726-173717-sxjo9d1v'
    )

    df = dbt.ref('fct_orders')

    df.write.format("redshift")\
      .option("dbtable", 'fct_orders')\
      .option("search_path", 'databricks_source')\
      .option("tempdir", "s3a://databricks-to-redshift-tmp/data/")\
      .option("url", "jdbc:redshift://redshift-matt-w-write-test.cbi8ojn2vhds.us-east-1.redshift.amazonaws.com:5439")\
      .option("user", 'awsuser')\
      .option("tempformat", "csv gzip")\
      .option("password", 'G0trul3sFA!Q')\
      .option("aws_iam_role", 'arn:aws:iam::486758181003:role/RedshiftS3AccessPolicy')\
      .mode("overwrite")\
      .save()

    return df