-- depends_on: {{ ref('facebook_ads_main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='facebook_ads__monthly_impressions_by_ad_name',
    grain='month',
    dimensions=['ad_name'],
    secondary_calculations=[]
) }}