{{
    config(
        materialized='incremental',
        unique_key='id',
        incremental_strategy='merge',
        partition_by='_the_date'
    )
}}

select '2022-01-01' as _the_date, 1 as id union all
select '2022-01-02' as _the_date, 2 as id