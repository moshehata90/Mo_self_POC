WITH 
    parent AS (SELECT * FROM aws_dms.ibeconfig.sites),
    country AS (SELECT * FROM aws_dms.ibeconfig.country),
    brands AS (SELECT * FROM aws_dms.ibeconfig.brands),
    markets AS (SELECT * FROM aws_dms.ibeconfig.markets),
    strategic_market_group AS (SELECT * FROM aws_dms.ibeconfig.market_groups),
    budget_market_group AS (SELECT * FROM aws_dms.ibeconfig.market_groups),
    regional_market_group AS (SELECT * FROM aws_dms.ibeconfig.market_groups),
    regional_map_high_level_market_group AS (SELECT * FROM aws_dms.ibeconfig.market_groups),
    regional_map_detailed_market_group AS (SELECT * FROM aws_dms.ibeconfig.market_groups),
    currencies AS (SELECT * FROM aws_dms.ibeconfig.currencies),
    charging_currencies AS (SELECT * FROM aws_dms.ibeconfig.currencies),
    organisation AS (SELECT * FROM aws_dms.ibeconfig.organisation),
    organisation_department AS (SELECT * FROM aws_dms.ibeconfig.organisation_department),
    sites AS (SELECT * FROM aws_dms.ibeconfig.sites)
    

SELECT 
    sites.ID                                            as site_id,
    sites.NAME                                          as site_name,
    sites.ABBREVIATION                                  as site_abbreviation,
    parent.NAME                                         as main_site_name,
    
    sites.COUNTRY_ID                                    as site_country_id,
    country.COUNTRYNAME                                 as site_country_name,
    country.COUNTRYCODE                                 as site_country_iso_alpha2_code,
    country.COUNTRYCODE_3                               as site_country_iso_alpha3_code,
    country.NUMERIC_ISO_CODE                            as site_country_iso_numeric_code,
    
    sites.BRAND_ID                                      as site_brand_id,
    brands.NAME                                         as site_brand_name,
    brands.CODE                                         as site_brand_code,
    brands.SHORT_CODE                                   as site_brand_short_code, 
    
    sites.MARKET_ID                                     as site_market_id,    
    markets.NAME                                        as site_market_name,
    
    strategic_market_group.name                         as site_strategic_market_group_name,
    budget_market_group.name                            as site_budget_market_group_name,
    regional_market_group.name                          as site_regional_market_group_name,
    regional_map_high_level_market_group.name           as site_regional_map_high_level_market_group_name,
    regional_map_detailed_market_group.name             as site_regional_map_detailed_market_group_name,
    
    sites.CUR_ID                                        as site_currency_id,
    currencies.ISO_4217_CODE                            as site_currency_iso_alfa3_code,
    currencies.NUMERIC_CODE                             as site_currency_iso_numeric_code,
    currencies.NAME                                     as site_currency_name,

    sites.CHARGING_CUR_ID                               as site_charging_cur_id,
    charging_currencies.ISO_4217_CODE                   as site_charging_currency_iso_alfa3_code,
    charging_currencies.NUMERIC_CODE                    as site_charging_currency_iso_numeric_code,
    charging_currencies.NAME                            as site_charging_currency_name,


    sites.LANG_ID                                       as site_language_id,

    sites.ORG_ID                                        as site_organisation_id,
    organisation.NAME                                   as site_organisation_name,
    organisation.SHORT_NAME                             as site_organisation_short_name,
    
    sites.ORG_DEP_ID                                    as site_organisation_department_id,
    organisation_department.NAME                        as site_organisation_department_name,
    organisation_department.CODE                        as site_organisation_department_code,
    
    sites.STATUS                                        as site_status

FROM  sites
    
LEFT JOIN  parent 
    ON  sites.MAIN_SITE_ID = parent.ID --the main site id is referring to id.
LEFT JOIN  country
    ON sites.COUNTRY_ID = country.ID
LEFT JOIN  brands
    ON sites.BRAND_ID = brands.ID
LEFT JOIN  markets
    ON sites.MARKET_ID = markets.ID
LEFT JOIN  strategic_market_group
    ON  markets.strategic_market_group_id = strategic_market_group.id
LEFT JOIN  budget_market_group
    ON  markets.budget_market_group_id = budget_market_group.id
LEFT JOIN  regional_market_group
    ON  markets.regional_market_group_id = regional_market_group.id
LEFT JOIN  regional_map_high_level_market_group
    ON  markets.regional_map_high_level_market_group_id = regional_map_high_level_market_group.id
LEFT JOIN regional_map_detailed_market_group
    ON  markets.regional_map_detailed_market_group_id = regional_map_detailed_market_group.id
LEFT JOIN  currencies
    ON sites.CUR_ID = currencies.ID
LEFT JOIN charging_currencies
    ON sites.CHARGING_CUR_ID = charging_currencies.ID
LEFT JOIN  organisation
    ON sites.ORG_ID = organisation.ID
LEFT JOIN  organisation_department
    ON sites.ORG_DEP_ID = organisation_department.ID 