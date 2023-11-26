                                                                    QUERY PLAN                                                                     
---------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=59148.24..59148.49 rows=100 width=220) (actual time=193.909..193.916 rows=95 loops=1)
   CTE sr_items
     ->  GroupAggregate  (cost=26733.60..26742.65 rows=402 width=25) (actual time=102.885..109.668 rows=4754 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=26733.60..26736.62 rows=402 width=21) (actual time=102.876..108.414 rows=5910 loops=1)
   CTE cr_items
     ->  GroupAggregate  (cost=18730.58..18735.11 rows=201 width=25) (actual time=42.314..45.388 rows=2546 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=18730.58..18732.09 rows=201 width=21) (actual time=42.292..44.795 rows=2842 loops=1)
   CTE wr_items
     ->  GroupAggregate  (cost=13623.04..13625.29 rows=100 width=25) (actual time=34.748..35.872 rows=1339 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=13623.04..13623.79 rows=100 width=21) (actual time=34.743..35.583 rows=1402 loops=1)
   ->  Sort  (cost=45.19..45.70 rows=202 width=220) (actual time=193.907..193.910 rows=95 loops=1)
         Sort Key: sr_items.item_id, sr_items.sr_item_qty
         Sort Method: quicksort  Memory: 38kB
         ->  Hash Join  (cost=10.28..37.47 rows=202 width=220) (actual time=185.519..193.862 rows=95 loops=1)
               Hash Cond: (sr_items.item_id = cr_items.item_id)
               ->  CTE Scan on sr_items  (cost=0.00..8.04 rows=402 width=76) (actual time=102.887..110.651 rows=4754 loops=1)
               ->  Hash  (cost=9.03..9.03 rows=100 width=152) (actual time=82.606..82.606 rows=269 loops=1)
                     Buckets: 1024  Batches: 1  Memory Usage: 32kB
                     ->  Hash Join  (cost=3.25..9.03 rows=100 width=152) (actual time=78.732..82.560 rows=269 loops=1)
                           Hash Cond: (cr_items.item_id = wr_items.item_id)
                           ->  CTE Scan on cr_items  (cost=0.00..4.02 rows=201 width=76) (actual time=42.315..45.845 rows=2546 loops=1)
                           ->  Hash  (cost=2.00..2.00 rows=100 width=76) (actual time=36.386..36.386 rows=1339 loops=1)
                                 Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 91kB
                                 ->  CTE Scan on wr_items  (cost=0.00..2.00 rows=100 width=76) (actual time=34.768..36.195 rows=1339 loops=1)
 Planning time: 1.310 ms
 Execution time: 200.740 ms
(29 rows)

