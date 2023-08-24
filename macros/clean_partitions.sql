{% macro clean_partitions() %}
   
   {% set delete_sql %}
     delete from matt_winkler_dev.dbt_mwinkler.fct_orders_incremental where order_date >= '1992-06-01';
   {% endset %}

   {{run_query(delete_sql)}}

   {% set vacuum_sql %}
     VACUUM matt_winkler_dev.dbt_mwinkler.fct_orders_incremental RETAIN 0 HOURS
   {% endset %}

{% endmacro %}