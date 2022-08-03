-- combining all the facebook ads tables to create a master table from which we create metrics 
-- added some key computations to the master table like cost_per_click, cost_per_impression, cost_per_conversion and click_through_rate

with account_history as (
    select *
    from {{ var("account_history") }}
), ad_history as (
    select *
    from {{ var("ad_history") }}
), ad_set_history as (
    select *
    from {{ var("ad_set_history") }}
), basic_ad as (
    select *
    from {{ var("basic_ad") }}
), campaign_history as (
    select *
    from {{ var("campaign_history") }}
), creative_history as (
    select *
    from {{ var("creative_history") }}
), ad_conversions as(
    select * from {{source('facebook_ads_source','AD_CONVERSIONS')}}
), source as ( 
    select A.*, B.account_name, C.ad_set_name, D.campaign_name, E.impressions, E.clicks, E.spend, E.date_day, F.creative_name, F.template_page_link,
    (select count(*) from ad_conversions where ad_conversions.ad_id = A.ad_id ) as number_of_conversions
    from ad_history A

    left join account_history B
    on A.account_id = B.account_id
    left join ad_set_history C
    on A.ad_set_id = C.ad_set_id
    left join campaign_history D 
    on A.campaign_id = D.campaign_id
    left join basic_ad E
    on A.ad_id = E.ad_id
    left join creative_history F
    on A.creative_id = F.creative_id
) 

select *,
(case when impressions is not null then cast((spend/impressions) as float) else null end) as cost_per_impression,
(case when clicks is not null then cast((spend/clicks) as float) else null end) as cost_per_click,
(case when number_of_conversions is not null then cast((spend/number_of_conversions) as float) else null end) as cost_per_conversion,
(case when clicks is not null and impressions is not null then cast((clicks/impressions) as float) else null end) as click_through_rate

from source
