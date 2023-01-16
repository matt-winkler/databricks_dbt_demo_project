{% macro clone_prod_to_target() %}
   
  {% set clone_sql %}
    
    create or replace table matt_winkler_{{target.name}}.prod_data_clones.dim_customers
    deep clone matt_winkler_prod.analytics.dim_customers

  {% endset %}

  {% do run_query(clone_sql) %}

{% endmacro %}