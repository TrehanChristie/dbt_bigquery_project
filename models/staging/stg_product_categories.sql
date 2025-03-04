with stg_product_categories as (
    SELECT * FROM {{ source("treytrey_de_project","categories") }}
)
select 
    category_id as product_category_id,
    case 
        when category_department_id = 2 then 1
        when category_department_id = 3 then 2
        when category_department_id = 4 then 3
        when category_department_id = 5 then 4
        when category_department_id = 6 then 5
        when category_department_id = 7 then 6
        when category_department_id = 8 then 7
        else category_department_id
    end as department_id,
    category_name as product_category_name
from 
    stg_product_categories
where 
    category_id is not null