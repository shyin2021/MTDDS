                                                                     QUERY PLAN                                                                      
-----------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=77785.86..77786.11 rows=100 width=220) (actual time=204.732..204.740 rows=100 loops=1)
   CTE sr_items
     ->  GroupAggregate  (cost=36396.26..36409.81 rows=602 width=25) (actual time=85.304..98.282 rows=6475 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=36396.26..36400.78 rows=602 width=21) (actual time=85.298..96.653 rows=8102 loops=1)
   CTE cr_items
     ->  GroupAggregate  (cost=24441.36..24448.16 rows=302 width=25) (actual time=52.736..59.551 rows=3743 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=24441.36..24443.63 rows=302 width=21) (actual time=52.729..58.708 rows=4200 loops=1)
   CTE wr_items
     ->  GroupAggregate  (cost=16806.15..16809.53 rows=150 width=25) (actual time=40.728..42.667 rows=1941 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=16806.15..16807.28 rows=150 width=21) (actual time=40.707..42.247 rows=2056 loops=1)
   ->  Sort  (cost=118.36..120.07 rows=682 width=220) (actual time=204.731..204.734 rows=100 loops=1)
         Sort Key: sr_items.item_id, sr_items.sr_item_qty
         Sort Method: quicksort  Memory: 44kB
         ->  Hash Join  (cost=17.13..92.30 rows=682 width=220) (actual time=189.808..204.667 rows=143 loops=1)
               Hash Cond: (sr_items.item_id = cr_items.item_id)
               ->  CTE Scan on sr_items  (cost=0.00..12.04 rows=602 width=76) (actual time=85.306..99.533 rows=6475 loops=1)
               ->  Hash  (cost=14.31..14.31 rows=226 width=152) (actual time=104.336..104.336 rows=412 loops=1)
                     Buckets: 1024  Batches: 1  Memory Usage: 44kB
                     ->  Hash Join  (cost=4.88..14.31 rows=226 width=152) (actual time=96.122..104.257 rows=412 loops=1)
                           Hash Cond: (cr_items.item_id = wr_items.item_id)
                           ->  CTE Scan on cr_items  (cost=0.00..6.04 rows=302 width=76) (actual time=52.738..60.298 rows=3743 loops=1)
                           ->  Hash  (cost=3.00..3.00 rows=150 width=76) (actual time=43.371..43.371 rows=1941 loops=1)
                                 Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 124kB
                                 ->  CTE Scan on wr_items  (cost=0.00..3.00 rows=150 width=76) (actual time=40.732..43.101 rows=1941 loops=1)
 Planning time: 1.124 ms
 Execution time: 217.958 ms
(29 rows)

