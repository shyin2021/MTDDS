                                                                        QUERY PLAN                                                                         
-----------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=484256.65..484256.68 rows=13 width=228) (actual time=5252.913..5252.991 rows=2513 loops=1)
   Sort Key: wswscs.d_week_seq
   Sort Method: quicksort  Memory: 322kB
   CTE wscs
     ->  Append  (cost=100.00..220456.42 rows=4319257 width=10) (actual time=1.634..913.254 rows=4319305 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=100.00..73624.18 rows=1439247 width=10) (actual time=1.634..248.728 rows=1439247 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=100.00..146832.25 rows=2880010 width=10) (actual time=1.721..449.083 rows=2880058 loops=1)
   CTE wswscs
     ->  HashAggregate  (cost=262744.59..263031.63 rows=10438 width=228) (actual time=5242.401..5242.712 rows=264 loops=1)
           Group Key: d_week_seq
           ->  Hash Join  (cost=3048.60..100772.45 rows=4319257 width=28) (actual time=73.621..3499.116 rows=4304668 loops=1)
                 Hash Cond: (wscs.sold_date_sk = d_date_sk)
                 ->  CTE Scan on wscs  (cost=0.00..86385.14 rows=4319257 width=18) (actual time=1.658..2681.453 rows=4319305 loops=1)
                 ->  Hash  (cost=3915.62..3915.62 rows=73049 width=18) (actual time=71.716..71.716 rows=73049 loops=1)
                       Buckets: 131072  Batches: 1  Memory Usage: 4734kB
                       ->  Remote Subquery Scan on all (dn2)  (cost=100.00..3915.62 rows=73049 width=18) (actual time=2.100..38.606 rows=73049 loops=1)
   ->  Hash Join  (cost=519.87..768.35 rows=13 width=228) (actual time=5246.181..5252.529 rows=2513 loops=1)
         Hash Cond: (wswscs.d_week_seq = d_week_seq)
         ->  CTE Scan on wswscs  (cost=0.00..208.76 rows=10438 width=228) (actual time=5242.402..5242.419 rows=264 loops=1)
         ->  Hash  (cost=519.70..519.70 rows=13 width=232) (actual time=3.763..3.763 rows=2513 loops=1)
               Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 288kB
               ->  Hash Join  (cost=42.84..519.70 rows=13 width=232) (actual time=2.420..3.125 rows=2513 loops=1)
                     Hash Cond: ((wswscs_1.d_week_seq - 53) = d_week_seq)
                     ->  Hash Join  (cost=21.42..481.73 rows=365 width=228) (actual time=1.199..1.637 rows=365 loops=1)
                           Hash Cond: (wswscs_1.d_week_seq = d_week_seq)
                           ->  CTE Scan on wswscs wswscs_1  (cost=0.00..208.76 rows=10438 width=228) (actual time=0.000..0.382 rows=264 loops=1)
                           ->  Hash  (cost=120.14..120.14 rows=365 width=4) (actual time=1.190..1.190 rows=365 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 21kB
                                 ->  Remote Subquery Scan on all (dn1)  (cost=100.17..120.14 rows=365 width=4) (actual time=1.092..1.127 rows=365 loops=1)
                     ->  Hash  (cost=120.14..120.14 rows=365 width=4) (actual time=1.216..1.216 rows=365 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 21kB
                           ->  Remote Subquery Scan on all (dn2)  (cost=100.17..120.14 rows=365 width=4) (actual time=1.122..1.156 rows=365 loops=1)
 Planning time: 0.469 ms
 Execution time: 5275.885 ms
(34 rows)

