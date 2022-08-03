-- depends_on: {{ ref('facebook_ads_main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='facebook_ads__monthly_ads_by_campaign_name',
    grain='month',
    dimensions=['campaign_id'],
    secondary_calculations=[]
) }}