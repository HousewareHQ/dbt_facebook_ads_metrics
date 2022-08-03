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
    select ad_history.*, account_history.account_name, ad_set_history.ad_set_name, campaign_history.campaign_name, basic_ad.impressions, basic_ad.clicks, basic_ad.spend, basic_ad.date_day, creative_history.creative_name, creative_history.template_page_link,
    (select count(*) from ad_conversions where ad_conversions.ad_id = ad_history.ad_id ) as number_of_conversions
    from ad_history

    left join account_history
    on ad_history.account_id = account_history.account_id
    left join ad_set_history
    on ad_history.ad_set_id = ad_set_history.ad_set_id
    left join campaign_history 
    on ad_history.campaign_id = campaign_history.campaign_id
    left join basic_ad 
    on ad_history.ad_id = basic_ad.ad_id
    left join creative_history
    on ad_history.creative_id = creative_history.creative_id
) 

select *,
(case when impressions is not null then cast((spend/impressions) as float) else null end) as cost_per_impression,
(case when clicks is not null then cast((spend/clicks) as float) else null end) as cost_per_click,
(case when number_of_conversions is not null then cast((spend/number_of_conversions) as float) else null end) as cost_per_conversion,
(case when clicks is not null and impressions is not null then cast((clicks/impressions) as float) else null end) as click_through_rate

from source
