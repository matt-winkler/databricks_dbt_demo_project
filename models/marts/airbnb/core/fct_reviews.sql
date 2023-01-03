{{ config(materialized='table') }}

select * from {{ ref('stg_airbnb_reviews') }} where 1=1