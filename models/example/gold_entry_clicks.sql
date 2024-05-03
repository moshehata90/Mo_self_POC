WITH
     vc_1 AS (SELECT * FROM aws_dms.ibeconfig.carrier),  
     vc_2 AS (SELECT * FROM aws_dms.ibeconfig.carrier),
     partners AS (SELECT * FROM sales_use_case.silver_sales_bi.partners)

SELECT 
  ec.entry_click_id,
  ec.entry_click_created,
  ec.headroom_sum,
  ec.site_id,
  ec.site_country_id,
  ec.to_eur_rate,
  ec.num_children,
  ec.num_adults,
  vc_1.carriercode as first_validating_carrier,
  concat(vc_1.carriercode, vc_2.carriercode) as validating_carriers,
  ec.partner_id,
  ec.click_cost_loc,
  ec.click_cost_eur,
  ec.offered_customer_amount_loc,
  ec.offered_customer_amount_eur,
  ec.air_search_reference_id,
  ec.pca_amount_loc,
  ec.pca_amount_eur,
  ec.pca_markup_amount_loc,
  ec.pca_markup_amount_eur,
  ec.offer_age_in_seconds,
  ec.user_agent_major_details_id,
  ec.session_tracking_entry_id,
  ec.entry_clicked_object_id,
  ec.origin_provider_item_pca_id,
  ec.origin_product_item_id,
  partners.partner_name,
  partners.partner_group,
  partners.entry_type,
  partners.entry_type_group,
  sites.site_name,
  sites.site_country_name,
  sites.site_brand_name,
  sites.site_market_name,
  sites.site_strategic_market_group_name,
  sites.site_budget_market_group_name,
  sites.site_regional_market_group_name,
  sites.site_regional_map_high_level_market_group_name,
  sites.site_regional_map_detailed_market_group_name
FROM {{ ref('dbt_test_entry_clicks') }} as ec
LEFT JOIN  vc_1 ON ec.ticketing_carrier_id_1 = vc_1.id 
LEFT JOIN  vc_2 ON ec.ticketing_carrier_id_2 = vc_2.id
LEFT JOIN  partners ON partners.partner_id = ec.partner_id
LEFT JOIN  {{ ref('dbt_test_sites') }} as sites ON sites.site_id = ec.site_id 