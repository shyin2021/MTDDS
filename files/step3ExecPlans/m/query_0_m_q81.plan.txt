                                                                                                                 QUERY PLAN                                                                                                                  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=65581.50..65581.54 rows=16 width=236) (actual time=39080.055..39080.065 rows=100 loops=1)
   CTE customer_total_return
     ->  Finalize GroupAggregate  (cost=10717.31..10905.33 rows=1441 width=39) (actual time=66.430..107.814 rows=23752 loops=1)
           Group Key: cr_returning_customer_sk, ca_state
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=10717.31..10875.32 rows=1200 width=39) (actual time=66.419..90.491 rows=23854 loops=1)
   ->  Sort  (cost=54676.17..54676.21 rows=16 width=236) (actual time=39080.054..39080.058 rows=100 loops=1)
         Sort Key: c_customer_id, c_salutation, c_first_name, c_last_name, ca_street_number, ca_street_name, ca_street_type, ca_suite_number, ca_city, ca_county, ca_zip, ca_country, ca_gmt_offset, ca_location_type, ctr1.ctr_total_return
         Sort Method: quicksort  Memory: 68kB
         ->  Hash Join  (cost=7873.81..54675.85 rows=16 width=236) (actual time=417.769..39079.515 rows=165 loops=1)
               Hash Cond: (ctr1.ctr_customer_sk = c_customer_sk)
               ->  CTE Scan on customer_total_return ctr1  (cost=0.00..46800.08 rows=480 width=36) (actual time=120.409..39035.765 rows=5844 loops=1)
                     Filter: (ctr_total_return > (SubPlan 2))
                     Rows Removed by Filter: 17908
                     SubPlan 2
                       ->  Aggregate  (cost=32.44..32.45 rows=1 width=32) (actual time=1.640..1.640 rows=1 loops=23752)
                             ->  CTE Scan on customer_total_return ctr2  (cost=0.00..32.42 rows=7 width=32) (actual time=0.042..1.570 rows=699 loops=23752)
                                   Filter: (ctr1.ctr_state = ctr_state)
                                   Rows Removed by Filter: 23053
               ->  Hash  (cost=8926.59..8926.59 rows=4752 width=208) (actual time=39.820..39.820 rows=4735 loops=1)
                     Buckets: 8192  Batches: 1  Memory Usage: 1179kB
                     ->  Remote Subquery Scan on all (dn1)  (cost=2695.70..8926.59 rows=4752 width=208) (actual time=10.137..25.786 rows=4735 loops=1)
 Planning time: 1.100 ms
 Execution time: 39087.267 ms
(23 rows)

