                                                                                                                 QUERY PLAN                                                                                                                  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=130765.91..130765.96 rows=20 width=236) (actual time=467470.602..467470.611 rows=100 loops=1)
   CTE customer_total_return
     ->  Finalize GroupAggregate  (cost=15327.49..15609.49 rows=2159 width=39) (actual time=57.693..247.377 rows=82938 loops=1)
           Group Key: cr_returning_customer_sk, ca_state
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=15327.49..15564.50 rows=1800 width=39) (actual time=57.679..178.375 rows=83570 loops=1)
   ->  Sort  (cost=115156.42..115156.47 rows=20 width=236) (actual time=467470.601..467470.604 rows=100 loops=1)
         Sort Key: c_customer_id, c_salutation, c_first_name, c_last_name, ca_street_number, ca_street_name, ca_street_type, ca_suite_number, ca_city, ca_county, ca_zip, ca_country, ca_gmt_offset, ca_location_type, ctr1.ctr_total_return
         Sort Method: top-N heapsort  Memory: 68kB
         ->  Hash Join  (cost=10133.93..115155.99 rows=20 width=236) (actual time=319.043..467468.601 rows=537 loops=1)
               Hash Cond: (ctr1.ctr_customer_sk = c_customer_sk)
               ->  CTE Scan on customer_total_return ctr1  (cost=0.00..105019.16 rows=720 width=36) (actual time=273.544..467410.227 rows=20459 loops=1)
                     Filter: (ctr_total_return > (SubPlan 2))
                     Rows Removed by Filter: 62479
                     SubPlan 2
                       ->  Aggregate  (cost=48.61..48.62 rows=1 width=32) (actual time=5.634..5.634 rows=1 loops=82938)
                             ->  CTE Scan on customer_total_return ctr2  (cost=0.00..48.58 rows=11 width=32) (actual time=0.137..5.396 rows=2410 loops=82938)
                                   Filter: (ctr1.ctr_state = ctr_state)
                                   Rows Removed by Filter: 80528
               ->  Hash  (cost=11285.75..11285.75 rows=5246 width=208) (actual time=45.483..45.483 rows=5358 loops=1)
                     Buckets: 8192  Batches: 1  Memory Usage: 1321kB
                     ->  Remote Subquery Scan on all (dn2)  (cost=3451.79..11285.75 rows=5246 width=208) (actual time=12.109..37.731 rows=5358 loops=1)
 Planning time: 0.545 ms
 Execution time: 467480.052 ms
(23 rows)

