with
    daily_weather as (
        select
            date(to_timestamp(time)) as daily_weather,
            weather,
            temp,
            pressure,
            humidity,
            clouds
        from {{ source("demo", "weather") }}
    ),

    weather_daily_agg as (
        select
            daily_weather, 
            weather, 
            ROUND(avg(temp), 2) AS AVG_TEMP, 
            ROUND(avg(pressure), 2) AS AVG_PREASSURE, 
            ROUND(avg(humidity), 2) AS AVG_HUMIDITY, 
            ROUND(avg(clouds), 2) AS AVG_CLOUDS
        from daily_weather
        group by daily_weather, weather
        qualify
            row_number() over (partition by daily_weather order by count(weather) desc)
            = 1
    )

select *
from weather_daily_agg
