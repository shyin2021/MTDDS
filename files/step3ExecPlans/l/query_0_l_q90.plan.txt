                                                                        QUERY PLAN                                                                        
----------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=10000142044.95..10000142044.96 rows=1 width=32) (actual time=239.357..239.358 rows=1 loops=1)
   ->  Sort  (cost=10000142044.95..10000142044.96 rows=1 width=32) (actual time=239.357..239.357 rows=1 loops=1)
         Sort Key: ((((count(*)))::numeric(15,4) / ((count(*)))::numeric(15,4)))
         Sort Method: quicksort  Memory: 25kB
         ->  Nested Loop  (cost=10000142044.88..10000142044.94 rows=1 width=32) (actual time=239.351..239.351 rows=1 loops=1)
               ->  Finalize Aggregate  (cost=71022.52..71022.53 rows=1 width=8) (actual time=118.763..118.763 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=71022.29..71022.51 rows=2 width=8) (actual time=97.429..118.747 rows=3 loops=1)
               ->  Finalize Aggregate  (cost=71022.36..71022.37 rows=1 width=8) (actual time=120.582..120.582 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=71022.14..71022.36 rows=2 width=8) (actual time=93.496..120.566 rows=3 loops=1)
 Planning time: 0.450 ms
 Execution time: 246.949 ms
(11 rows)

