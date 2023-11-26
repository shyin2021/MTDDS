                                                              QUERY PLAN                                                              
--------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=47583.96..47583.97 rows=1 width=32) (actual time=310.054..310.055 rows=1 loops=1)
   ->  Aggregate  (cost=47583.96..47583.97 rows=1 width=32) (actual time=310.054..310.054 rows=1 loops=1)
         ->  Remote Subquery Scan on all (dn0)  (cost=2418.68..47583.96 rows=1 width=6) (actual time=310.040..310.041 rows=5 loops=1)
 Planning time: 0.432 ms
 Execution time: 310.921 ms
(5 rows)

