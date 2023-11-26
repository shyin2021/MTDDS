                                                                                                                                                                                                                                                    QUERY PLAN                                                                                                                                                                                                                                                    
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=186233.83..186233.83 rows=1 width=292) (actual time=550.357..550.357 rows=0 loops=1)
   CTE ss_items
     ->  GroupAggregate  (cost=94315.89..94333.64 rows=710 width=49) (actual time=274.901..279.558 rows=4342 loops=1)
           Group Key: i_item_id
           InitPlan 1 (returns $0)
             ->  Remote Subquery Scan on all (dn0)  (cost=0.00..772.38 rows=1 width=4) (actual time=12.431..12.431 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn0)  (cost=93543.52..93548.84 rows=710 width=23) (actual time=274.871..276.257 rows=5993 loops=1)
   CTE cs_items
     ->  GroupAggregate  (cost=60212.86..60221.73 rows=355 width=49) (actual time=166.445..168.993 rows=2593 loops=1)
           Group Key: i_item_id
           InitPlan 3 (returns $2)
             ->  Remote Subquery Scan on all (dn0)  (cost=0.00..772.38 rows=1 width=4) (actual time=9.441..9.442 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn0)  (cost=59440.48..59443.14 rows=355 width=23) (actual time=166.428..167.151 rows=3123 loops=1)
   CTE ws_items
     ->  GroupAggregate  (cost=31632.76..31637.18 rows=177 width=49) (actual time=98.064..99.279 rows=1343 loops=1)
           Group Key: i_item_id
           InitPlan 5 (returns $4)
             ->  Remote Subquery Scan on all (dn0)  (cost=0.00..772.38 rows=1 width=4) (actual time=9.262..9.262 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn0)  (cost=30860.38..30861.71 rows=177 width=23) (actual time=98.049..98.366 rows=1459 loops=1)
   ->  Sort  (cost=41.27..41.28 rows=1 width=292) (actual time=550.356..550.356 rows=0 loops=1)
         Sort Key: ss_items.item_id, ss_items.ss_item_rev
         Sort Method: quicksort  Memory: 25kB
         ->  Hash Join  (cost=23.65..41.26 rows=1 width=292) (actual time=550.350..550.350 rows=0 loops=1)
               Hash Cond: (ss_items.item_id = cs_items.item_id)
               Join Filter: ((ss_items.ss_item_rev >= (0.9 * cs_items.cs_item_rev)) AND (ss_items.ss_item_rev <= (1.1 * cs_items.cs_item_rev)) AND (cs_items.cs_item_rev >= (0.9 * ss_items.ss_item_rev)) AND (cs_items.cs_item_rev <= (1.1 * ss_items.ss_item_rev)) AND (ss_items.ss_item_rev >= (0.9 * ws_items.ws_item_rev)) AND (ss_items.ss_item_rev <= (1.1 * ws_items.ws_item_rev)) AND (ws_items.ws_item_rev >= (0.9 * ss_items.ss_item_rev)) AND (ws_items.ws_item_rev <= (1.1 * ss_items.ss_item_rev)))
               Rows Removed by Join Filter: 6
               ->  CTE Scan on ss_items  (cost=0.00..14.20 rows=710 width=100) (actual time=274.903..280.380 rows=4342 loops=1)
               ->  Hash  (cost=23.60..23.60 rows=4 width=200) (actual time=269.598..269.598 rows=14 loops=1)
                     Buckets: 1024  Batches: 1  Memory Usage: 10kB
                     ->  Hash Join  (cost=5.75..23.60 rows=4 width=200) (actual time=266.381..269.593 rows=14 loops=1)
                           Hash Cond: (cs_items.item_id = ws_items.item_id)
                           Join Filter: ((cs_items.cs_item_rev >= (0.9 * ws_items.ws_item_rev)) AND (cs_items.cs_item_rev <= (1.1 * ws_items.ws_item_rev)) AND (ws_items.ws_item_rev >= (0.9 * cs_items.cs_item_rev)) AND (ws_items.ws_item_rev <= (1.1 * cs_items.cs_item_rev)))
                           Rows Removed by Join Filter: 378
                           ->  CTE Scan on cs_items  (cost=0.00..7.10 rows=355 width=100) (actual time=166.447..169.468 rows=2593 loops=1)
                           ->  Hash  (cost=3.54..3.54 rows=177 width=100) (actual time=99.722..99.722 rows=1343 loops=1)
                                 Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 90kB
                                 ->  CTE Scan on ws_items  (cost=0.00..3.54 rows=177 width=100) (actual time=98.066..99.550 rows=1343 loops=1)
 Planning time: 0.914 ms
 Execution time: 555.642 ms
(39 rows)

