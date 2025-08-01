SELECT 
    *
FROM
    {{ source('demo', 'bike')}}
LIMIT 10

