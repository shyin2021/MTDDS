                                                                               QUERY PLAN                                                                                
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=324203.82..324205.34 rows=100 width=110) (actual time=1149.529..1149.534 rows=10 loops=1)
   ->  Merge Join  (cost=324203.82..326479.36 rows=149878 width=110) (actual time=1149.528..1149.533 rows=10 loops=1)
         Merge Cond: (v11.rnk = v21.rnk)
         ->  Sort  (cost=162101.91..162115.60 rows=5475 width=59) (actual time=581.265..581.266 rows=10 loops=1)
               Sort Key: v11.rnk
               Sort Method: quicksort  Memory: 26kB
               ->  Hash Join  (cost=161172.69..161761.95 rows=5475 width=59) (actual time=573.618..581.260 rows=10 loops=1)
                     Hash Cond: (v11.item_sk = i_item_sk)
                     ->  Subquery Scan on v11  (cost=160627.69..161202.57 rows=5475 width=12) (actual time=556.564..564.202 rows=10 loops=1)
                           Filter: (v11.rnk < 11)
                           Rows Removed by Filter: 8411
                           ->  WindowAgg  (cost=160627.69..160997.25 rows=16425 width=44) (actual time=556.563..563.855 rows=8421 loops=1)
                                 ->  Remote Subquery Scan on all (dn0)  (cost=160627.69..160750.88 rows=16425 width=36) (actual time=556.542..558.878 rows=8421 loops=1)
                     ->  Hash  (cost=930.00..930.00 rows=6000 width=55) (actual time=17.045..17.045 rows=18000 loops=1)
                           Buckets: 32768 (originally 8192)  Batches: 1 (originally 1)  Memory Usage: 1802kB
                           ->  Remote Subquery Scan on all (dn0)  (cost=100.00..930.00 rows=6000 width=55) (actual time=0.942..11.181 rows=18000 loops=1)
         ->  Sort  (cost=162101.91..162115.60 rows=5475 width=59) (actual time=568.260..568.260 rows=10 loops=1)
               Sort Key: v21.rnk
               Sort Method: quicksort  Memory: 26kB
               ->  Hash Join  (cost=161172.69..161761.95 rows=5475 width=59) (actual time=560.622..568.253 rows=10 loops=1)
                     Hash Cond: (v21.item_sk = i_item_sk)
                     ->  Subquery Scan on v21  (cost=160627.69..161202.57 rows=5475 width=12) (actual time=548.988..556.614 rows=10 loops=1)
                           Filter: (v21.rnk < 11)
                           Rows Removed by Filter: 8411
                           ->  WindowAgg  (cost=160627.69..160997.25 rows=16425 width=44) (actual time=548.987..556.248 rows=8421 loops=1)
                                 ->  Remote Subquery Scan on all (dn0)  (cost=160627.69..160750.88 rows=16425 width=36) (actual time=548.975..551.331 rows=8421 loops=1)
                     ->  Hash  (cost=930.00..930.00 rows=6000 width=55) (actual time=11.623..11.623 rows=18000 loops=1)
                           Buckets: 32768 (originally 8192)  Batches: 1 (originally 1)  Memory Usage: 1802kB
                           ->  Remote Subquery Scan on all (dn0)  (cost=100.00..930.00 rows=6000 width=55) (actual time=0.520..5.868 rows=18000 loops=1)
 Planning time: 0.384 ms
 Execution time: 1151.603 ms
(31 rows)

