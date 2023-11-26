                                                                         QUERY PLAN                                                                         
------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=253535.53..253535.53 rows=1 width=72) (actual time=9364.303..9364.303 rows=1 loops=1)
   ->  Sort  (cost=253535.53..253535.53 rows=1 width=72) (actual time=9364.302..9364.302 rows=1 loops=1)
         Sort Key: (count(DISTINCT cs1.cs_order_number))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=253535.51..253535.52 rows=1 width=72) (actual time=9364.297..9364.297 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=226332.25..253535.49 rows=1 width=16) (actual time=9127.017..9363.870 rows=773 loops=1)
 Planning time: 1.639 ms
 Execution time: 9375.626 ms
(8 rows)

SET
