{{
    config(
        materialized='incremental',
        format='parquet',
        incremental_strategy='merge',
        unique_key='order_key',
        location_root='s3://databricks-to-redshift-tmp/data/'
    )
}}

select * from {{ref('fct_orders')}}
{% if is_incremental() %}
where order_date >= '1998-07-01'
{% else %}
where order_date < '1998-07-01'
{% endif %}