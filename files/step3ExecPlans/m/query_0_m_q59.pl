                                                                              QUERY PLAN                                                                              
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=546591.98..546591.98 rows=2 width=250) (actual time=2789.903..2789.914 rows=100 loops=1)
   CTE wss
     ->  Finalize GroupAggregate  (cost=391321.25..540413.89 rows=125256 width=232) (actual time=1551.013..2290.360 rows=3406 loops=1)
           Group Key: d_week_seq, ss_store_sk
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=391321.25..526948.87 rows=250512 width=232) (actual time=1550.974..2268.715 rows=6812 loops=1)
   ->  Sort  (cost=6178.09..6178.10 rows=2 width=250) (actual time=2789.902..2789.905 rows=100 loops=1)
         Sort Key: s_store_name, s_store_id, wss.d_week_seq
         Sort Method: top-N heapsort  Memory: 77kB
         ->  Hash Join  (cost=3233.81..6178.08 rows=2 width=250) (actual time=2724.598..2784.076 rows=30576 loops=1)
               Hash Cond: ((wss.d_week_seq = d_week_seq) AND (s_store_id = s_store_id))
               ->  Hash Join  (cost=1.50..2842.38 rows=13778 width=250) (actual time=1849.812..1850.652 rows=3144 loops=1)
                     Hash Cond: (wss.ss_store_sk = s_store_sk)
                     ->  CTE Scan on wss  (cost=0.00..2505.12 rows=125256 width=232) (actual time=1551.015..1551.238 rows=3406 loops=1)
                     ->  Hash  (cost=101.90..101.90 rows=22 width=26) (actual time=298.787..298.787 rows=22 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 10kB
                           ->  Remote Subquery Scan on all (dn2)  (cost=100.00..101.90 rows=22 width=26) (actual time=298.759..298.762 rows=22 loops=1)
               ->  Hash  (cost=3232.09..3232.09 rows=15 width=249) (actual time=874.424..874.424 rows=30576 loops=1)
                     Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 3640kB
                     ->  Hash Join  (cost=41.89..3232.09 rows=15 width=249) (actual time=373.936..866.383 rows=30576 loops=1)
                           Hash Cond: ((wss_1.d_week_seq - 52) = d_week_seq)
                           ->  Hash Join  (cost=18.68..3190.78 rows=399 width=245) (actual time=257.321..746.020 rows=4380 loops=1)
                                 Hash Cond: (wss_1.d_week_seq = d_week_seq)
                                 ->  Hash Join  (cost=1.50..2842.38 rows=13778 width=245) (actual time=1.438..743.823 rows=3144 loops=1)
                                       Hash Cond: (wss_1.ss_store_sk = s_store_sk)
                                       ->  CTE Scan on wss wss_1  (cost=0.00..2505.12 rows=125256 width=232) (actual time=0.001..741.050 rows=3406 loops=1)
                                       ->  Hash  (cost=101.79..101.79 rows=22 width=21) (actual time=1.434..1.434 rows=22 loops=1)
                                             Buckets: 1024  Batches: 1  Memory Usage: 10kB
                                             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..101.79 rows=22 width=21) (actual time=1.413..1.416 rows=22 loops=1)
                                 ->  Hash  (cost=116.13..116.13 rows=302 width=4) (actual time=1.344..1.345 rows=365 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 21kB
                                       ->  Remote Subquery Scan on all (dn1)  (cost=100.17..116.13 rows=302 width=4) (actual time=1.242..1.275 rows=365 loops=1)
                           ->  Hash  (cost=121.84..121.84 rows=392 width=4) (actual time=116.590..116.590 rows=366 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 21kB
                                 ->  Remote Subquery Scan on all (dn1)  (cost=100.17..121.84 rows=392 width=4) (actual time=116.476..116.512 rows=366 loops=1)
 Planning time: 0.900 ms
 Execution time: 2807.848 ms
(36 rows)

