                                                                QUERY PLAN                                                                
------------------------------------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=263584.05..263584.06 rows=1 width=128) (actual time=1210.102..1210.102 rows=1 loops=1)
   ->  Remote Subquery Scan on all (dn1,dn2)  (cost=63968.30..263584.03 rows=1 width=16) (actual time=1210.072..1210.076 rows=11 loops=1)
 Planning time: 1.258 ms
 Execution time: 1213.103 ms
(4 rows)

