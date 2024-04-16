-- start query 1
explain analyze with customer_total_return as
(select sr_customer_sk as ctr_customer_sk
,sr_store_sk as ctr_store_sk
,sum(SR_FEE) as ctr_total_return
from store_returns
,date_dim
where sr_returned_date_sk = d_date_sk
and d_year =2000
group by sr_customer_sk
,sr_store_sk)
 select  c_customer_id
from customer_total_return ctr1
,(select ctr_store_sk, avg(ctr_total_return) as avg
from customer_total_return
group by ctr_store_sk) avg_ctr
,store
,customer
where ctr1.ctr_total_return > avg*1.2
and ctr1.ctr_store_sk = avg_ctr.ctr_store_sk
and s_store_sk = ctr1.ctr_store_sk
and s_state = 'SD'
and ctr1.ctr_customer_sk = c_customer_sk
order by c_customer_id
limit 100;



-- end query 1
