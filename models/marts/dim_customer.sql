{{
    config(
        materialized='table',
        tags=['marts']
    )
}}

with stg_customers as (
    select * from {{ ref('stg_customers') }}
),
dim_customers as (
    select
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
        customer_id,
        first_name,
        last_name,
        street,
        city,
        state,
        zipcode
    from
        stg_customers
)
select
    customer_key,
    customer_id,
    first_name,
    last_name,
    street,
    city,
    state,
    zipcode
from
    dim_customers
