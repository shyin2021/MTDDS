-- start query 6
\o /root/home/postgres/mtdds/files/step2ExecPlans/l/query_0_l_q6.plan.txt
explain analyze select  a.ca_state state, count(*) cnt
 from customer_address a
     ,customer c
     ,store_sales s
     ,date_dim d
     ,item i
	,(select i_category, avg(i_current_price) as acp 
 	  from item 
 	  group by i_category) avg_current_price
 where       a.ca_address_sk = c.c_current_addr_sk
 	and c.c_customer_sk = s.ss_customer_sk
 	and s.ss_sold_date_sk = d.d_date_sk
 	and s.ss_item_sk = i.i_item_sk
 	and d.d_month_seq = 
 	     (select distinct (d_month_seq)
 	      from date_dim
               where d_year = 2002
 	        and d_moy = 3 )
 	and i.i_current_price > 1.2 * avg_current_price.acp
	and i.i_category = avg_current_price.i_category
 group by a.ca_state
 having count(*) >= 10
 order by cnt, a.ca_state 
 limit 100;



-- end query 6