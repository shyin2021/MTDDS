                                                                QUERY PLAN                                                                 
-------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=149268656.46..149268656.67 rows=21 width=51) (actual time=583.327..583.327 rows=0 loops=1)
   ->  Remote Subquery Scan on all (dn1)  (cost=149268656.46..149268656.67 rows=21 width=51) (actual time=583.326..583.326 rows=0 loops=1)
 Planning time: 0.396 ms
 Execution time: 587.023 ms
(4 rows)

