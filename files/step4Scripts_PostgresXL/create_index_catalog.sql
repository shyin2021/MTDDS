create index cp_end_date_sk_idx on catalog_page (cp_end_date_sk);
create index cp_start_date_sk_idx on catalog_page (cp_start_date_sk);
create index cr_call_center_sk_idx on catalog_returns (cr_call_center_sk);
create index on catalog_returns (cr_catalog_page_sk);
create index on catalog_returns (cr_item_sk);
create index on catalog_returns (cr_reason_sk);
create index on catalog_returns (cr_refunded_addr_sk);
create index on catalog_returns (cr_refunded_cdemo_sk);
create index on catalog_returns (cr_refunded_customer_sk);
create index on catalog_returns (cr_refunded_hdemo_sk);
create index on catalog_returns (cr_returned_date_sk);
create index on catalog_returns (cr_returned_time_sk);
create index on catalog_returns (cr_returning_addr_sk);
create index on catalog_returns (cr_returning_cdemo_sk);
create index on catalog_returns (cr_returning_customer_sk);
create index on catalog_returns (cr_returning_hdemo_sk);
create index on catalog_returns (cr_ship_mode_sk);
create index on catalog_returns (cr_warehouse_sk);
create index on catalog_sales (cs_bill_addr_sk);
create index on catalog_sales (cs_bill_cdemo_sk);
create index on catalog_sales (cs_bill_customer_sk);
create index on catalog_sales (cs_bill_hdemo_sk);
create index on catalog_sales (cs_call_center_sk); 
create index on catalog_sales (cs_catalog_page_sk);
create index on catalog_sales (cs_item_sk);
create index on catalog_sales (cs_promo_sk);
create index on catalog_sales (cs_ship_addr_sk);
create index on catalog_sales (cs_ship_cdemo_sk);
create index on catalog_sales (cs_ship_customer_sk);
create index on catalog_sales (cs_ship_date_sk);
create index on catalog_sales (cs_ship_hdemo_sk);
create index on catalog_sales (cs_ship_mode_sk);
create index on catalog_sales (cs_sold_date_sk);
create index on catalog_sales (cs_sold_time_sk);
create index on catalog_sales (cs_warehouse_sk);
--other indices for reporting queries
create index on date_dim (d_year);
create index on date_dim (d_qoy);
create index on date_dim (d_quarter_name);
create index on date_dim (d_moy);
create index on date_dim (d_month_seq);
create index on item (i_current_price);
create index on time_dim (t_time);