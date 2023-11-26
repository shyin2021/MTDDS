                                                                                                                                                                       QUERY PLAN                                                                                                                                                                        
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=499497676.22..499497677.48 rows=24 width=100) (actual time=1250863.530..1250863.555 rows=12 loops=1)
   ->  GroupAggregate  (cost=499497676.22..499497677.48 rows=24 width=100) (actual time=1250863.529..1250863.553 rows=12 loops=1)
         Group Key: customer_demographics.cd_gender, customer_demographics.cd_marital_status, customer_demographics.cd_education_status, customer_demographics.cd_purchase_estimate, customer_demographics.cd_credit_rating, customer_demographics.cd_dep_count, customer_demographics.cd_dep_employed_count, customer_demographics.cd_dep_college_count
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=499497676.22..499497676.40 rows=24 width=52) (actual time=1250863.521..1250863.541 rows=24 loops=1)
 Planning time: 1.465 ms
 Execution time: 1250870.433 ms
(6 rows)

SET
