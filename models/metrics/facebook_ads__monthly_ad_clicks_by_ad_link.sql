-- depends_on: {{ ref('facebook_ads_main') }}




{{ config(materialized = 'table') }}

select *
from {{ metrics.metric(
    metric_name='facebook_ads__monthly_ad_clicks_by_ad_link',
    grain='month',
    dimensions=['template_page_link'],
    secondary_calculations=[]
) }}