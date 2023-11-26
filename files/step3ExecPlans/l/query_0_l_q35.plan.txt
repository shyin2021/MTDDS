                                                                                                              QUERY PLAN                                                                                                               
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=2427058392.49..2427058399.49 rows=100 width=175) (actual time=7730641.115..7730641.857 rows=100 loops=1)
   ->  GroupAggregate  (cost=2427058392.49..2427060100.07 rows=24394 width=175) (actual time=7730641.114..7730641.849 rows=100 loops=1)
         Group Key: ca.ca_state, customer_demographics.cd_gender, customer_demographics.cd_marital_status, customer_demographics.cd_dep_count, customer_demographics.cd_dep_employed_count, customer_demographics.cd_dep_college_count
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=2427058392.49..2427058575.45 rows=24394 width=19) (actual time=7730641.096..7730641.595 rows=298 loops=1)
 Planning time: 0.745 ms
 Execution time: 7730650.741 ms
(6 rows)

SET
