                                                                                                                                                                       QUERY PLAN                                                                                                                                                                        
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=126643964.02..126643964.86 rows=16 width=100) (actual time=523609.070..523609.071 rows=1 loops=1)
   ->  GroupAggregate  (cost=126643964.02..126643964.86 rows=16 width=100) (actual time=523609.069..523609.070 rows=1 loops=1)
         Group Key: customer_demographics.cd_gender, customer_demographics.cd_marital_status, customer_demographics.cd_education_status, customer_demographics.cd_purchase_estimate, customer_demographics.cd_credit_rating, customer_demographics.cd_dep_count, customer_demographics.cd_dep_employed_count, customer_demographics.cd_dep_college_count
         ->  Remote Subquery Scan on all (dn0)  (cost=126643964.02..126643964.14 rows=16 width=52) (actual time=523609.057..523609.058 rows=1 loops=1)
 Planning time: 0.744 ms
 Execution time: 523611.504 ms
(6 rows)

SET
