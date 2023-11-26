                                                                                   QUERY PLAN                                                                                   
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=806887.01..806887.04 rows=1 width=110) (actual time=266.325..266.325 rows=0 loops=1)
   ->  Merge Join  (cost=806887.01..806887.04 rows=1 width=110) (actual time=266.324..266.324 rows=0 loops=1)
         Merge Cond: (v11.rnk = v21.rnk)
         ->  Sort  (cost=403443.51..403443.51 rows=1 width=59) (actual time=266.322..266.322 rows=0 loops=1)
               Sort Key: v11.rnk
               Sort Method: quicksort  Memory: 25kB
               ->  Hash Join  (cost=400490.49..403443.50 rows=1 width=59) (actual time=266.318..266.318 rows=0 loops=1)
                     Hash Cond: (i_item_sk = v11.item_sk)
                     ->  Remote Subquery Scan on all (dn3)  (cost=100.00..5078.00 rows=36000 width=55) (actual time=1.297..1.297 rows=1 loops=1)
                     ->  Hash  (cost=400490.47..400490.47 rows=1 width=12) (actual time=265.015..265.015 rows=0 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 8kB
                           ->  Subquery Scan on v11  (cost=400490.44..400490.47 rows=1 width=12) (actual time=265.014..265.014 rows=0 loops=1)
                                 Filter: (v11.rnk < 11)
                                 ->  WindowAgg  (cost=400490.44..400490.46 rows=1 width=44) (actual time=265.012..265.012 rows=0 loops=1)
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=400490.44..400490.45 rows=1 width=36) (actual time=265.008..265.008 rows=0 loops=1)
         ->  Sort  (cost=403443.51..403443.51 rows=1 width=59) (never executed)
               Sort Key: v21.rnk
               ->  Hash Join  (cost=400490.49..403443.50 rows=1 width=59) (never executed)
                     Hash Cond: (i_item_sk = v21.item_sk)
                     ->  Remote Subquery Scan on all (dn2)  (cost=100.00..5078.00 rows=36000 width=55) (never executed)
                     ->  Hash  (cost=400490.47..400490.47 rows=1 width=12) (never executed)
                           ->  Subquery Scan on v21  (cost=400490.44..400490.47 rows=1 width=12) (never executed)
                                 Filter: (v21.rnk < 11)
                                 ->  WindowAgg  (cost=400490.44..400490.46 rows=1 width=44) (never executed)
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=400490.44..400490.45 rows=1 width=36) (never executed)
 Planning time: 0.355 ms
 Execution time: 279.639 ms
(27 rows)

