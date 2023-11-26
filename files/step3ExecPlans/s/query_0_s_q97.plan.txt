                                                                 QUERY PLAN                                                                 
--------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=117626.21..117626.22 rows=1 width=24) (actual time=1450.320..1450.320 rows=1 loops=1)
   CTE ssci
     ->  Remote Subquery Scan on all (dn0)  (cost=68077.95..69265.56 rows=11476 width=8) (actual time=449.565..638.511 rows=548694 loops=1)
   CTE csci
     ->  Remote Subquery Scan on all (dn0)  (cost=46057.85..46652.15 rows=5743 width=8) (actual time=233.479..334.711 rows=287769 loops=1)
   ->  Aggregate  (cost=1708.50..1708.51 rows=1 width=24) (actual time=1450.319..1450.319 rows=1 loops=1)
         ->  Merge Full Join  (cost=1476.81..1622.43 rows=11476 width=8) (actual time=1253.440..1371.481 rows=836302 loops=1)
               Merge Cond: ((ssci.customer_sk = csci.customer_sk) AND (ssci.item_sk = csci.item_sk))
               ->  Sort  (cost=1003.37..1032.06 rows=11476 width=8) (actual time=827.776..848.232 rows=548694 loops=1)
                     Sort Key: ssci.customer_sk, ssci.item_sk
                     Sort Method: quicksort  Memory: 50297kB
                     ->  CTE Scan on ssci  (cost=0.00..229.52 rows=11476 width=8) (actual time=449.574..771.937 rows=548694 loops=1)
               ->  Sort  (cost=473.44..487.80 rows=5743 width=8) (actual time=425.660..435.431 rows=287769 loops=1)
                     Sort Key: csci.customer_sk, csci.item_sk
                     Sort Method: quicksort  Memory: 25778kB
                     ->  CTE Scan on csci  (cost=0.00..114.86 rows=5743 width=8) (actual time=233.489..401.688 rows=287769 loops=1)
 Planning time: 0.369 ms
 Execution time: 1461.026 ms
(18 rows)

