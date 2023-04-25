{{
    config(
        materialized='table'
    )
}}

select '2022-01-01' as _the_date, 1 as id union all
select '2022-01-02' as _the_date, 2 as id