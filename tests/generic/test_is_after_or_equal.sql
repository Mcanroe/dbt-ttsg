{% test is_after_or_equal(model, column_name, compare_to_column) %}

select *
from {{ model }}
where {{ column_name }} < {{ compare_to_column }}

{% endtest %}
