                                                                 QUERY PLAN                                                                 
--------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=95001.82..95001.83 rows=1 width=32) (actual time=1014.877..1014.877 rows=1 loops=1)
   ->  Aggregate  (cost=95001.82..95001.83 rows=1 width=32) (actual time=1014.875..1014.876 rows=1 loops=1)
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=4771.57..95001.82 rows=1 width=6) (actual time=448.760..1014.842 rows=31 loops=1)
 Planning time: 0.481 ms
 Execution time: 1018.671 ms
(5 rows)

