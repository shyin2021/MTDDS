                                                                                                         QUERY PLAN                                                                                                         
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=285748.31..285752.06 rows=100 width=64) (actual time=672.860..673.417 rows=100 loops=1)
   ->  GroupAggregate  (cost=285748.31..285808.12 rows=1595 width=64) (actual time=672.859..673.408 rows=100 loops=1)
         Group Key: customer_demographics.cd_gender, customer_demographics.cd_marital_status, customer_demographics.cd_education_status, customer_demographics.cd_purchase_estimate, customer_demographics.cd_credit_rating
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=285748.31..285760.27 rows=1595 width=40) (actual time=672.846..673.175 rows=372 loops=1)
 Planning time: 1.014 ms
 Execution time: 682.182 ms
(6 rows)

SET
