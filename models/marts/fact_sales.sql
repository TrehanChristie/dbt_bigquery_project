{{
    config(
        materialized='table',
        tags=['marts']
    )
}}

with stg_orders as (
    select 
        *
    from 
        {{ ref('stg_orders') }}
),
stg_order_items as (
    select 
        *
    from 
        {{ ref('stg_order_items') }}
),
fact_sales as (
    select 
        {{ 
            dbt_utils.generate_surrogate_key(
                ['o.order_id','oi.order_item_id','oi.product_id','o.customer_id','o.order_date']
            ) 
        }} as fact_sales_key,
        {{ dbt_utils.generate_surrogate_key(['o.order_id']) }} as order_key,
        {{ dbt_utils.generate_surrogate_key(['o.order_id','oi.order_item_id']) }} as order_item_key,
        {{ dbt_utils.generate_surrogate_key(['o.order_date']) }} as date_key,
        {{ dbt_utils.generate_surrogate_key(['oi.product_id']) }} as product_key,
        {{ dbt_utils.generate_surrogate_key(['o.customer_id']) }} as customer_key,
        o.order_date,
        o.order_status,
        oi.quantity as item_quantity,
        oi.subtotal as item_total,
    from 
        stg_orders as o
    join 
        stg_order_items as oi
    on 
        o.order_id = oi.order_id
)
SELECT 
    fact_sales_key
    ,order_key
    ,order_item_key
    ,date_key
    ,product_key
    ,customer_key
    ,order_date
    ,order_status
    ,item_quantity
    ,item_total
FROM 
    fact_sales
