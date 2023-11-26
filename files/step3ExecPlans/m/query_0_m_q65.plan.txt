                                                                                  QUERY PLAN                                                                                   
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=279387.39..279387.64 rows=100 width=202) (actual time=1705.362..1705.372 rows=100 loops=1)
   ->  Sort  (cost=279387.39..279389.89 rows=1001 width=202) (actual time=1705.361..1705.364 rows=100 loops=1)
         Sort Key: store.s_store_name, item.i_item_desc
         Sort Method: top-N heapsort  Memory: 80kB
         ->  Hash Join  (cost=271627.59..279349.13 rows=1001 width=202) (actual time=1323.862..1701.711 rows=10150 loops=1)
               Hash Cond: (sc.ss_item_sk = item.i_item_sk)
               ->  Merge Join  (cost=269266.59..276985.50 rows=1001 width=41) (actual time=1290.432..1663.686 rows=10150 loops=1)
                     Merge Cond: (sc.ss_store_sk = sa.ss_store_sk)
                     Join Filter: (sc.revenue <= (0.1 * (avg(sa.revenue))))
                     Rows Removed by Join Filter: 171055
                     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=134682.44..139632.30 rows=27287 width=40) (actual time=552.196..858.445 rows=181206 loops=1)
                     ->  Materialize  (cost=134684.15..138552.91 rows=22 width=45) (actual time=738.220..744.831 rows=166207 loops=1)
                           ->  Merge Join  (cost=134684.15..138552.86 rows=22 width=45) (actual time=738.217..738.352 rows=12 loops=1)
                                 Merge Cond: (store.s_store_sk = sa.ss_store_sk)
                                 ->  Remote Subquery Scan on all (dn2)  (cost=101.71..102.07 rows=22 width=9) (actual time=2.551..2.562 rows=22 loops=1)
                                 ->  Finalize GroupAggregate  (cost=134682.44..138548.32 rows=200 width=36) (actual time=735.656..735.752 rows=12 loops=1)
                                       Group Key: sa.ss_store_sk
                                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=134682.44..138544.32 rows=200 width=36) (actual time=735.645..735.675 rows=25 loops=1)
               ->  Hash  (cost=6660.00..6660.00 rows=26000 width=169) (actual time=33.398..33.398 rows=26000 loops=1)
                     Buckets: 32768  Batches: 1  Memory Usage: 5435kB
                     ->  Remote Subquery Scan on all (dn1)  (cost=100.00..6660.00 rows=26000 width=169) (actual time=0.340..15.251 rows=26000 loops=1)
 Planning time: 0.549 ms
 Execution time: 1714.731 ms
(23 rows)

