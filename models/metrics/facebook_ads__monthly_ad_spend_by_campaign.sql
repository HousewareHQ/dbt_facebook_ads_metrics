-- depends_on: {{ ref('facebook_ads_main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='facebook_ads__monthly_ad_spend_by_campaign',
    grain='month',
    dimensions=['campaign_name'],
    secondary_calculations=[]
) }}