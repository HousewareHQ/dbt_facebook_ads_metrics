-- depends_on: {{ ref('facebook_ads_main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('facebook_ads__monthly_campaigns'),
    grain='month',
    dimensions=[],
    secondary_calculations=[]
) }}