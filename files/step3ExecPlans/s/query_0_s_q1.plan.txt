                                                                            QUERY PLAN                                                                             
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=56124.76..56125.01 rows=100 width=17) (actual time=197308.519..197308.528 rows=100 loops=1)
   CTE customer_total_return
     ->  Finalize GroupAggregate  (cost=8204.83..8391.29 rows=1429 width=40) (actual time=62.525..149.578 rows=50441 loops=1)
           Group Key: sr_customer_sk, sr_store_sk
           ->  Remote Subquery Scan on all (dn0)  (cost=8204.83..8361.52 rows=1190 width=40) (actual time=62.509..100.107 rows=50441 loops=1)
   ->  Sort  (cost=47733.47..47734.66 rows=476 width=17) (actual time=197308.518..197308.521 rows=100 loops=1)
         Sort Key: c_customer_id
         Sort Method: top-N heapsort  Memory: 37kB
         ->  Hash Join  (cost=1688.24..47715.28 rows=476 width=17) (actual time=215.735..197281.640 rows=18976 loops=1)
               Hash Cond: (ctr1.ctr_customer_sk = c_customer_sk)
               ->  Hash Join  (cost=16.25..46042.04 rows=476 width=4) (actual time=165.858..197216.167 rows=18982 loops=1)
                     Hash Cond: (ctr1.ctr_store_sk = s_store_sk)
                     ->  CTE Scan on customer_total_return ctr1  (cost=0.00..46024.52 rows=476 width=8) (actual time=165.249..197198.480 rows=18982 loops=1)
                           Filter: (ctr_total_return > (SubPlan 2))
                           Rows Removed by Filter: 31459
                           SubPlan 2
                             ->  Aggregate  (cost=32.17..32.18 rows=1 width=32) (actual time=3.907..3.907 rows=1 loops=50441)
                                   ->  CTE Scan on customer_total_return ctr2  (cost=0.00..32.15 rows=7 width=32) (actual time=0.026..3.108 rows=8241 loops=50441)
                                         Filter: (ctr1.ctr_store_sk = ctr_store_sk)
                                         Rows Removed by Filter: 42200
                     ->  Hash  (cost=115.38..115.38 rows=250 width=4) (actual time=0.599..0.599 rows=12 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                           ->  Remote Subquery Scan on all (dn0)  (cost=100.00..115.38 rows=250 width=4) (actual time=0.589..0.591 rows=12 loops=1)
               ->  Hash  (cost=2221.99..2221.99 rows=33333 width=21) (actual time=49.835..49.835 rows=100000 loops=1)
                     Buckets: 131072 (originally 65536)  Batches: 1 (originally 1)  Memory Usage: 6493kB
                     ->  Remote Subquery Scan on all (dn0)  (cost=100.00..2221.99 rows=33333 width=21) (actual time=0.613..22.264 rows=100000 loops=1)
 Planning time: 0.508 ms
 Execution time: 197324.857 ms
(28 rows)

