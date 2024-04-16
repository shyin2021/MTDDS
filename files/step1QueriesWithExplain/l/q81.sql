-- start query 81
\o /root/home/postgres/mtdds/files/step2ExecPlans/l/query_0_l_q81.plan.txt
explain analyze with customer_total_return as
 (select cr_returning_customer_sk as ctr_customer_sk
        ,ca_state as ctr_state, 
 	sum(cr_return_amt_inc_tax) as ctr_total_return
 from catalog_returns
     ,date_dim
     ,customer_address
 where cr_returned_date_sk = d_date_sk 
   and d_year =2002
   and cr_returning_addr_sk = ca_address_sk 
 group by cr_returning_customer_sk
         ,ca_state )
  select  c_customer_id,c_salutation,c_first_name,c_last_name,ca_street_number,ca_street_name
                   ,ca_street_type,ca_suite_number,ca_city,ca_county,ca_state,ca_zip,ca_country,ca_gmt_offset
                  ,ca_location_type,ctr_total_return
 from customer_total_return ctr1
     ,customer_address
     ,customer
	,(select ctr_state, avg(ctr_total_return) as avg_total_return
 			  from customer_total_return 
                  group by ctr_state) avg_ctr2
 where ctr1.ctr_total_return > avg_total_return*1.2
 	  and ctr1.ctr_state = avg_ctr2.ctr_state
       and ca_address_sk = c_current_addr_sk
       and ca_state = 'CA'
       and ctr1.ctr_customer_sk = c_customer_sk
 order by c_customer_id,c_salutation,c_first_name,c_last_name,ca_street_number,ca_street_name
                   ,ca_street_type,ca_suite_number,ca_city,ca_county,ca_state,ca_zip,ca_country,ca_gmt_offset
                  ,ca_location_type,ctr_total_return
 limit 100;



-- end query 81