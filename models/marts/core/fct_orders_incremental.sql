{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='order_key'
    )
}}

select * 
from {{ref('fct_orders')}}
{% if is_incremental() %}
where order_key not in (select order_key from {{ this }})
{% endif %}