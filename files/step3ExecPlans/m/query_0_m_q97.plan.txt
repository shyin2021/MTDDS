                                                                     QUERY PLAN                                                                     
----------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=233544.71..233544.72 rows=1 width=24) (actual time=2711.915..2711.915 rows=1 loops=1)
   CTE ssci
     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=134582.44..137406.18 rows=27287 width=8) (actual time=439.460..1237.520 rows=1080732 loops=1)
   CTE csci
     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=90356.34..91767.96 rows=13641 width=8) (actual time=240.475..690.044 rows=569976 loops=1)
   ->  Aggregate  (cost=4370.57..4370.58 rows=1 width=24) (actual time=2711.913..2711.913 rows=1 loops=1)
         ->  Merge Full Join  (cost=3765.90..4165.92 rows=27287 width=8) (actual time=2329.259..2556.241 rows=1650395 loops=1)
               Merge Cond: ((ssci.customer_sk = csci.customer_sk) AND (ssci.item_sk = csci.item_sk))
               ->  Sort  (cost=2556.24..2624.45 rows=27287 width=8) (actual time=1505.747..1540.932 rows=1080732 loops=1)
                     Sort Key: ssci.customer_sk, ssci.item_sk
                     Sort Method: quicksort  Memory: 94350kB
                     ->  CTE Scan on ssci  (cost=0.00..545.74 rows=27287 width=8) (actual time=439.462..1374.941 rows=1080732 loops=1)
               ->  Sort  (cost=1209.66..1243.76 rows=13641 width=8) (actual time=823.507..843.852 rows=569976 loops=1)
                     Sort Key: csci.customer_sk, csci.item_sk
                     Sort Method: quicksort  Memory: 51294kB
                     ->  CTE Scan on csci  (cost=0.00..272.82 rows=13641 width=8) (actual time=240.477..761.318 rows=569976 loops=1)
 Planning time: 0.481 ms
 Execution time: 2734.647 ms
(18 rows)

