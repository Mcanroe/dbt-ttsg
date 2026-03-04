with spells as (
    select
        spell_id,
        patient_id,
        admission_date,
        discharge_date
    from {{ ref('stg_spells') }}
),

patients as (
    select
        patient_id,
        date_of_birth
    from {{ ref('stg_patients') }}
),

diagnosis_counts as (
    select
        spell_id,
        count(*) as diagnosis_count
    from {{ ref('stg_diagnoses') }}
    group by spell_id
),

procedure_counts as (
    select
        spell_id,
        count(*) as procedure_count
    from {{ ref('stg_procedures') }}
    group by spell_id
),

groupers as (
    select
        spell_id,
        hrg_code
    from {{ ref('stg_groupers') }}
)

select
    s.spell_id,
    s.patient_id,
    p.date_of_birth,
    {{ calculate_age('p.date_of_birth', 's.admission_date') }} as age_at_admission,
    s.admission_date,
    s.discharge_date,
    datediff('day', s.admission_date, s.discharge_date) as length_of_stay_days,
    coalesce(d.diagnosis_count, 0) as diagnosis_count,
    coalesce(pr.procedure_count, 0) as procedure_count,
    g.hrg_code
from spells s
left join patients p on s.patient_id = p.patient_id
left join diagnosis_counts d on s.spell_id = d.spell_id
left join procedure_counts pr on s.spell_id = pr.spell_id
left join groupers g on s.spell_id = g.spell_id
