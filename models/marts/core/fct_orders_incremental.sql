{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='order_key',
        location_root='s3://databricks-to-redshift-tmp/data/',
        post_hook=[
            'GENERATE symlink_format_manifest FOR TABLE {{this}}',
            'ALTER TABLE {{this}} SET TBLPROPERTIES(delta.compatibility.symlinkFormatManifest.enabled=true)'
        ]
    )
}}

select * 
from {{ref('fct_orders')}}

{% if is_incremental() %}
where order_date >= '1998-06-01'

{% else %}
where order_date < '1998-07-01'

{% endif %}