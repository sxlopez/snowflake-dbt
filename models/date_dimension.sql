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
            {{get_day_type('STARTED_AT')}} AS DAY_TYPE,
            {{get_season('STARTED_AT')}} AS SEASON_OF_YEAR               
        FROM
            GET_TIMESTAMP
    )

    SELECT
        *
    FROM
        DIM_DATE