                                                                                       QUERY PLAN                                                                                        
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=640609.79..640609.79 rows=1 width=16) (actual time=3625.005..3625.005 rows=0 loops=1)
   CTE my_customers
     ->  Unique  (cost=372925.32..372925.38 rows=7 width=8) (actual time=3135.256..3135.484 rows=1497 loops=1)
           ->  Sort  (cost=372925.32..372925.34 rows=7 width=8) (actual time=3135.256..3135.320 rows=1705 loops=1)
                 Sort Key: c_customer_sk, c_current_addr_sk
                 Sort Method: quicksort  Memory: 128kB
                 ->  Hash Join  (cost=12436.59..372925.23 rows=7 width=8) (actual time=1076.134..3134.619 rows=1705 loops=1)
                       Hash Cond: (cs_bill_customer_sk = c_customer_sk)
                       ->  Hash Join  (cost=3003.59..363492.21 rows=7 width=4) (actual time=946.300..3003.928 rows=1707 loops=1)
                             Hash Cond: (cs_item_sk = i_item_sk)
                             ->  Hash Join  (cost=118.16..360599.55 rows=2750 width=8) (actual time=838.046..2981.977 rows=67659 loops=1)
                                   Hash Cond: (cs_sold_date_sk = d_date_sk)
                                   ->  Append  (cost=100.00..343571.53 rows=6479575 width=12) (actual time=8.285..1517.019 rows=6479532 loops=1)
                                         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=100.00..228796.07 rows=4319410 width=12) (actual time=8.284..833.089 rows=4319367 loops=1)
                                         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=100.00..114775.45 rows=2160165 width=12) (actual time=5.585..328.235 rows=2160165 loops=1)
                                   ->  Hash  (cost=118.05..118.05 rows=31 width=4) (actual time=6.290..6.290 rows=31 loops=1)
                                         Buckets: 1024  Batches: 1  Memory Usage: 10kB
                                         ->  Remote Subquery Scan on all (dn2)  (cost=100.17..118.05 rows=31 width=4) (actual time=6.273..6.277 rows=31 loops=1)
                             ->  Hash  (cost=2985.13..2985.13 rows=87 width=4) (actual time=14.806..14.806 rows=880 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 39kB
                                   ->  Remote Subquery Scan on all (dn2)  (cost=200.00..2985.13 rows=87 width=4) (actual time=11.088..14.657 rows=880 loops=1)
                       ->  Hash  (cost=9627.00..9627.00 rows=188000 width=8) (actual time=129.610..129.610 rows=188000 loops=1)
                             Buckets: 262144  Batches: 1  Memory Usage: 9392kB
                             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..9627.00 rows=188000 width=8) (actual time=5.745..83.750 rows=188000 loops=1)
   CTE my_revenue
     ->  GroupAggregate  (cost=267684.31..267684.34 rows=1 width=36) (actual time=3624.994..3624.994 rows=0 loops=1)
           Group Key: my_customers.c_customer_sk
           InitPlan 2 (returns $2)
             ->  Remote Subquery Scan on all (dn2)  (cost=17.92..18.31 rows=31 width=4) (actual time=5.115..5.116 rows=1 loops=1)
           InitPlan 3 (returns $3)
             ->  Remote Subquery Scan on all (dn3)  (cost=17.92..18.31 rows=31 width=4) (actual time=10.058..10.058 rows=1 loops=1)
           ->  Sort  (cost=267647.69..267647.70 rows=1 width=10) (actual time=3624.993..3624.993 rows=0 loops=1)
                 Sort Key: my_customers.c_customer_sk
                 Sort Method: quicksort  Memory: 25kB
                 ->  Hash Join  (cost=3362.02..267647.68 rows=1 width=10) (actual time=3624.990..3624.990 rows=0 loops=1)
                       Hash Cond: (((ca_county)::text = (s_county)::text) AND (ca_state = s_state))
                       ->  Hash Join  (cost=3359.22..267644.70 rows=2 width=27) (actual time=3225.510..3616.185 rows=2075 loops=1)
                             Hash Cond: (ss_customer_sk = my_customers.c_customer_sk)
                             ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=122.33..264893.45 rows=43169 width=10) (actual time=22.093..348.545 rows=233681 loops=1)
                             ->  Hash  (cost=3336.80..3336.80 rows=7 width=21) (actual time=3203.265..3203.265 rows=1497 loops=1)
                                   Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 95kB
                                   ->  Hash Join  (cost=0.23..3336.80 rows=7 width=21) (actual time=3141.197..3202.938 rows=1497 loops=1)
                                         Hash Cond: (ca_address_sk = my_customers.c_current_addr_sk)
                                         ->  Remote Subquery Scan on all (dn1)  (cost=100.00..5528.00 rows=94000 width=21) (actual time=5.412..44.374 rows=94000 loops=1)
                                         ->  Hash  (cost=0.14..0.14 rows=7 width=8) (actual time=3135.761..3135.761 rows=1497 loops=1)
                                               Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 75kB
                                               ->  CTE Scan on my_customers  (cost=0.00..0.14 rows=7 width=8) (actual time=3135.258..3135.637 rows=1497 loops=1)
                       ->  Hash  (cost=103.15..103.15 rows=32 width=21) (actual time=8.445..8.445 rows=31 loops=1)
                             Buckets: 1024  Batches: 1  Memory Usage: 10kB
                             ->  Remote Subquery Scan on all (dn2)  (cost=100.00..103.15 rows=32 width=21) (actual time=8.423..8.427 rows=32 loops=1)
   CTE segments
     ->  CTE Scan on my_revenue  (cost=0.00..0.03 rows=1 width=4) (actual time=3624.995..3624.995 rows=0 loops=1)
   ->  Sort  (cost=0.05..0.05 rows=1 width=16) (actual time=3625.004..3625.004 rows=0 loops=1)
         Sort Key: segments.segment, (count(*))
         Sort Method: quicksort  Memory: 25kB
         ->  HashAggregate  (cost=0.02..0.04 rows=1 width=16) (actual time=3624.997..3624.997 rows=0 loops=1)
               Group Key: segments.segment
               ->  CTE Scan on segments  (cost=0.00..0.02 rows=1 width=4) (actual time=3624.996..3624.996 rows=0 loops=1)
 Planning time: 0.802 ms
 Execution time: 3641.003 ms
(60 rows)

