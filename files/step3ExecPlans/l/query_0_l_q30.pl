                                                                                                             QUERY PLAN                                                                                                             
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=45606.10..45606.12 rows=6 width=246) (actual time=105633.651..105633.660 rows=100 loops=1)
   CTE customer_total_return
     ->  GroupAggregate  (cost=9540.33..9569.95 rows=1077 width=39) (actual time=34.380..97.595 rows=39606 loops=1)
           Group Key: wr_returning_customer_sk, ca_state
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=9540.33..9548.41 rows=1077 width=13) (actual time=34.370..79.340 rows=40211 loops=1)
   ->  Sort  (cost=36036.15..36036.17 rows=6 width=246) (actual time=105633.650..105633.653 rows=100 loops=1)
         Sort Key: c_customer_id, c_salutation, c_first_name, c_last_name, c_preferred_cust_flag, c_birth_day, c_birth_month, c_birth_year, c_birth_country, c_login, c_email_address, c_last_review_date_sk, ctr1.ctr_total_return
         Sort Method: quicksort  Memory: 70kB
         ->  Hash Join  (cost=9882.42..36036.08 rows=6 width=246) (actual time=256.294..105633.123 rows=176 loops=1)
               Hash Cond: (ctr1.ctr_customer_sk = c_customer_sk)
               ->  CTE Scan on customer_total_return ctr1  (cost=0.00..26152.25 rows=359 width=36) (actual time=106.699..105584.920 rows=9781 loops=1)
                     Filter: (ctr_total_return > (SubPlan 2))
                     Rows Removed by Filter: 29825
                     SubPlan 2
                       ->  Aggregate  (cost=24.25..24.26 rows=1 width=32) (actual time=2.664..2.664 rows=1 loops=39606)
                             ->  CTE Scan on customer_total_return ctr2  (cost=0.00..24.23 rows=5 width=32) (actual time=0.066..2.550 rows=1161 loops=39606)
                                   Filter: (ctr1.ctr_state = ctr_state)
                                   Rows Removed by Filter: 38445
               ->  Hash  (cost=10640.86..10640.86 rows=3128 width=218) (actual time=43.654..43.654 rows=3054 loops=1)
                     Buckets: 4096  Batches: 1  Memory Usage: 632kB
                     ->  Remote Subquery Scan on all (dn2)  (cost=3438.55..10640.86 rows=3128 width=218) (actual time=11.602..38.749 rows=3054 loops=1)
 Planning time: 1.724 ms
 Execution time: 105651.007 ms
(23 rows)

