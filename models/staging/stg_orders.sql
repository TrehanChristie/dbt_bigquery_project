with stg_orders as (
    SELECT * FROM {{ source("treytrey_de_project","orders") }}
)
select 
    order_id,
    order_date,
    order_customer_id as customer_id,
    order_status
from stg_orders