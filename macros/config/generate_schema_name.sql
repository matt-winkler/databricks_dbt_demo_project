{% macro generate_schema_name(custom_schema_name, node) -%}
    
    {%- set default_schema = target.schema -%}
    {%- set schema_prefix = target.name if target.name == 'ci' else '' -%}
    {%- set pr_build_id = env_var('DBT_CLOUD_PR_ID', '') if target.name == 'ci' else '' -%}
    
    {# behavior for models #}
    {%- if node.resource_type == 'model' -%}

      {{ log('in model code path', info=true) }}

      {%- if custom_schema_name is none -%}

        {{ default_schema }}

      {%- else -%}

        {{ default_schema }}_{{ custom_schema_name | trim }}
       
      {%- endif -%}
     
    {# behavior for snapshots #}
    {%- else -%}
       
       {%- if custom_schema_name is none and pr_build_id == '' -%}

        {{ default_schema }}
       
      {%- elif custom_schema_name is none and pr_build_id != '' %}
         
         {{ pr_build_id }}_{{ default_schema }}
        
      {%- elif custom_schema_name is not none and pr_build_id == '' -%}
         
         {{ default_schema }}_{{ custom_schema_name | trim }}

      {%- else -%}

        {{ pr_build_id }}_{{ default_schema }}_{{ custom_schema_name | trim }}
       
      {%- endif -%}

    {%- endif -%}

{%- endmacro %}
