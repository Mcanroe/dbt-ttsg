select
    spell_id,
    PID as patient_id,
    TRY_TO_DATE(admit_date) as admission_date,
    TRY_TO_DATE(discharge_dt) as discharge_date
from {{ ref('base_spells') }}