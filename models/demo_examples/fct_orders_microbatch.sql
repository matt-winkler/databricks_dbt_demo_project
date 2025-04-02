{# 
  Usage notes
  - make sure the event_time config is set on the macrobatch model and any models / sources it pulls from 
  - he lookback config determines the default number of batches
  - se concurrent_batches to accelerate processing
  - se dbt retry -s my_model to reprocess failed batches when needed
  - verride default batches and begin / end dates by passing --event-time-start and --event-time-end to dbt run
  - bt will attempt to process batches up to the current time (aka not the last business date from upstream tables)
  - do not pass the --full-refresh flag without including --event-time-start and --event-time-end; it does nothing otherwise 

Example command flow:
-- first run: create the table for one specific set of dates (for illustration purposes)
-- dbt run -s fct_orders_microbatch --event-time-start "2019-01-01" --event-time-end "2020-01-01" --full-refresh

-- second run - fill in the current year and prior year data
-- dbt run -s fct_orders_microbatch
-- this did nothing because the lookback config pulls 1 year earlier than current (2024), plus the current year

-- backfill run
-- dbt run -s fct_orders_microbatch --event-time-start "2020-01-01" --event-time-end "2024-01-01"
#}

{{ config(
    materialized='incremental',
    incremental_strategy='microbatch',
    event_time='order_date',
    begin='2019-01-01',
    batch_size='year',
    lookback=1, 
    concurrent_batches=True
)}}

select * 
from {{ ref('fct_orders_updated') }}