{% macro generate_schema_name(custom_schema_name, node) -%}
    
    {%- set default_schema = target.schema -%}
    {%- set schema_prefix = target.name if target.name == 'ci' else '' -%}
    
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
       
       {%- if custom_schema_name is none -%}

        {{ default_schema }}

      {%- else -%}

        {{ default_schema }}_{{ custom_schema_name | trim }}
       
      {%- endif -%}

    {%- endif -%}

{%- endmacro %}
