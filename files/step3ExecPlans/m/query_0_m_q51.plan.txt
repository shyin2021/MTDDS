                                                                                       QUERY PLAN                                                                                        
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=190696.46..190706.96 rows=100 width=136) (actual time=3602.822..3603.911 rows=100 loops=1)
   CTE web_v1
     ->  WindowAgg  (cost=45496.66..46511.57 rows=6817 width=40) (actual time=148.057..629.764 rows=280926 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=45496.66..46392.27 rows=6817 width=40) (actual time=148.046..485.046 rows=280926 loops=1)
   CTE store_v1
     ->  WindowAgg  (cost=134682.44..138745.47 rows=27287 width=40) (actual time=569.304..2223.073 rows=953965 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=134682.44..138267.95 rows=27287 width=40) (actual time=569.294..1751.043 rows=953965 loops=1)
   ->  Subquery Scan on y  (cost=5439.42..6394.47 rows=9096 width=136) (actual time=3602.821..3603.904 rows=100 loops=1)
         Filter: (y.web_cumulative > y.store_cumulative)
         Rows Removed by Filter: 2132
         ->  WindowAgg  (cost=5439.42..6053.38 rows=27287 width=136) (actual time=3602.762..3603.773 rows=2232 loops=1)
               ->  Sort  (cost=5439.42..5507.64 rows=27287 width=72) (actual time=3602.754..3602.834 rows=2233 loops=1)
                     Sort Key: (CASE WHEN (web.item_sk IS NOT NULL) THEN web.item_sk ELSE store.item_sk END), (CASE WHEN (web.d_date IS NOT NULL) THEN web.d_date ELSE store.d_date END)
                     Sort Method: quicksort  Memory: 99332kB
                     ->  Merge Full Join  (cost=3126.65..3428.93 rows=27287 width=72) (actual time=3246.371..3449.601 rows=1164405 loops=1)
                           Merge Cond: ((web.item_sk = store.item_sk) AND (web.d_date = store.d_date))
                           ->  Sort  (cost=570.41..587.45 rows=6817 width=40) (actual time=724.272..733.642 rows=280926 loops=1)
                                 Sort Key: web.item_sk, web.d_date
                                 Sort Method: quicksort  Memory: 25457kB
                                 ->  CTE Scan on web_v1 web  (cost=0.00..136.34 rows=6817 width=40) (actual time=148.059..688.438 rows=280926 loops=1)
                           ->  Sort  (cost=2556.24..2624.45 rows=27287 width=40) (actual time=2522.095..2553.455 rows=953965 loops=1)
                                 Sort Key: store.item_sk, store.d_date
                                 Sort Method: quicksort  Memory: 69294kB
                                 ->  CTE Scan on store_v1 store  (cost=0.00..545.74 rows=27287 width=40) (actual time=569.305..2416.445 rows=953965 loops=1)
 Planning time: 0.417 ms
 Execution time: 3627.621 ms
(26 rows)

