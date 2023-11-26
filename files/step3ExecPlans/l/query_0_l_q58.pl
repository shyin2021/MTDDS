                                                                                                                                                                                                                                                    QUERY PLAN                                                                                                                                                                                                                                                    
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=561707.37..561707.38 rows=1 width=292) (actual time=688.775..688.776 rows=2 loops=1)
   CTE ss_items
     ->  GroupAggregate  (cost=283947.96..283968.66 rows=828 width=49) (actual time=311.043..348.515 rows=11554 loops=1)
           Group Key: i_item_id
           InitPlan 1 (returns $1)
             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..2042.22 rows=1 width=4) (actual time=12.740..12.741 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=281905.74..281911.95 rows=828 width=23) (actual time=311.033..341.729 rows=18204 loops=1)
   CTE cs_items
     ->  GroupAggregate  (cost=181542.92..181553.27 rows=414 width=49) (actual time=178.853..198.059 rows=7406 loops=1)
           Group Key: i_item_id
           InitPlan 3 (returns $4)
             ->  Remote Subquery Scan on all (dn2)  (cost=100.00..2042.22 rows=1 width=4) (actual time=10.076..10.077 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=179500.70..179503.80 rows=414 width=23) (actual time=178.821..194.199 rows=9600 loops=1)
   CTE ws_items
     ->  GroupAggregate  (cost=96119.68..96124.85 rows=207 width=49) (actual time=123.923..132.815 rows=3746 loops=1)
           Group Key: i_item_id
           InitPlan 5 (returns $7)
             ->  Remote Subquery Scan on all (dn2)  (cost=100.00..2042.22 rows=1 width=4) (actual time=9.760..9.760 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=94077.45..94079.01 rows=207 width=23) (actual time=123.909..130.615 rows=4248 loops=1)
   ->  Sort  (cost=60.58..60.59 rows=1 width=292) (actual time=688.773..688.774 rows=2 loops=1)
         Sort Key: ss_items.item_id, ss_items.ss_item_rev
         Sort Method: quicksort  Memory: 25kB
         ->  Hash Join  (cost=39.81..60.57 rows=1 width=292) (actual time=650.325..688.763 rows=2 loops=1)
               Hash Cond: (ss_items.item_id = cs_items.item_id)
               Join Filter: ((ss_items.ss_item_rev >= (0.9 * cs_items.cs_item_rev)) AND (ss_items.ss_item_rev <= (1.1 * cs_items.cs_item_rev)) AND (cs_items.cs_item_rev >= (0.9 * ss_items.ss_item_rev)) AND (cs_items.cs_item_rev <= (1.1 * ss_items.ss_item_rev)) AND (ss_items.ss_item_rev >= (0.9 * ws_items.ws_item_rev)) AND (ss_items.ss_item_rev <= (1.1 * ws_items.ws_item_rev)) AND (ws_items.ws_item_rev >= (0.9 * ss_items.ss_item_rev)) AND (ws_items.ws_item_rev <= (1.1 * ss_items.ss_item_rev)))
               Rows Removed by Join Filter: 42
               ->  CTE Scan on ss_items  (cost=0.00..16.56 rows=828 width=100) (actual time=311.045..351.250 rows=11554 loops=1)
               ->  Hash  (cost=39.75..39.75 rows=5 width=200) (actual time=336.257..336.257 rows=55 loops=1)
                     Buckets: 1024  Batches: 1  Memory Usage: 13kB
                     ->  Hash Join  (cost=6.73..39.75 rows=5 width=200) (actual time=313.992..336.239 rows=55 loops=1)
                           Hash Cond: (cs_items.item_id = ws_items.item_id)
                           Join Filter: ((cs_items.cs_item_rev >= (0.9 * ws_items.ws_item_rev)) AND (cs_items.cs_item_rev <= (1.1 * ws_items.ws_item_rev)) AND (ws_items.ws_item_rev >= (0.9 * cs_items.cs_item_rev)) AND (ws_items.ws_item_rev <= (1.1 * cs_items.cs_item_rev)))
                           Rows Removed by Join Filter: 1431
                           ->  CTE Scan on cs_items  (cost=0.00..8.28 rows=414 width=100) (actual time=178.856..199.746 rows=7406 loops=1)
                           ->  Hash  (cost=4.14..4.14 rows=207 width=100) (actual time=134.723..134.723 rows=3746 loops=1)
                                 Buckets: 4096 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 237kB
                                 ->  CTE Scan on ws_items  (cost=0.00..4.14 rows=207 width=100) (actual time=123.927..134.059 rows=3746 loops=1)
 Planning time: 1.002 ms
 Execution time: 705.902 ms
(39 rows)

