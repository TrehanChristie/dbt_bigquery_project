with stg_departments as (
    SELECT * FROM {{ source("treytrey_de_project","departments") }}
)
select 
    department_id as department_id,
    department_name
from 
    stg_departments