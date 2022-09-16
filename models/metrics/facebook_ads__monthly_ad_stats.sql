-- depends_on: {{ ref('facebook_ads_main') }}

{{ config(materialized = 'table') }}
 
select *
from 
{{ metrics.calculate(
    [metric('facebook_ads__monthly_ad_spend'), metric('facebook_ads__monthly_impressions'), metric('facebook_ads__monthly_ad_clicks')], 
    grain='month', 
    dimensions=[]
)}}