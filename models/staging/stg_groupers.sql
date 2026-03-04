select
    sid as spell_id,
    hc as hrg_code,
    case
        when hd ilike 'null' then null
        when trim(hd) = '' then null
        else initcap(trim(hd))
    end as hrg_description
from {{ ref('raw_groupers') }}