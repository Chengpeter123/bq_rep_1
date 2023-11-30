
{%- macro generate_autoincrement_key(model, column_name) -%}
  {{ config(
    materialized='table',
    unique_key=[column_name],
    sort=column_name
  ) }}

  with base as (
    select
      row_number() over() as {{ column_name }},
      *
    from {{ this ~ ref(model) }}
  )

  select
    {{ column_name }},
    *
  from base
{%- endmacro %}