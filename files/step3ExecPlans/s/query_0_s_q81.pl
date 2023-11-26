                                                                                                                 QUERY PLAN                                                                                                                  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=19250.39..19250.41 rows=7 width=236) (actual time=52305.934..52305.943 rows=100 loops=1)
   CTE customer_total_return
     ->  Finalize GroupAggregate  (cost=5677.30..5749.40 rows=716 width=39) (actual time=61.518..102.715 rows=27598 loops=1)
           Group Key: cr_returning_customer_sk, ca_state
           ->  Remote Subquery Scan on all (dn0)  (cost=5677.30..5736.24 rows=421 width=39) (actual time=61.501..75.227 rows=27598 loops=1)
   ->  Sort  (cost=13500.99..13501.00 rows=7 width=236) (actual time=52305.933..52305.936 rows=100 loops=1)
         Sort Key: c_customer_id, c_salutation, c_first_name, c_last_name, ca_street_number, ca_street_name, ca_street_type, ca_suite_number, ca_city, ca_county, ca_zip, ca_country, ca_gmt_offset, ca_location_type, ctr1.ctr_total_return
         Sort Method: quicksort  Memory: 76kB
         ->  Hash Join  (cost=1931.15..13500.89 rows=7 width=236) (actual time=984.356..52305.417 rows=192 loops=1)
               Hash Cond: (ctr1.ctr_customer_sk = c_customer_sk)
               ->  CTE Scan on customer_total_return ctr1  (cost=0.00..11568.77 rows=239 width=36) (actual time=109.996..52276.798 rows=6827 loops=1)
                     Filter: (ctr_total_return > (SubPlan 2))
                     Rows Removed by Filter: 20771
                     SubPlan 2
                       ->  Aggregate  (cost=16.12..16.14 rows=1 width=32) (actual time=1.891..1.891 rows=1 loops=27598)
                             ->  CTE Scan on customer_total_return ctr2  (cost=0.00..16.11 rows=4 width=32) (actual time=0.050..1.811 rows=804 loops=27598)
                                   Filter: (ctr1.ctr_state = ctr_state)
                                   Rows Removed by Filter: 26794
               ->  Hash  (cost=2223.23..2223.23 rows=958 width=208) (actual time=24.509..24.509 rows=2820 loops=1)
                     Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 695kB
                     ->  Remote Subquery Scan on all (dn0)  (cost=676.32..2223.23 rows=958 width=208) (actual time=6.897..20.619 rows=2820 loops=1)
 Planning time: 4.381 ms
 Execution time: 52307.470 ms
(23 rows)

