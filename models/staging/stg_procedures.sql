select
    sid as spell_id,
    pc as procedure_code,
    case
        when pd ilike 'null' then null
        when trim(pd) = '' then null
        else initcap(trim(pd))
    end as procedure_description
from {{ source('ttsg', 'raw_procedures') }}