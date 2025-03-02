with stg_departments as (
    SELECT * FROM {{ source("treytrey_de_project","departments") }}
)
select 
    cast(department_id as STRING) as department_id,
    department_name
from 
    stg_departments