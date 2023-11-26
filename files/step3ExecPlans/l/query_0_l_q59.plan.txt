                                                                                   QUERY PLAN                                                                                   
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=867747.65..867747.67 rows=6 width=250) (actual time=3161.257..3161.268 rows=100 loops=1)
   CTE wss
     ->  Finalize GroupAggregate  (cost=638999.15..858723.95 rows=177548 width=232) (actual time=1717.002..2530.577 rows=4716 loops=1)
           Group Key: d_week_seq, ss_store_sk
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=638999.15..839637.54 rows=355096 width=232) (actual time=1716.963..2487.338 rows=14148 loops=1)
   ->  Sort  (cost=9023.70..9023.72 rows=6 width=250) (actual time=3161.255..3161.258 rows=100 loops=1)
         Sort Key: s_store_name, s_store_id, wss.d_week_seq
         Sort Method: top-N heapsort  Memory: 73kB
         ->  Hash Join  (cost=4798.48..9023.62 rows=6 width=250) (actual time=2907.695..3152.859 rows=43248 loops=1)
               Hash Cond: ((wss.ss_store_sk = s_store_sk) AND (s_store_id = s_store_id))
               ->  Hash Join  (cost=4795.68..9017.88 rows=540 width=473) (actual time=2905.572..3014.411 rows=778464 loops=1)
                     Hash Cond: (wss.d_week_seq = d_week_seq)
                     ->  CTE Scan on wss  (cost=0.00..3550.96 rows=177548 width=232) (actual time=1717.004..1717.407 rows=4716 loops=1)
                     ->  Hash  (cost=4795.28..4795.28 rows=32 width=249) (actual time=1188.480..1188.481 rows=43248 loops=1)
                           Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 5313kB
                           ->  Hash Join  (cost=44.31..4795.28 rows=32 width=249) (actual time=471.707..1179.225 rows=43248 loops=1)
                                 Hash Cond: ((wss_1.d_week_seq - 52) = d_week_seq)
                                 ->  Hash Join  (cost=21.75..4732.26 rows=892 width=245) (actual time=339.801..1042.048 rows=6222 loops=1)
                                       Hash Cond: (wss_1.d_week_seq = d_week_seq)
                                       ->  Hash Join  (cost=2.72..4029.62 rows=28408 width=245) (actual time=217.263..1035.765 rows=4454 loops=1)
                                             Hash Cond: (wss_1.ss_store_sk = s_store_sk)
                                             ->  CTE Scan on wss wss_1  (cost=0.00..3550.96 rows=177548 width=232) (actual time=0.000..815.852 rows=4716 loops=1)
                                             ->  Hash  (cost=103.15..103.15 rows=32 width=21) (actual time=217.257..217.257 rows=32 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 10kB
                                                   ->  Remote Subquery Scan on all (dn2)  (cost=100.00..103.15 rows=32 width=21) (actual time=217.230..217.234 rows=32 loops=1)
                                       ->  Hash  (cost=117.88..117.88 rows=328 width=4) (actual time=4.919..4.919 rows=366 loops=1)
                                             Buckets: 1024  Batches: 1  Memory Usage: 21kB
                                             ->  Remote Subquery Scan on all (dn1)  (cost=100.17..117.88 rows=328 width=4) (actual time=4.788..4.822 rows=366 loops=1)
                                 ->  Hash  (cost=121.26..121.26 rows=372 width=4) (actual time=131.895..131.895 rows=365 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 21kB
                                       ->  Remote Subquery Scan on all (dn3)  (cost=100.17..121.26 rows=372 width=4) (actual time=131.762..131.827 rows=365 loops=1)
               ->  Hash  (cost=103.31..103.31 rows=32 width=26) (actual time=2.063..2.063 rows=32 loops=1)
                     Buckets: 1024  Batches: 1  Memory Usage: 10kB
                     ->  Remote Subquery Scan on all (dn2)  (cost=100.00..103.31 rows=32 width=26) (actual time=2.004..2.009 rows=32 loops=1)
 Planning time: 0.864 ms
 Execution time: 3188.937 ms
(36 rows)

