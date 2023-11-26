                                                                                                         QUERY PLAN                                                                                                         
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=189208.76..189212.51 rows=100 width=64) (actual time=705.983..706.327 rows=100 loops=1)
   ->  GroupAggregate  (cost=189208.76..189236.44 rows=738 width=64) (actual time=705.982..706.279 rows=100 loops=1)
         Group Key: customer_demographics.cd_gender, customer_demographics.cd_marital_status, customer_demographics.cd_education_status, customer_demographics.cd_purchase_estimate, customer_demographics.cd_credit_rating
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=189208.76..189214.30 rows=738 width=40) (actual time=705.973..706.219 rows=222 loops=1)
 Planning time: 1.069 ms
 Execution time: 709.250 ms
(6 rows)

SET
