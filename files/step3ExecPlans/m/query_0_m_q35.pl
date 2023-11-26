                                                                                                              QUERY PLAN                                                                                                               
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=1084568508.77..1084568516.52 rows=100 width=259) (actual time=3102359.662..3102360.366 rows=100 loops=1)
   ->  GroupAggregate  (cost=1084568508.77..1084569764.74 rows=16206 width=259) (actual time=3102359.661..3102360.358 rows=100 loops=1)
         Group Key: ca.ca_state, customer_demographics.cd_gender, customer_demographics.cd_marital_status, customer_demographics.cd_dep_count, customer_demographics.cd_dep_employed_count, customer_demographics.cd_dep_college_count
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=1084568508.77..1084568630.32 rows=16206 width=19) (actual time=3102359.645..3102359.888 rows=205 loops=1)
 Planning time: 2.220 ms
 Execution time: 3102367.758 ms
(6 rows)

SET
