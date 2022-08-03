-- depends_on: {{ ref('facebook_ads_main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='facebook_ads__monthly_ads_by_ad_set_name',
    grain='month',
    dimensions=['ad_set_id'],
    secondary_calculations=[]
) }}