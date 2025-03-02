SELECT 
    order_id,
    customerid,
    order_status,
    order_date
FROM {{ ref('stg_orders') }}
