{{
    config(
        materialized = 'insert_by_period',
        period = 'day',
		timestamp_field = 'the_date',
		start_date = var('start_date', '2024-01-01'),
		stop_date = var('stop_date', '2024-01-05'),
        enabled = (target.type == 'databricks')
    )
}}

with the_data as (
    select '2024-01-01' as the_date, 'foo' as column_a union all
    select '2024-01-02' as the_date, 'bar' as column_a union all
    select '2024-01-03' as the_date, 'baz' as column_a union all
    select '2024-01-04' as the_date, 'qux' as column_a union all
    select '2024-01-05' as the_date, 'quux' as column_a
)

select *
from the_data
where __PERIOD_FILTER__