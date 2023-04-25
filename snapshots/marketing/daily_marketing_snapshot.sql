{% snapshot daily_marketing_snapshot %}
    {{
        config(
            unique_key='id',
            strategy='timestamp',
            updated_at='_updated_at',
            target_schema='marketing',
        )
    }}

    select 1 as id, '2022-01-01' as _updated_at union all
    select 2 as id, '2022-01-01' as _updated_at 
 {% endsnapshot %}