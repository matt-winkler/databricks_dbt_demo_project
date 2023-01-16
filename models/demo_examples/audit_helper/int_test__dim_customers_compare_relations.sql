{% set prod_relation = source('production_data_clones', 'prod__dim_customers') -%}
{% set candidate_relation = ref('dim_customers') %}

{{ audit_helper.compare_relations(
    a_relation=prod_relation,
    b_relation=candidate_relation,
    primary_key="customer_key"
) }}