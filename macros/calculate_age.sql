{% macro calculate_age(dob, reference_date) %}
    datediff('year', {{ dob }}, {{ reference_date }})
{% endmacro %}
