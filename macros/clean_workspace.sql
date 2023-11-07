-- in macros/clean_workspace.sql

{% macro clean_workspace(database_name, schema_name, table_name_like='*') %}

  {% set drop_schema_sql %}
   {# show tables from schema {{ database_name }}.{{ schema_name }} like '{{ table_name_like }}'; #}
     drop schema {{ database_name }}.{{ schema_name }} cascade;
  {% endset %}

  {% do run_query(drop_schema_sql) %}

{% endmacro %}