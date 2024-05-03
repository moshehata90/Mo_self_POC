WITH 
     ec2pi AS (SELECT * FROM aws_dms.ibe.entry_click_2_product_item),
     ecard AS (SELECT * FROM aws_dms.ibe.entry_click_air_reference_data),
     sites AS (SELECT * FROM sales_use_case.silver_sales_bi.sites),
     to_eur AS(SELECT * FROM aws_dms.ibe.to_eur),
     ec AS (SELECT * FROM aws_dms.ibe.entry_clicks)  

SELECT 
       ec.id                                     AS entry_click_id,
       created                                   AS entry_click_created,
       ec2pi.headroom_sum                        as headroom_sum,
       ec.site_id                                as site_id,
       sites.site_country_id                     as site_country_id,
       to_eur.rate                               as to_eur_rate,
       ecard.num_cnn                             as num_children,
       ecard.num_adt                             as num_adults,
       ecard.ticketing_carrier_id_1              as ticketing_carrier_id_1,
       ecard.ticketing_carrier_id_2              as ticketing_carrier_id_2,
       partner_id                                as partner_id,
       click_cost                                as click_cost_loc,
       click_cost * to_eur.rate                  as click_cost_eur,
       offered_customer_amount                   as offered_customer_amount_loc,
       offered_customer_amount * to_eur.rate     as offered_customer_amount_eur,
       air_search_reference_id                   as air_search_reference_id,
       pca_customer_amount                       as pca_amount_loc,
       pca_customer_amount * to_eur.rate         as pca_amount_eur,
       pca_markup_amount                         as pca_markup_amount_loc,
       pca_markup_amount * to_eur.rate           as pca_markup_amount_eur,
       offer_age_in_seconds                      as offer_age_in_seconds,
       user_agent_major_details_id               as user_agent_major_details_id,
       session_tracking_entry_id                 as session_tracking_entry_id,
       entry_clicked_object_id                   as entry_clicked_object_id,
       origin_provider_item_pca_id               as origin_provider_item_pca_id,
       ec.origin_product_item_id                 as origin_product_item_id
FROM  ec
LEFT JOIN  ec2pi ON ec2pi.entry_click_id = ec.id
LEFT JOIN  ecard ON ecard.entry_click_id = ec.id
LEFT JOIN  sites ON sites.site_id = ec.site_id
LEFT JOIN  to_eur ON sites.site_currency_id = to_eur.id
