                                                                                 QUERY PLAN                                                                                  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=982423.93..982423.93 rows=1 width=72) (actual time=9091.980..9091.980 rows=1 loops=1)
   CTE ws_wh
     ->  Remote Subquery Scan on all (dn0,dn1,dn2)  (cost=34953.14..290457.52 rows=7669757 width=12) (actual time=672.746..3251.816 rows=6644004 loops=1)
   ->  Sort  (cost=691966.41..691966.42 rows=1 width=72) (actual time=9091.979..9091.979 rows=1 loops=1)
         Sort Key: (count(DISTINCT ws_order_number))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=691966.39..691966.40 rows=1 width=72) (actual time=9091.937..9091.937 rows=1 loops=1)
               ->  Hash Join  (cost=669413.89..691966.37 rows=2 width=16) (actual time=9091.820..9091.910 rows=73 loops=1)
                     Hash Cond: (ws_order_number = wr_order_number)
                     ->  Hash Join  (cost=174099.80..196652.26 rows=2 width=20) (actual time=6814.510..6814.586 rows=102 loops=1)
                           Hash Cond: (ws_order_number = ws_wh.ws_order_number)
                           ->  Remote Subquery Scan on all (dn0)  (cost=1625.76..24178.28 rows=4 width=16) (actual time=89.836..89.845 rows=102 loops=1)
                           ->  Hash  (cost=172571.53..172571.53 rows=200 width=4) (actual time=6724.651..6724.651 rows=60000 loops=1)
                                 Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 2622kB
                                 ->  HashAggregate  (cost=172569.53..172571.53 rows=200 width=4) (actual time=6710.101..6719.416 rows=60000 loops=1)
                                       Group Key: ws_wh.ws_order_number
                                       ->  CTE Scan on ws_wh  (cost=0.00..153395.14 rows=7669757 width=4) (actual time=672.756..5787.675 rows=6644004 loops=1)
                     ->  Hash  (cost=494848.58..494848.58 rows=37241 width=8) (actual time=2277.257..2277.257 rows=42249 loops=1)
                           Buckets: 65536  Batches: 1  Memory Usage: 2163kB
                           ->  HashAggregate  (cost=494476.17..494848.58 rows=37241 width=8) (actual time=2267.716..2272.696 rows=42249 loops=1)
                                 Group Key: wr_order_number
                                 ->  Hash Join  (cost=2941.67..457527.33 rows=14779538 width=8) (actual time=35.712..1419.579 rows=8677946 loops=1)
                                       Hash Cond: (ws_wh_1.ws_order_number = wr_order_number)
                                       ->  CTE Scan on ws_wh ws_wh_1  (cost=0.00..153395.14 rows=7669757 width=4) (actual time=0.002..358.479 rows=6644004 loops=1)
                                       ->  Hash  (cost=2790.50..2790.50 rows=71763 width=4) (actual time=35.404..35.404 rows=71763 loops=1)
                                             Buckets: 131072  Batches: 1  Memory Usage: 3547kB
                                             ->  Remote Subquery Scan on all (dn0)  (cost=100.00..2790.50 rows=71763 width=4) (actual time=0.526..22.546 rows=71763 loops=1)
 Planning time: 0.891 ms
 Execution time: 9154.607 ms
(29 rows)

