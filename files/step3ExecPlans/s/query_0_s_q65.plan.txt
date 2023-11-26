                                                                            QUERY PLAN                                                                            
------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=142508.34..142508.59 rows=100 width=202) (actual time=1322.553..1322.562 rows=100 loops=1)
   ->  Sort  (cost=142508.34..142518.60 rows=4101 width=202) (actual time=1322.553..1322.555 rows=100 loops=1)
         Sort Key: store.s_store_name, item.i_item_desc
         Sort Method: quicksort  Memory: 58kB
         ->  Hash Join  (cost=138648.55..142351.61 rows=4101 width=202) (actual time=1162.073..1322.406 rows=115 loops=1)
               Hash Cond: (sc.ss_item_sk = item.i_item_sk)
               ->  Merge Join  (cost=138103.55..141795.83 rows=4101 width=41) (actual time=1145.278..1305.491 rows=115 loops=1)
                     Merge Cond: (sa.ss_store_sk = sc.ss_store_sk)
                     Join Filter: (sc.revenue <= (0.1 * (avg(sa.revenue))))
                     Rows Removed by Join Filter: 53881
                     ->  Merge Join  (cost=69101.85..70869.25 rows=200 width=45) (actual time=641.071..641.117 rows=6 loops=1)
                           Merge Cond: (store.s_store_sk = sa.ss_store_sk)
                           ->  Remote Subquery Scan on all (dn0)  (cost=100.14..118.59 rows=250 width=9) (actual time=0.081..0.085 rows=11 loops=1)
                           ->  Finalize GroupAggregate  (cost=69101.70..70849.03 rows=200 width=36) (actual time=640.983..641.012 rows=7 loops=1)
                                 Group Key: sa.ss_store_sk
                                 ->  Remote Subquery Scan on all (dn0)  (cost=69101.70..70845.03 rows=200 width=36) (actual time=640.966..640.969 rows=7 loops=1)
                     ->  Materialize  (cost=69101.70..71364.45 rows=12304 width=40) (actual time=504.190..654.016 rows=53997 loops=1)
                           ->  Remote Subquery Scan on all (dn0)  (cost=69101.70..71333.69 rows=12304 width=40) (actual time=504.179..638.329 rows=53997 loops=1)
               ->  Hash  (cost=1614.00..1614.00 rows=6000 width=169) (actual time=16.786..16.786 rows=18000 loops=1)
                     Buckets: 32768 (originally 8192)  Batches: 1 (originally 1)  Memory Usage: 3841kB
                     ->  Remote Subquery Scan on all (dn0)  (cost=100.00..1614.00 rows=6000 width=169) (actual time=0.172..4.876 rows=18000 loops=1)
 Planning time: 0.443 ms
 Execution time: 1323.682 ms
(23 rows)

