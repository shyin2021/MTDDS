                                                                 QUERY PLAN                                                                  
---------------------------------------------------------------------------------------------------------------------------------------------
 Finalize Aggregate  (cost=365145.31..365145.32 rows=1 width=8) (actual time=1231.375..1231.375 rows=1 loops=1)
   ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=365145.29..365145.31 rows=1 width=8) (actual time=1208.280..1231.360 rows=3 loops=1)
 Planning time: 0.792 ms
 Execution time: 1239.054 ms
(4 rows)

