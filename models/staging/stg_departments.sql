with stg_departments as (
    select * from {{ source("treytrey_de_project","departments") }}
)
select
    department_id,
    department_name
from
    stg_departments
