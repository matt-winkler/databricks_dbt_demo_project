{{
    config(
        materialized = 'table',
        tags=['finance']
    )
}}


with orders as (
    
    select * from {{ ref('stg_tpch_orders') }}

),
order_item as (
    
    select * from {{ ref('order_items') }}

),

order_item_summary as (

    select 
        order_key,
        sum(1) as my_sum,
        sum(gross_item_sales_amount) as gross_item_sales_amount,
        sum(item_discount_amount) as item_discount_amount,
        sum(item_tax_amount) as item_tax_amount,
        sum(net_item_sales_amount) as net_item_sales_amount
    from order_item
    group by
        1
),
final as (

    select 
        
        {{dbt_utils.generate_surrogate_key(
            ['orders.order_key', 'orders.order_date']
            )}} as order_uuid,
        orders.order_key, 
        orders.order_date,
        orders.customer_key,
        orders.status_code,
        orders.priority_code,
        orders.clerk_name,
        case
        when status_code = 'F' then 1 * int(left(priority_code, 1))
        when status_code = 'O' then 2 * int(left(priority_code, 1))
        when status_code = 'P' then 3 * int(left(priority_code, 1))
        else 0 end as risk_score,
        orders.ship_priority,
                
        1 as order_count,                
        order_item_summary.gross_item_sales_amount,
        order_item_summary.item_discount_amount,
        order_item_summary.item_tax_amount,
        order_item_summary.net_item_sales_amount
    from
        orders
        inner join order_item_summary
            on orders.order_key = order_item_summary.order_key
)
select 
    *
from
    final

order by
    order_date