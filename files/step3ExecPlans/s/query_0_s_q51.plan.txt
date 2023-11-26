                                                                                       QUERY PLAN                                                                                        
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=99029.77..99040.27 rows=100 width=136) (actual time=1977.487..1979.030 rows=100 loops=1)
   CTE web_v1
     ->  WindowAgg  (cost=24563.92..25091.73 rows=3545 width=40) (actual time=142.721..349.422 rows=143038 loops=1)
           ->  Remote Subquery Scan on all (dn0)  (cost=24563.92..25029.69 rows=3545 width=40) (actual time=142.692..226.411 rows=143038 loops=1)
   CTE store_v1
     ->  WindowAgg  (cost=69156.56..71270.32 rows=14197 width=40) (actual time=538.879..1265.053 rows=492490 loops=1)
           ->  Remote Subquery Scan on all (dn0)  (cost=69156.56..71021.87 rows=14197 width=40) (actual time=538.849..844.468 rows=492490 loops=1)
   ->  Subquery Scan on y  (cost=2667.73..3164.62 rows=4732 width=136) (actual time=1977.486..1979.022 rows=100 loops=1)
         Filter: (y.web_cumulative > y.store_cumulative)
         Rows Removed by Filter: 2907
         ->  WindowAgg  (cost=2667.73..2987.16 rows=14197 width=136) (actual time=1977.452..1978.839 rows=3007 loops=1)
               ->  Sort  (cost=2667.73..2703.22 rows=14197 width=72) (actual time=1977.442..1977.537 rows=3008 loops=1)
                     Sort Key: (CASE WHEN (web.item_sk IS NOT NULL) THEN web.item_sk ELSE store.item_sk END), (CASE WHEN (web.d_date IS NOT NULL) THEN web.d_date ELSE store.d_date END)
                     Sort Method: quicksort  Memory: 53947kB
                     ->  Merge Full Join  (cost=1542.96..1688.61 rows=14197 width=72) (actual time=1789.685..1893.421 rows=608686 loops=1)
                           Merge Cond: ((web.item_sk = store.item_sk) AND (web.d_date = store.d_date))
                           ->  Sort  (cost=279.91..288.77 rows=3545 width=40) (actual time=390.623..395.289 rows=143038 loops=1)
                                 Sort Key: web.item_sk, web.d_date
                                 Sort Method: quicksort  Memory: 12849kB
                                 ->  CTE Scan on web_v1 web  (cost=0.00..70.90 rows=3545 width=40) (actual time=142.722..374.501 rows=143038 loops=1)
                           ->  Sort  (cost=1263.06..1298.55 rows=14197 width=40) (actual time=1399.058..1415.412 rows=492490 loops=1)
                                 Sort Key: store.item_sk, store.d_date
                                 Sort Method: quicksort  Memory: 35374kB
                                 ->  CTE Scan on store_v1 store  (cost=0.00..283.94 rows=14197 width=40) (actual time=538.880..1346.778 rows=492490 loops=1)
 Planning time: 0.313 ms
 Execution time: 1993.576 ms
(26 rows)

