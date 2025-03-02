with stg_orders as (
    SELECT * FROM {{ source("treytrey_de_project","orders") }}
)
select 
    cast(order_id as STRING) as order_id,
    order_date,
    cast(order_customer_id as STRING)  as customerid,
    order_status
from stg_orders