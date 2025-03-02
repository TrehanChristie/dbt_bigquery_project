SELECT 
    department_id,
    department_name
FROM {{ ref('stg_departments') }}
