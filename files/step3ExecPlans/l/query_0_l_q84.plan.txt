                                                                  QUERY PLAN                                                                  
----------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=78123.78..78124.53 rows=100 width=49) (actual time=316.091..316.430 rows=100 loops=1)
   ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=78123.78..78124.53 rows=100 width=49) (actual time=316.089..316.405 rows=100 loops=1)
 Planning time: 0.716 ms
 Execution time: 323.499 ms
(4 rows)

