with stg_products as (
    SELECT * FROM {{ source("treytrey_de_project","products") }}
)
select 
    cast(product_id as STRING) as product_id,
    cast(product_cateogry_id as STRING) as product_category_id,
    product_name,
    product_description,
    product_price
from stg_products