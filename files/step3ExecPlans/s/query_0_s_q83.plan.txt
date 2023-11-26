                                                                 QUERY PLAN                                                                 
--------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=21695.14..21695.21 rows=26 width=220) (actual time=135.703..135.705 rows=22 loops=1)
   CTE sr_items
     ->  Finalize GroupAggregate  (cost=9541.48..9566.04 rows=201 width=25) (actual time=56.589..58.062 rows=2109 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn0)  (cost=9541.48..9563.19 rows=168 width=25) (actual time=56.576..57.270 rows=2109 loops=1)
   CTE cr_items
     ->  Finalize GroupAggregate  (cost=7144.27..7153.54 rows=101 width=25) (actual time=43.373..43.989 rows=1202 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn0)  (cost=7144.27..7152.23 rows=59 width=25) (actual time=43.362..43.559 rows=1202 loops=1)
   CTE wr_items
     ->  GroupAggregate  (cost=4961.98..4963.11 rows=50 width=25) (actual time=32.151..32.567 rows=657 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn0)  (cost=4961.98..4962.36 rows=50 width=21) (actual time=32.138..32.303 rows=682 loops=1)
   ->  Sort  (cost=12.46..12.53 rows=26 width=220) (actual time=135.702..135.703 rows=22 loops=1)
         Sort Key: sr_items.item_id, sr_items.sr_item_qty
         Sort Method: quicksort  Memory: 27kB
         ->  Hash Join  (cost=5.15..11.85 rows=26 width=220) (actual time=133.695..135.687 rows=22 loops=1)
               Hash Cond: (sr_items.item_id = cr_items.item_id)
               ->  CTE Scan on sr_items  (cost=0.00..4.02 rows=201 width=76) (actual time=56.590..58.414 rows=2109 loops=1)
               ->  Hash  (cost=4.52..4.52 rows=50 width=152) (actual time=77.079..77.079 rows=96 loops=1)
                     Buckets: 1024  Batches: 1  Memory Usage: 17kB
                     ->  Hash Join  (cost=1.62..4.52 rows=50 width=152) (actual time=76.148..77.062 rows=96 loops=1)
                           Hash Cond: (cr_items.item_id = wr_items.item_id)
                           ->  CTE Scan on cr_items  (cost=0.00..2.02 rows=101 width=76) (actual time=43.375..44.175 rows=1202 loops=1)
                           ->  Hash  (cost=1.00..1.00 rows=50 width=76) (actual time=32.767..32.767 rows=657 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 45kB
                                 ->  CTE Scan on wr_items  (cost=0.00..1.00 rows=50 width=76) (actual time=32.154..32.691 rows=657 loops=1)
 Planning time: 1.869 ms
 Execution time: 139.474 ms
(29 rows)

