SELECT 
    customerid,
    first_name,
    last_name,
    street,
    city,
    state,
    zipcode
FROM {{ ref('stg_customers') }}
