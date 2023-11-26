                                                                       QUERY PLAN                                                                       
--------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=349620.64..349620.65 rows=1 width=24) (actual time=3802.033..3802.034 rows=1 loops=1)
   CTE ssci
     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=201744.53..205758.86 rows=38793 width=8) (actual time=455.484..1799.871 rows=1619583 loops=1)
   CTE csci
     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=135437.70..137444.61 rows=19395 width=8) (actual time=257.084..966.477 rows=855299 loops=1)
   ->  Aggregate  (cost=6417.18..6417.19 rows=1 width=24) (actual time=3802.032..3802.032 rows=1 loops=1)
         ->  Merge Full Join  (cost=5501.72..6126.23 rows=38793 width=8) (actual time=3227.404..3565.175 rows=2474546 loops=1)
               Merge Cond: ((ssci.customer_sk = csci.customer_sk) AND (ssci.item_sk = csci.item_sk))
               ->  Sort  (cost=3732.57..3829.55 rows=38793 width=8) (actual time=2093.287..2145.017 rows=1619583 loops=1)
                     Sort Key: ssci.customer_sk, ssci.item_sk
                     Sort Method: quicksort  Memory: 119609kB
                     ->  CTE Scan on ssci  (cost=0.00..775.86 rows=38793 width=8) (actual time=455.486..1958.784 rows=1619583 loops=1)
               ->  Sort  (cost=1769.15..1817.64 rows=19395 width=8) (actual time=1134.112..1161.756 rows=855299 loops=1)
                     Sort Key: csci.customer_sk, csci.item_sk
                     Sort Method: quicksort  Memory: 64669kB
                     ->  CTE Scan on csci  (cost=0.00..387.90 rows=19395 width=8) (actual time=257.087..1055.011 rows=855299 loops=1)
 Planning time: 0.467 ms
 Execution time: 3842.545 ms
(18 rows)

