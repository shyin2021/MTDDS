                                                                                                                                                                       QUERY PLAN                                                                                                                                                                        
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=1111739285.70..1111739290.95 rows=100 width=100) (actual time=2982277.359..2982277.743 rows=40 loops=1)
   ->  GroupAggregate  (cost=1111739285.70..1111739292.63 rows=132 width=100) (actual time=2982277.357..2982277.736 rows=40 loops=1)
         Group Key: customer_demographics.cd_gender, customer_demographics.cd_marital_status, customer_demographics.cd_education_status, customer_demographics.cd_purchase_estimate, customer_demographics.cd_credit_rating, customer_demographics.cd_dep_count, customer_demographics.cd_dep_employed_count, customer_demographics.cd_dep_college_count
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=1111739285.70..1111739286.69 rows=132 width=52) (actual time=2982277.338..2982277.654 rows=119 loops=1)
 Planning time: 0.822 ms
 Execution time: 2982285.908 ms
(6 rows)

SET
