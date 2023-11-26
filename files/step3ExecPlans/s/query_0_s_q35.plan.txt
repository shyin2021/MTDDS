                                                                                                              QUERY PLAN                                                                                                               
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=290866284.86..290866292.61 rows=100 width=259) (actual time=1386995.695..1386995.939 rows=100 loops=1)
   ->  GroupAggregate  (cost=290866284.86..290866910.68 rows=8075 width=259) (actual time=1386995.695..1386995.933 rows=100 loops=1)
         Group Key: ca.ca_state, customer_demographics.cd_gender, customer_demographics.cd_marital_status, customer_demographics.cd_dep_count, customer_demographics.cd_dep_employed_count, customer_demographics.cd_dep_college_count
         ->  Remote Subquery Scan on all (dn0)  (cost=290866284.86..290866345.43 rows=8075 width=19) (actual time=1386995.664..1386995.675 rows=101 loops=1)
 Planning time: 0.674 ms
 Execution time: 1386998.460 ms
(6 rows)

SET
