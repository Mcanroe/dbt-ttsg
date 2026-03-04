select
    PID as patient_id,
    TRY_TO_DATE(DOB) as date_of_birth,
    -- Standardize sex values
    case
        when upper(trim(Sex)) = 'M' then 'Male'
        when upper(trim(Sex)) = 'F' then 'Female'
        when upper(trim(Sex)) = 'U' then 'Indeterminate'
        else upper(trim(Sex)) -- 'Indeterminate'
    end as sex,
    initcap(trim(Ethnic)) as ethnicity,
    trim(PCode) as postcode
from {{ source('ttsg', 'raw_patients') }}