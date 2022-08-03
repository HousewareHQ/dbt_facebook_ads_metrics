-- depends_on: {{ ref('facebook_ads_main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='facebook_ads__monthly_ad_sets',
    grain='month',
    dimensions=[],
    secondary_calculations=[]
) }}