{{
  config(
    materialized = "insert_by_period",
    period = "day",
    timestamp_field = "order_date",
    start_date = var("start_date", "1992-01-01"),
    pre_hook='truncate table {{this}};'
    )
}}

with events as (
  select *
  from {{ ref('fct_orders') }}
  where __PERIOD_FILTER__
)

select * from events