{# use this if you want to map the audit testing data into the DAG #}
{# set prod_relation = source('production_data_clones', 'dim_customers') -#}

{% if target.name != 'prod' %}
  
  {% set prod_relation = api.Relation.create(
      database=target.database,
      schema='prod_data_clones',
      identifier='dim_customers',
      type='table'
  ) -%}

  {% set candidate_relation = ref('dim_customers') %}

  {{ audit_helper.compare_relations(
    a_relation=prod_relation,
    b_relation=candidate_relation,
    primary_key="customer_key"
  ) }}

{% endif %}