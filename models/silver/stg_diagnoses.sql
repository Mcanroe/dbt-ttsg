select
    bd.sid as spell_id,
    dc as diagnosis_code,
    case
        when dd ilike 'null' then null
        when trim(dd) = '' then null
        else initcap(trim(dd))
    end as diagnosis_description 
from {{ ref('base_diagnoses') }} bd