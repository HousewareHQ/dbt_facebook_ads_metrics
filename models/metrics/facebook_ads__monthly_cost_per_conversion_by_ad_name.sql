-- depends_on: {{ ref('facebook_ads_main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='facebook_ads__monthly_cost_per_conversion_by_ad_name',
    grain='month',
    dimensions=['ad_name'],
    secondary_calculations=[]
) }}