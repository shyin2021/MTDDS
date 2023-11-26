                                                                           QUERY PLAN                                                                            
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=243188.83..243188.84 rows=4 width=228) (actual time=2776.458..2776.532 rows=2513 loops=1)
   Sort Key: wswscs.d_week_seq
   Sort Method: quicksort  Memory: 323kB
   CTE wscs
     ->  Append  (cost=100.00..110398.35 rows=2161054 width=10) (actual time=1.314..807.025 rows=2160932 loops=1)
           ->  Remote Subquery Scan on all (dn0)  (cost=100.00..36851.60 rows=719384 width=10) (actual time=1.314..235.694 rows=719384 loops=1)
           ->  Remote Subquery Scan on all (dn0)  (cost=100.00..73546.75 rows=1441670 width=10) (actual time=1.207..472.623 rows=1441548 loops=1)
   CTE wswscs
     ->  HashAggregate  (cost=130950.24..131045.91 rows=3479 width=228) (actual time=2755.135..2755.383 rows=263 loops=1)
           Group Key: d_week_seq
           ->  Hash Join  (cost=1015.88..49910.71 rows=2161054 width=28) (actual time=42.602..1956.352 rows=2153563 loops=1)
                 Hash Cond: (wscs.sold_date_sk = d_date_sk)
                 ->  CTE Scan on wscs  (cost=0.00..43221.08 rows=2161054 width=18) (actual time=1.321..1555.043 rows=2160932 loops=1)
                 ->  Hash  (cost=1371.55..1371.55 rows=24350 width=18) (actual time=41.261..41.261 rows=73049 loops=1)
                       Buckets: 131072 (originally 32768)  Batches: 1 (originally 1)  Memory Usage: 4734kB
                       ->  Remote Subquery Scan on all (dn0)  (cost=100.00..1371.55 rows=24350 width=18) (actual time=0.913..19.952 rows=73049 loops=1)
   ->  Hash Join  (cost=1661.73..1744.53 rows=4 width=228) (actual time=2769.982..2776.097 rows=2513 loops=1)
         Hash Cond: (wswscs.d_week_seq = d_week_seq)
         ->  CTE Scan on wswscs  (cost=0.00..69.58 rows=3479 width=228) (actual time=2755.136..2755.152 rows=263 loops=1)
         ->  Hash  (cost=1661.68..1661.68 rows=4 width=232) (actual time=14.832..14.832 rows=2513 loops=1)
               Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 288kB
               ->  Hash Join  (cost=885.33..1661.68 rows=4 width=232) (actual time=13.871..14.260 rows=2513 loops=1)
                     Hash Cond: (d_week_seq = (wswscs_1.d_week_seq - 53))
                     ->  Remote Subquery Scan on all (dn0)  (cost=100.00..873.46 rows=121 width=4) (actual time=6.582..6.608 rows=365 loops=1)
                     ->  Hash  (cost=883.82..883.82 rows=121 width=228) (actual time=7.281..7.281 rows=365 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 44kB
                           ->  Hash Join  (cost=773.89..883.82 rows=121 width=228) (actual time=6.827..7.193 rows=365 loops=1)
                                 Hash Cond: (wswscs_1.d_week_seq = d_week_seq)
                                 ->  CTE Scan on wswscs wswscs_1  (cost=0.00..69.58 rows=3479 width=228) (actual time=0.001..0.325 rows=263 loops=1)
                                 ->  Hash  (cost=873.46..873.46 rows=121 width=4) (actual time=6.802..6.802 rows=365 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 21kB
                                       ->  Remote Subquery Scan on all (dn0)  (cost=100.00..873.46 rows=121 width=4) (actual time=6.711..6.743 rows=365 loops=1)
 Planning time: 0.363 ms
 Execution time: 2798.442 ms
(34 rows)

