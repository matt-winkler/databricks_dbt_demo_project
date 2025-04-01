{{ config(
    materialized='incremental',
    incremental_strategy='microbatch',
    event_time='order_date',
    begin='1992-01-01',
    batch_size='year',
    lookback=1,
    concurrent_batches=True
)}}

select * 
from {{ ref('fct_orders') }}

-- first run - 1992
-- dbt run -s fct_orders_microbatch --event-time-start "1992-01-01" --event-time-end "1993-01-01" --full-refresh

-- second run - 1993
-- dbt run -s fct_orders_microbatch --event-time-start "1993-01-01" --event-time-end "1994-01-01"

-- third run - process the rest of the data up to today
-- dbt run -s fct_orders_microbatch --event-time-start "1994-01-01" --event-time-end "2025-01-01"

-- fourth run -- do the rest, including the configured lookback period
-- dbt run -s fct_orders_microbatch