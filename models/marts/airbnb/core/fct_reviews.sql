{{ config(materialized='table') }}

select * from {{ ref('stg_airbnb_reviews') }} where true