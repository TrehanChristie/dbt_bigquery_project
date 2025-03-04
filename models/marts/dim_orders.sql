SELECT 
    order_id,
    customer_id,
    order_status,
    order_date
FROM {{ ref('stg_orders') }}
