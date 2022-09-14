-- depends_on: {{ ref('facebook_ads_main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('experimental_facebook_ads__monthly_click_through_rate'),
    grain='month',
    dimensions=[],
    secondary_calculations=[]
) }}