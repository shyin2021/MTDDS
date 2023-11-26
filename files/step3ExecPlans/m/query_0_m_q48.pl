                                                               QUERY PLAN                                                                
-----------------------------------------------------------------------------------------------------------------------------------------
 Finalize Aggregate  (cost=263905.88..263905.89 rows=1 width=8) (actual time=1213.192..1213.192 rows=1 loops=1)
   ->  Remote Subquery Scan on all (dn1,dn2)  (cost=263905.86..263905.87 rows=1 width=8) (actual time=1213.175..1213.179 rows=2 loops=1)
 Planning time: 0.832 ms
 Execution time: 1217.165 ms
(4 rows)

