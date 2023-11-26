                                                                    QUERY PLAN                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=72457.32..72457.32 rows=1 width=72) (actual time=817.868..817.869 rows=1 loops=1)
   ->  Sort  (cost=72457.32..72457.32 rows=1 width=72) (actual time=817.867..817.867 rows=1 loops=1)
         Sort Key: (count(DISTINCT ws1.ws_order_number))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=72457.30..72457.31 rows=1 width=72) (actual time=817.862..817.862 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=2704.40..72457.28 rows=1 width=16) (actual time=779.438..817.786 rows=77 loops=1)
 Planning time: 1.220 ms
 Execution time: 820.483 ms
(8 rows)

SET
