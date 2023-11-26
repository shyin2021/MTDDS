                                                                                                                                                                                                                                                    QUERY PLAN                                                                                                                                                                                                                                                    
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=381822.66..381822.67 rows=1 width=292) (actual time=601.248..601.249 rows=1 loops=1)
   CTE ss_items
     ->  GroupAggregate  (cost=191784.52..191798.32 rows=552 width=49) (actual time=285.135..303.185 rows=8242 loops=1)
           Group Key: i_item_id
           InitPlan 1 (returns $1)
             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..2042.22 rows=1 width=4) (actual time=15.881..15.882 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=189742.29..189746.43 rows=552 width=23) (actual time=285.101..298.738 rows=12760 loops=1)
   CTE cs_items
     ->  GroupAggregate  (cost=123495.64..123502.54 rows=276 width=49) (actual time=172.977..182.621 rows=5085 loops=1)
           Group Key: i_item_id
           InitPlan 3 (returns $4)
             ->  Remote Subquery Scan on all (dn2)  (cost=100.00..2042.22 rows=1 width=4) (actual time=10.342..10.343 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=121453.41..121455.48 rows=276 width=23) (actual time=172.932..180.094 rows=6436 loops=1)
   CTE ws_items
     ->  GroupAggregate  (cost=66488.13..66491.58 rows=138 width=49) (actual time=104.678..109.127 rows=2782 loops=1)
           Group Key: i_item_id
           InitPlan 5 (returns $7)
             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..2042.22 rows=1 width=4) (actual time=9.616..9.617 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=64445.90..64446.94 rows=138 width=23) (actual time=104.665..107.883 rows=3129 loops=1)
   ->  Sort  (cost=30.23..30.24 rows=1 width=292) (actual time=601.247..601.247 rows=1 loops=1)
         Sort Key: ss_items.item_id, ss_items.ss_item_rev
         Sort Method: quicksort  Memory: 25kB
         ->  Hash Join  (cost=16.77..30.22 rows=1 width=292) (actual time=581.505..601.230 rows=1 loops=1)
               Hash Cond: (ss_items.item_id = cs_items.item_id)
               Join Filter: ((ss_items.ss_item_rev >= (0.9 * cs_items.cs_item_rev)) AND (ss_items.ss_item_rev <= (1.1 * cs_items.cs_item_rev)) AND (cs_items.cs_item_rev >= (0.9 * ss_items.ss_item_rev)) AND (cs_items.cs_item_rev <= (1.1 * ss_items.ss_item_rev)) AND (ss_items.ss_item_rev >= (0.9 * ws_items.ws_item_rev)) AND (ss_items.ss_item_rev <= (1.1 * ws_items.ws_item_rev)) AND (ws_items.ws_item_rev >= (0.9 * ss_items.ss_item_rev)) AND (ws_items.ws_item_rev <= (1.1 * ss_items.ss_item_rev)))
               Rows Removed by Join Filter: 22
               ->  CTE Scan on ss_items  (cost=0.00..11.04 rows=552 width=100) (actual time=285.137..305.096 rows=8242 loops=1)
               ->  Hash  (cost=16.74..16.74 rows=2 width=200) (actual time=295.158..295.158 rows=42 loops=1)
                     Buckets: 1024  Batches: 1  Memory Usage: 12kB
                     ->  Hash Join  (cost=4.49..16.74 rows=2 width=200) (actual time=283.267..295.140 rows=42 loops=1)
                           Hash Cond: (cs_items.item_id = ws_items.item_id)
                           Join Filter: ((cs_items.cs_item_rev >= (0.9 * ws_items.ws_item_rev)) AND (cs_items.cs_item_rev <= (1.1 * ws_items.ws_item_rev)) AND (ws_items.ws_item_rev >= (0.9 * cs_items.cs_item_rev)) AND (ws_items.ws_item_rev <= (1.1 * cs_items.cs_item_rev)))
                           Rows Removed by Join Filter: 1040
                           ->  CTE Scan on cs_items  (cost=0.00..5.52 rows=276 width=100) (actual time=172.980..183.775 rows=5085 loops=1)
                           ->  Hash  (cost=2.76..2.76 rows=138 width=100) (actual time=110.248..110.248 rows=2782 loops=1)
                                 Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 185kB
                                 ->  CTE Scan on ws_items  (cost=0.00..2.76 rows=138 width=100) (actual time=104.681..109.800 rows=2782 loops=1)
 Planning time: 1.040 ms
 Execution time: 611.224 ms
(39 rows)

