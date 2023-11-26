                                                                     QUERY PLAN                                                                      
-----------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=29515.02..29515.02 rows=1 width=72) (actual time=383.470..383.470 rows=1 loops=1)
   ->  Sort  (cost=29515.02..29515.02 rows=1 width=72) (actual time=383.469..383.469 rows=1 loops=1)
         Sort Key: (count(DISTINCT ws1.ws_order_number))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=29515.00..29515.01 rows=1 width=72) (actual time=383.315..383.315 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn0,dn1,dn2)  (cost=788.88..29514.98 rows=1 width=16) (actual time=251.999..383.240 rows=11 loops=1)
 Planning time: 1.555 ms
 Execution time: 430.513 ms
(8 rows)

SET
