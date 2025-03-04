SELECT 
    oi.order_item_id,
    o.order_id,
    o.customer_id,
    p.product_id,
    d.department_id,
    oi.quantity,
    oi.product_price * oi.quantity AS total_sales_value,
    o.order_date
FROM {{ ref('stg_order_items') }} oi
JOIN {{ ref('stg_orders') }} o ON oi.order_id = o.order_id
JOIN {{ ref('stg_products') }} p ON oi.product_id = p.product_id
JOIN {{ ref('stg_product_categories') }} pc ON pc.product_category_id = p.product_category_id
JOIN {{ ref('stg_departments') }} d ON pc.department_id = d.department_id
