WITH 
    GET_TIMESTAMP AS (
        SELECT
            TO_TIMESTAMP(STARTED_AT) AS STARTED_AT, 
        FROM
            {{ source('demo', 'raw_bike') }}
    ),

    DIM_DATE AS (
        SELECT
            STARTED_AT,
            TO_DATE(STARTED_AT) AS DATE_STARTED_AT,
            HOUR(STARTED_AT) AS HOUR_STARTED_AT,
            CASE
                WHEN DAYNAME(STARTED_AT) IN ('Sat', 'Sun') 
                    THEN 'WEEKEND' 
                    ELSE 'BUSINESSDAY'
                END AS DAY_TYPE,

            CASE
                WHEN MONTH(STARTED_AT) IN (12, 1, 2)
                    THEN 'WINTER'
                WHEN MONTH(STARTED_AT) IN (2, 3, 4)
                    THEN 'SPRING' 
                WHEN MONTH(STARTED_AT) IN (5, 6, 7)
                    THEN 'SUMMER'
                    ELSE 'AUTUMN'     
                END AS YEAR_STATION                     
        FROM
            GET_TIMESTAMP
    )

    SELECT
        *
    FROM
        DIM_DATE