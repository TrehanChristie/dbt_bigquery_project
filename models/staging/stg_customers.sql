with stg_customers as (
    SELECT * FROM {{ source("treytrey_de_project","customers") }}
)
select 
    cast(customer_id as STRING) as customerid,
    customer_fname as first_name,
    customer_lname as last_name,
    customer_street as street,
    customer_city as city,
    customer_state as state,
    customer_zipcode as zipcode
from 
    stg_customers