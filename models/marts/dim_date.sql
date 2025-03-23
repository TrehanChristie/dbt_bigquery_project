{{
    config(
        materialized='table',
        tags=['marts']
    )
}}

with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="'2013-01-01'",
        end_date="'2014-12-31'"
    ) 
    }}
),
dim_date as (
    select
        cast(date_day as date) as full_date,
        extract(year from date_day) as year_number,   
        extract(month from date_day) as month_number,    
        format_date('%b', date_day) as month_name,      -- month name (e.g. "jan")          
        extract(day from date_day) as day_number,      
        extract(week from date_day) as week_number,
        format_date('%a', date_day) as week_name,        -- weekday name (e.g. "mon")
        extract(quarter from date_day) as quarter_of_year,
        safe_cast(
            case 
                when extract(month from date_day) = 1 and extract(day from date_day) = 1 then 'new years day'
                when extract(month from date_day) = 12 and extract(day from date_day) = 25 then 'christmas day'
                else null 
            end as string
        ) as holiday_desc,
        safe_cast(
            case 
                when extract(month from date_day) = 1 and extract(day from date_day) = 1 then true
                when extract(month from date_day) = 12 and extract(day from date_day) = 25 then true
                else false 
            end as bool
        ) as is_holiday
    from 
        date_spine
)
select 
    {{ dbt_utils.generate_surrogate_key(['full_date']) }} as date_key,
    full_date,
    year_number,
    month_number,     
    month_name,
    day_number,
    week_number,
    week_name,
    quarter_of_year,
    holiday_desc,
    is_holiday
from 
    dim_date