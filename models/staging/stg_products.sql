with stg_products as (
    SELECT * FROM {{ source("treytrey_de_project","products") }}
)
select 
    product_id,
    product_cateogry_id as product_category_id,
    product_name,
    product_description,
    product_price
from stg_products