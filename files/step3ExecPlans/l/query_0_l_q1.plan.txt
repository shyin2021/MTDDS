                                                                             QUERY PLAN                                                                              
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=447800.26..447800.51 rows=100 width=17) (actual time=1549686.747..1549686.756 rows=100 loops=1)
   CTE customer_total_return
     ->  Finalize GroupAggregate  (cost=19233.44..19796.23 rows=4311 width=40) (actual time=66.899..348.521 rows=158221 loops=1)
           Group Key: sr_customer_sk, sr_store_sk
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=19233.44..19706.42 rows=3592 width=40) (actual time=66.887..250.657 rows=162606 loops=1)
   ->  Sort  (cost=428004.03..428004.61 rows=230 width=17) (actual time=1549686.745..1549686.748 rows=100 loops=1)
         Sort Key: c_customer_id
         Sort Method: top-N heapsort  Memory: 37kB
         ->  Hash Join  (cost=9435.80..427995.24 rows=230 width=17) (actual time=522.179..1549584.909 rows=60608 loops=1)
               Hash Cond: (ctr1.ctr_customer_sk = c_customer_sk)
               ->  Hash Join  (cost=2.80..418561.64 rows=230 width=4) (actual time=386.897..1549384.747 rows=60625 loops=1)
                     Hash Cond: (ctr1.ctr_store_sk = s_store_sk)
                     ->  CTE Scan on customer_total_return ctr1  (cost=0.00..418554.99 rows=1437 width=8) (actual time=385.500..1549326.338 rows=60625 loops=1)
                           Filter: (ctr_total_return > (SubPlan 2))
                           Rows Removed by Filter: 97596
                           SubPlan 2
                             ->  Aggregate  (cost=97.06..97.07 rows=1 width=32) (actual time=9.790..9.790 rows=1 loops=158221)
                                   ->  CTE Scan on customer_total_return ctr2  (cost=0.00..97.00 rows=22 width=32) (actual time=0.078..8.926 rows=9133 loops=158221)
                                         Filter: (ctr1.ctr_store_sk = ctr_store_sk)
                                         Rows Removed by Filter: 149088
                     ->  Hash  (cost=102.69..102.69 rows=32 width=4) (actual time=1.387..1.387 rows=32 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 10kB
                           ->  Remote Subquery Scan on all (dn1)  (cost=100.00..102.69 rows=32 width=4) (actual time=1.357..1.360 rows=32 loops=1)
               ->  Hash  (cost=12071.00..12071.00 rows=188000 width=21) (actual time=134.695..134.695 rows=188000 loops=1)
                     Buckets: 262144  Batches: 1  Memory Usage: 12330kB
                     ->  Remote Subquery Scan on all (dn2)  (cost=100.00..12071.00 rows=188000 width=21) (actual time=1.086..76.103 rows=188000 loops=1)
 Planning time: 0.489 ms
 Execution time: 1549741.754 ms
(28 rows)

