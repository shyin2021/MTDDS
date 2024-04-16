-- start query 10
explain analyze select  
  cd_gender,
  cd_marital_status,
  cd_education_status,
  count(*) cnt1,
  cd_purchase_estimate,
  count(*) cnt2,
  cd_credit_rating,
  count(*) cnt3,
  cd_dep_count,
  count(*) cnt4,
  cd_dep_employed_count,
  count(*) cnt5,
  cd_dep_college_count,
  count(*) cnt6
 from
  customer c,customer_address ca,customer_demographics,
  (select *
          from store_sales,date_dim
          where ss_sold_date_sk = d_date_sk and
                d_year = 2001 and
                d_moy between 1 and 1+3) ss
 where
  c.c_current_addr_sk = ca.ca_address_sk and
  ca_county in ('Storey County','Marquette County','Warren County','Cochran County','Kandiyohi County') and
  cd_demo_sk = c.c_current_cdemo_sk and 
  c.c_customer_sk = ss_customer_sk and
  c.c_customer_sk in (select ws_bill_customer_sk
            from web_sales,date_dim
            where ws_sold_date_sk = d_date_sk and
                  d_year = 2001 and
                  d_moy between 1 ANd 1+3
		 union
		 select cs_ship_customer_sk
            from catalog_sales,date_dim
            where cs_sold_date_sk = d_date_sk and
                  d_year = 2001 and
                  d_moy between 1 and 1+3)
 group by cd_gender,
          cd_marital_status,
          cd_education_status,
          cd_purchase_estimate,
          cd_credit_rating,
          cd_dep_count,
          cd_dep_employed_count,
          cd_dep_college_count
 order by cd_gender,
          cd_marital_status,
          cd_education_status,
          cd_purchase_estimate,
          cd_credit_rating,
          cd_dep_count,
          cd_dep_employed_count,
          cd_dep_college_count
limit 100;



-- end query 10
