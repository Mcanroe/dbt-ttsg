with patients as (
    select
        patient_id,
        date_of_birth,
        sex,
        ethnicity,
        postcode
    from {{ ref('stg_patients') }}
),

spells as (
    select
        patient_id,
        min(admission_date) as first_admission_date
    from {{ ref('stg_spells') }}
    group by patient_id
)

select
    p.patient_id,
    p.date_of_birth,
    {{ calculate_age('p.date_of_birth', 's.first_admission_date') }} as age_at_first_admission,
    p.sex,
    p.ethnicity,
    p.postcode
from patients p
left join spells s on p.patient_id = s.patient_id
