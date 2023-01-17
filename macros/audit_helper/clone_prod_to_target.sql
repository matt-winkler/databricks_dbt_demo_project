{% macro 
   
   clone_prod_to_target(
    prod_schema='analytics', 
    prod_catalog='matt_winkler_prod', 
    target_schema='prod_data_clones', 
    target_database=target.database
    ) 
%}
   
  {% set table_sql %}
    show tables in {{prod_catalog}}.{{prod_schema}};
  {% endset %}

  {% set view_sql %}
    show views in {{prod_catalog}}.{{prod_schema}};
  {% endset %}

  {% set view_use_sql %}
     use catalog {{prod_catalog}};
  {% endset %}

  {% set production_tables = run_query(table_sql) %}
  {% do run_query(view_use_sql) %}
  {% set production_views = run_query(view_sql) %}

  {% if execute %}
    
    {# Return the second column which holds the table / view names from the results#}
    {% set table_results = production_tables.columns[1].values() %}
    {% set view_results = production_views.columns[1].values() %}
  
  {% else %}
    
    {% set table_results = [] %}
    {% set view_results = [] %}
  
  {% endif %}

  {% for table_name in table_results %}
   
   {% if table_name not in view_results %}
     
     {% set sql %}
       create or replace table {{target_database}}.{{target_schema}}.{{table_name}}
        deep clone {{prod_catalog}}.{{prod_schema}}.{{table_name}};
     {% endset %}

     {% do run_query(sql) %}
   
   {% endif %}
   
  {% endfor %}

{% endmacro %}