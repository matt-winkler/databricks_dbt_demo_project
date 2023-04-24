{% test test__compare_relations(model) %}

with validation as (

    select *

    from {{ model }}

    where 
      (in_a = True and in_b = False) 
    or 
      (in_a = False and in_b = True)
)

select *
from validation

{% endtest %}