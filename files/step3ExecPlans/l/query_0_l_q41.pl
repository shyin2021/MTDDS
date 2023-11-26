                                                                QUERY PLAN                                                                
------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=286131638.10..286131638.17 rows=7 width=51) (actual time=432.761..432.761 rows=0 loops=1)
   ->  Remote Subquery Scan on all (dn2)  (cost=286131638.10..286131638.17 rows=7 width=51) (actual time=432.760..432.760 rows=0 loops=1)
 Planning time: 1.592 ms
 Execution time: 437.452 ms
(4 rows)

