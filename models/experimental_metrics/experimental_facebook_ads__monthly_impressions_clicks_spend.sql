-- depends_on: {{ ref('facebook_ads_main') }}




{{ config(materialized = 'table') }}

select *
  from 
  {{  metrics.calculate(
      [metric('facebook_ads__monthly_impressions'), 
      metric('facebook_ads__monthly_ad_clicks'), 
      metric('facebook_ads__monthly_ad_spend')], 
      grain='month', 
      dimensions=[]
  )
  }}