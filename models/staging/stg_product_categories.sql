with stg_product_categories as (
    SELECT * FROM {{ source("treytrey_de_project","categories") }}
)
select 
    cast(category_id as STRING) as product_category_id,
    cast(category_department_id as STRING) as department_id,
    category_name as product_category_name
from 
    stg_product_categories
where 
    category_id is not null