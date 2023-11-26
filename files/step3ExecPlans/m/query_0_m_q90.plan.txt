                                                                      QUERY PLAN                                                                       
-------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=10000096777.59..10000096777.60 rows=1 width=32) (actual time=203.134..203.134 rows=1 loops=1)
   ->  Sort  (cost=10000096777.59..10000096777.60 rows=1 width=32) (actual time=203.133..203.133 rows=1 loops=1)
         Sort Key: ((((count(*)))::numeric(15,4) / ((count(*)))::numeric(15,4)))
         Sort Method: quicksort  Memory: 25kB
         ->  Nested Loop  (cost=10000096777.52..10000096777.58 rows=1 width=32) (actual time=203.095..203.095 rows=1 loops=1)
               ->  Finalize Aggregate  (cost=48388.48..48388.49 rows=1 width=8) (actual time=103.474..103.474 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=48388.25..48388.47 rows=2 width=8) (actual time=103.456..103.460 rows=2 loops=1)
               ->  Finalize Aggregate  (cost=48389.04..48389.05 rows=1 width=8) (actual time=99.538..99.538 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=48388.82..48389.04 rows=2 width=8) (actual time=98.893..99.523 rows=2 loops=1)
 Planning time: 0.509 ms
 Execution time: 205.792 ms
(11 rows)

