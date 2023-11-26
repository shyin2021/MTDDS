                                                               QUERY PLAN                                                                
-----------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=7950690.61..7950690.87 rows=26 width=51) (actual time=1198.498..1198.499 rows=1 loops=1)
   ->  Remote Subquery Scan on all (dn0)  (cost=7950690.61..7950690.87 rows=26 width=51) (actual time=1198.497..1198.498 rows=1 loops=1)
 Planning time: 0.359 ms
 Execution time: 1200.240 ms
(4 rows)

