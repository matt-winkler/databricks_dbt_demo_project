{%- macro get_json_schema_string_from_dict(_dict) -%}
   
   {%- set result = [] -%}

   {%- for key, value in _dict.items() -%}
     
     {%- if value == 'STRING' -%}
        
        {%- set to_append = key + ': ' + value -%}
        {%- do result.append(to_append) -%}

     {%- elif value is mapping -%}
        
        {%- set to_append = key + ' STRUCT<' + get_json_schema_string_from_dict(value) + '>' -%}
        {%- do result.append(to_append) -%}

     {%- endif -%}

   {%- endfor -%}

   {{ return(result|join(',')) }}

{%- endmacro -%}