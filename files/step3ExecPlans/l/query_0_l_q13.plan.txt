                                                                  QUERY PLAN                                                                  
----------------------------------------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=364177.37..364177.38 rows=1 width=128) (actual time=1200.201..1200.201 rows=1 loops=1)
   ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=64817.26..364177.35 rows=1 width=16) (actual time=1193.039..1200.166 rows=22 loops=1)
 Planning time: 1.083 ms
 Execution time: 1207.520 ms
(4 rows)

