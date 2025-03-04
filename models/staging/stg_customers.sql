with stg_customers as (
    SELECT * FROM {{ source("treytrey_de_project","customers") }}
)
select 
    customer_id as customer_id,
    customer_fname as first_name,
    customer_lname as last_name,
    customer_street as street,
    customer_city as city,
    customer_state as state,
    customer_zipcode as zipcode
from 
    stg_customers