CREATE OR REPLACE VIEW icu_stay_los_greater_than1 AS
SELECT *,CASE
WHEN DENSE_RANK() OVER (PARTITION BY ie.subject_id ORDER BY ie.intime) = 1 THEN True
    ELSE False END AS first_icu_stay FROM "mimiciii"."icustays" as ie where los>1;
++++++++++++++++++++++

CREATE OR REPLACE VIEW VIEW_AGE_MORE_THAN_15_AND_HOSPSTAY_MORE_THAN_1 AS
SELECT ie.subject_id, ie.hadm_id, ie.icustay_id

-- hospital level factors
,ROUND((date_diff('second',pat.dob, adm.admittime))/(60*60*24), 4) AS age

, adm.hospital_expire_flag AS expire_flag

FROM icu_stay_los_greater_than1 ie
INNER JOIN admissions adm
    ON ie.hadm_id = adm.hadm_id
INNER JOIN patients pat
    ON ie.subject_id = pat.subject_id
WHERE (ie.first_icu_stay=true) AND 
(ROUND((date_diff('second',pat.dob, adm.admittime))/(60*60*24), 4)>15) 

+++++++++++++++++++++++++++++++

CREATE OR REPLACE VIEW NotesEvent_firstnote AS
SELECT *,CASE
WHEN DENSE_RANK() OVER (PARTITION BY ne.subject_id ORDER BY ne.charttime) = 1 THEN True
    ELSE False END AS first_icu_note FROM "mimiciii"."noteevents" ne WHERE lower(ne.category)=lower('Nursing') order by subject_id,hadm_id

++++++++++++++

select ie.subject_id, ie.hadm_id, ie.icustay_id,ie.expire_flag,ne.text
FROM VIEW_AGE_MORE_THAN_15_AND_HOSPSTAY_MORE_THAN_1 ie
JOIN NotesEvent_firstnote ne
    ON ie.subject_id = ne.subject_id
    AND ie.hadm_id = ne.hadm_id
WHERE lower(ne.category)=lower('Nursing') and ne.first_icu_note=true

