{{
    config(
        materialized='table',
        tags=['marts']
    )
}}

with stg_products as (
    select 
        *
    from 
        {{ ref("stg_products") }}
),
stg_product_categories as (
    select 
        *
    from 
        {{ ref("stg_product_categories") }}
),
stg_departments as (
    select 
        *
    from 
        {{ ref("stg_departments") }}
),
dim_products as (

    SELECT 
        {{ dbt_utils.generate_surrogate_key(['p.product_id']) }} as product_key,
        p.product_id,
        p.product_name,
        pc.product_category_name,
        d.department_name,
        p.product_price

    FROM 
        stg_products as p
    JOIN 
        stg_product_categories as pc 
    ON 
        p.product_category_id = pc.product_category_id
    JOIN
        stg_departments as d
    ON
        pc.department_id = d.department_id
)
select 
    product_key,
    product_id,
    product_name,
    product_category_name,
    department_name,
    product_price,
from 
    dim_products

