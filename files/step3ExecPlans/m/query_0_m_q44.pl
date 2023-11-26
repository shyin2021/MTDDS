                                                                               QUERY PLAN                                                                                
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=541532.17..541533.75 rows=100 width=110) (actual time=254.448..254.448 rows=0 loops=1)
   ->  Merge Join  (cost=541532.17..541644.69 rows=7104 width=110) (actual time=254.447..254.447 rows=0 loops=1)
         Merge Cond: (v11.rnk = v21.rnk)
         ->  Sort  (cost=270766.09..270769.07 rows=1192 width=59) (actual time=254.445..254.445 rows=0 loops=1)
               Sort Key: v11.rnk
               Sort Method: quicksort  Memory: 25kB
               ->  Hash Join  (cost=270576.93..270705.18 rows=1192 width=59) (actual time=254.440..254.440 rows=0 loops=1)
                     Hash Cond: (v11.item_sk = i_item_sk)
                     ->  Subquery Scan on v11  (cost=268215.93..268341.05 rows=1192 width=12) (actual time=222.495..222.495 rows=0 loops=1)
                           Filter: (v11.rnk < 11)
                           ->  WindowAgg  (cost=268215.93..268296.36 rows=3575 width=44) (actual time=222.494..222.494 rows=0 loops=1)
                                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=268215.93..268242.74 rows=3575 width=36) (actual time=222.492..222.492 rows=0 loops=1)
                     ->  Hash  (cost=3696.00..3696.00 rows=26000 width=55) (actual time=31.912..31.912 rows=26000 loops=1)
                           Buckets: 32768  Batches: 1  Memory Usage: 2488kB
                           ->  Remote Subquery Scan on all (dn2)  (cost=100.00..3696.00 rows=26000 width=55) (actual time=1.615..22.084 rows=26000 loops=1)
         ->  Sort  (cost=270766.09..270769.07 rows=1192 width=59) (never executed)
               Sort Key: v21.rnk
               ->  Hash Join  (cost=270576.93..270705.18 rows=1192 width=59) (never executed)
                     Hash Cond: (v21.item_sk = i_item_sk)
                     ->  Subquery Scan on v21  (cost=268215.93..268341.05 rows=1192 width=12) (never executed)
                           Filter: (v21.rnk < 11)
                           ->  WindowAgg  (cost=268215.93..268296.36 rows=3575 width=44) (never executed)
                                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=268215.93..268242.74 rows=3575 width=36) (never executed)
                     ->  Hash  (cost=3696.00..3696.00 rows=26000 width=55) (never executed)
                           ->  Remote Subquery Scan on all (dn1)  (cost=100.00..3696.00 rows=26000 width=55) (never executed)
 Planning time: 0.970 ms
 Execution time: 262.835 ms
(27 rows)

