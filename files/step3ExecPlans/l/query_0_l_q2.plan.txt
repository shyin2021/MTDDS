                                                                        QUERY PLAN                                                                         
-----------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=724302.62..724302.66 rows=13 width=228) (actual time=8040.748..8040.825 rows=2513 loops=1)
   Sort Key: wswscs.d_week_seq
   Sort Method: quicksort  Memory: 327kB
   CTE wscs
     ->  Append  (cost=100.00..330612.38 rows=6479575 width=10) (actual time=3.522..1409.648 rows=6479532 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=100.00..110455.12 rows=2160165 width=10) (actual time=3.522..363.436 rows=2160165 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=100.00..220157.25 rows=4319410 width=10) (actual time=2.188..707.311 rows=4319367 loops=1)
   CTE wswscs
     ->  HashAggregate  (cost=392634.04..392921.25 rows=10444 width=228) (actual time=8030.114..8030.421 rows=264 loops=1)
           Group Key: d_week_seq
           ->  Hash Join  (cost=3048.60..149649.98 rows=6479575 width=28) (actual time=98.838..5383.407 rows=6457597 loops=1)
                 Hash Cond: (wscs.sold_date_sk = d_date_sk)
                 ->  CTE Scan on wscs  (cost=0.00..129591.50 rows=6479575 width=18) (actual time=3.532..4089.091 rows=6479532 loops=1)
                 ->  Hash  (cost=3915.62..3915.62 rows=73049 width=18) (actual time=95.147..95.147 rows=73049 loops=1)
                       Buckets: 131072  Batches: 1  Memory Usage: 4734kB
                       ->  Remote Subquery Scan on all (dn3)  (cost=100.00..3915.62 rows=73049 width=18) (actual time=14.944..70.836 rows=73049 loops=1)
   ->  Hash Join  (cost=520.13..768.76 rows=13 width=228) (actual time=8034.126..8040.353 rows=2513 loops=1)
         Hash Cond: (wswscs.d_week_seq = d_week_seq)
         ->  CTE Scan on wswscs  (cost=0.00..208.88 rows=10444 width=228) (actual time=8030.116..8030.132 rows=264 loops=1)
         ->  Hash  (cost=519.97..519.97 rows=13 width=232) (actual time=3.995..3.995 rows=2513 loops=1)
               Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 288kB
               ->  Hash Join  (cost=42.84..519.97 rows=13 width=232) (actual time=2.725..3.409 rows=2513 loops=1)
                     Hash Cond: ((wswscs_1.d_week_seq - 53) = d_week_seq)
                     ->  Hash Join  (cost=21.42..481.99 rows=365 width=228) (actual time=1.272..1.700 rows=365 loops=1)
                           Hash Cond: (wswscs_1.d_week_seq = d_week_seq)
                           ->  CTE Scan on wswscs wswscs_1  (cost=0.00..208.88 rows=10444 width=228) (actual time=0.000..0.374 rows=264 loops=1)
                           ->  Hash  (cost=120.14..120.14 rows=365 width=4) (actual time=1.264..1.264 rows=365 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 21kB
                                 ->  Remote Subquery Scan on all (dn2)  (cost=100.17..120.14 rows=365 width=4) (actual time=1.170..1.203 rows=365 loops=1)
                     ->  Hash  (cost=120.14..120.14 rows=365 width=4) (actual time=1.448..1.448 rows=365 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 21kB
                           ->  Remote Subquery Scan on all (dn3)  (cost=100.17..120.14 rows=365 width=4) (actual time=1.357..1.390 rows=365 loops=1)
 Planning time: 0.356 ms
 Execution time: 8072.692 ms
(34 rows)

