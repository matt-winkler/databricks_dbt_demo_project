{% snapshot daily_marketing_snapshot %}
    {{
        config(
            unique_key='id',
            strategy='timestamp',
            updated_at='_updated_at',
            target_schema=generate_schema_name('marketing', this)
        )
    }}

    select 1 as id, '2022-01-01' as _updated_at
 {% endsnapshot %}