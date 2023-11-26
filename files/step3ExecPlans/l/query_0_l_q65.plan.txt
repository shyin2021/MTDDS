                                                                                    QUERY PLAN                                                                                     
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=419782.70..419782.95 rows=100 width=202) (actual time=2263.492..2263.504 rows=100 loops=1)
   ->  Sort  (cost=419782.70..419788.57 rows=2347 width=202) (actual time=2263.491..2263.495 rows=100 loops=1)
         Sort Key: store.s_store_name, item.i_item_desc
         Sort Method: top-N heapsort  Memory: 78kB
         ->  Hash Join  (cost=407203.63..419693.00 rows=2347 width=202) (actual time=1401.251..2257.677 rows=15375 loops=1)
               Hash Cond: (sc.ss_item_sk = item.i_item_sk)
               ->  Merge Join  (cost=403935.63..416418.84 rows=2347 width=41) (actual time=1354.747..2203.588 rows=15375 loops=1)
                     Merge Cond: (sc.ss_store_sk = sa.ss_store_sk)
                     Join Filter: (sc.revenue <= (0.1 * (avg(sa.revenue))))
                     Rows Removed by Join Filter: 313536
                     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=202016.25..209997.10 rows=43997 width=40) (actual time=564.202..1283.152 rows=328912 loops=1)
                     ->  Materialize  (cost=202019.37..208250.90 rows=32 width=45) (actual time=790.527..804.528 rows=309647 loops=1)
                           ->  Merge Join  (cost=202019.37..208250.82 rows=32 width=45) (actual time=790.524..790.747 rows=17 loops=1)
                                 Merge Cond: (store.s_store_sk = sa.ss_store_sk)
                                 ->  Remote Subquery Scan on all (dn1)  (cost=103.12..103.65 rows=32 width=9) (actual time=0.652..0.667 rows=32 loops=1)
                                 ->  Finalize GroupAggregate  (cost=202016.25..208244.72 rows=200 width=36) (actual time=789.863..790.031 rows=17 loops=1)
                                       Group Key: sa.ss_store_sk
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=202016.25..208240.72 rows=200 width=36) (actual time=789.849..789.910 rows=52 loops=1)
               ->  Hash  (cost=9182.00..9182.00 rows=36000 width=169) (actual time=46.433..46.433 rows=36000 loops=1)
                     Buckets: 65536  Batches: 1  Memory Usage: 7680kB
                     ->  Remote Subquery Scan on all (dn1)  (cost=100.00..9182.00 rows=36000 width=169) (actual time=0.351..20.237 rows=36000 loops=1)
 Planning time: 0.523 ms
 Execution time: 2281.252 ms
(23 rows)

