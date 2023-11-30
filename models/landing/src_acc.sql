

-- models/stg_emp.sql

{{ config(
    materialized='table',
    unique_key=['surrogate_key'],
    sort='eno'
) }}

-- This is the initial load
with base as (
    select
        row_number() over() as surrogate_key,
        eno,
        ename,
        loc
    from {{ source("landing", "LAN_TBL") }}
)

select
    surrogate_key,
    eno,
    ename,
    loc
from base


