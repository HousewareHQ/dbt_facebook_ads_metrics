# Facebook Ads Metrics dbt Package ([Docs](https://housewarehq.github.io/dbt_facebook_ads_metrics))

#Pre-Reqs!
For the package to work, you need to import ```basic ad``` report while ETLing Ad data with Fivetran

# 📣 What does this dbt package do?
This package provides pre-built metrics for Facebook ads data from [Fivetran's connector](https://fivetran.com/docs/applications/facebook-ads). It uses data in the format described by [this ERD](https://fivetran.com/docs/applications/facebook_ads#schemainformation).

This package enables you to access commonly used metrics on top of Facebook Ads Data

## Metrics 

This package contains transformed models built on top of [Facebook_ads_source package](https://github.com/fivetran/dbt_facebook_ads_source). A dependency on the source packages is declared in this package's `packages.yml` file, so it will automatically download when you run `dbt deps`. 

The metrics offered by this package are described below.
Note that all the metrics contain extended metrics for segmentation based on campaigns and adsets.

| **metric**                          | **description**                                                                                                                                                                                                                              |
|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| facebook_ads__monthly_ads    | Number of ads running monthly                
| facebook_ads__monthly_ad_sets      | Number of ad_sets running monthly                         
| facebook_ads__monthly_campaigns    | Number of campaigns running monthly
| facebook_ads__monthly_impressions    | Monthly impressions per ad 
| facebook_ads__monthly_ad_clicks    |        Monthly clicks on an ad                                                              |
| facebook_ads__monthly_ad_spend    |  Monthly spend on ads                                     |
| facebook_ads__monthly_cost_per_click    | monthly cost per ad click                                                         |
| facebook_ads__monthly_cost_per_impression   | Monthly cost per ad impression.               |
| facebook_ads__monthly_click_through_rate   | Monthly rate of users clicking on ad after viewing.|     
| facebook_ads__monthly_conversions   | Monthly number of ad conversions.|   
| facebook_ads__monthly_cost_per_conversion   | Monthly cost per ad conversion.|   

# 🎯 How do I use the dbt package?
## Step 1: Prerequisites
To use this dbt package, you must have the following:
- At least one Fivetran Facebook Ads connector syncing data into your destination. 
- A **BigQuery**, **Snowflake**, **Redshift**, or **PostgreSQL** destination.


## Step 2: Install the package

Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

Include in your `packages.yml`

```yaml
packages:
  - git: "https://github.com/HousewareHQ/dbt_facebook_ads_metrics.git"
    revision: v0.1.0
```

## Step 3: Define database and schema variables

By default, this package will look for your Facebook Ads data in the `fivetran_facebook_ads` schema of your [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). If this is not where your Facebook Ads data is, please add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
  facebook_ads_database: your_database_name
  facebook_ads_schema: your_schema_name
```

For additional configurations for the source models, please visit the [Facebook Ads source package](https://github.com/fivetran/dbt_facebook_ads_source).

## (Optional) Step 4: Change build schema
By default this package will build the Facebook Ads staging models within a schema titled (<target_schema> + `_stg_facebook_ads`) and the Facebook Ads metrics within a schema titled (<target_schema> + `_facebook_ads_metrics`) in your target database. If this is not where you would like your modeled Intercom data to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
models:
  facebook_ads_metrics:
    +schema: my_new_schema_name # leave blank for just the target_schema
  facebook_ads_source:
    +schema: my_new_schema_name # leave blank for just the target_schema
```


# 🗄 Which warehouses are supported?
This package has been tested on BigQuery, Snowflake.


# 🙌 Can I contribute?

Additional contributions to this package are very welcome! Please create issues
or open PRs against `main`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.


# 🏪 Are there any resources available?
- Provide [feedback](https://airtable.com/shrPHxTmfkjq3P6Eh) on what you'd like to see next
- Have questions, feedback, or need help? Email us at nipun@houseware.io
- Check out [Houseware's blog](https://www.houseware.io/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
