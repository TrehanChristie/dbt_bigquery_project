with stg_order_items as (
    SELECT * FROM {{ source("treytrey_de_project","order_items") }}
)
select 
    cast(order_item_id as STRING) as item_order_id,
    cast(order_item_order_id as STRING) as order_id,
    cast(order_item_product_id as STRING) as product_id,
    order_item_quantity as quantity,
    order_item_subtotal as subtotal,
    order_item_product_price as product_price               
from 
    stg_order_items