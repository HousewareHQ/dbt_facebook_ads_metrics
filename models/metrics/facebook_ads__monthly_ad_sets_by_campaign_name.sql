-- depends_on: {{ ref('facebook_ads_main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.calculate(
    metric('facebook_ads__monthly_ad_sets_by_campaign_name'),
    grain='month',
    dimensions=['campaign_name'],
    secondary_calculations=[]
) }}