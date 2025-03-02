SELECT 
    p.product_id,
    p.product_name,
    pc.product_category_id,
    pc.product_category_name,
    p.product_price,
    pc.department_id
FROM {{ ref('stg_products') }} p
JOIN {{ ref('stg_product_categories') }} pc 
    ON p.product_category_id = pc.product_category_id
