{% macro get_season(x) %}
CASE
    WHEN MONTH(TO_TIMESTAMP({{x}})) IN (12, 1, 2)
        THEN 'WINTER'
    WHEN MONTH(TO_TIMESTAMP({{x}})) IN (2, 3, 4)
        THEN 'SPRING' 
    WHEN MONTH(TO_TIMESTAMP({{x}})) IN (5, 6, 7)
        THEN 'SUMMER'
        ELSE 'AUTUMN'     
    END 
{% endmacro %}


{% macro get_day_type(x) %}
CASE
    WHEN DAYNAME({{x}}) IN ('Sat', 'Sun') 
        THEN 'WEEKEND' 
        ELSE 'BUSINESSDAY'
    END

{% endmacro %}