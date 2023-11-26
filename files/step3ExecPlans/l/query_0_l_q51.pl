                                                                                       QUERY PLAN                                                                                        
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=285223.65..285234.15 rows=100 width=136) (actual time=6208.016..6209.690 rows=100 loops=1)
   CTE web_v1
     ->  WindowAgg  (cost=68175.62..69619.69 rows=9699 width=40) (actual time=165.924..1023.836 rows=415364 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=68175.62..69449.96 rows=9699 width=40) (actual time=165.912..814.090 rows=415364 loops=1)
   CTE store_v1
     ->  WindowAgg  (cost=201844.53..207620.71 rows=38793 width=40) (actual time=614.963..4004.508 rows=1420126 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=201844.53..206941.83 rows=38793 width=40) (actual time=614.932..3177.307 rows=1420126 loops=1)
   ->  Subquery Scan on y  (cost=7983.25..9341.01 rows=12931 width=136) (actual time=6208.015..6209.683 rows=100 loops=1)
         Filter: (y.web_cumulative > y.store_cumulative)
         Rows Removed by Filter: 3146
         ->  WindowAgg  (cost=7983.25..8856.10 rows=38793 width=136) (actual time=6208.007..6209.482 rows=3246 loops=1)
               ->  Sort  (cost=7983.25..8080.24 rows=38793 width=72) (actual time=6207.998..6208.115 rows=3247 loops=1)
                     Sort Key: (CASE WHEN (web.item_sk IS NOT NULL) THEN web.item_sk ELSE store.item_sk END), (CASE WHEN (web.d_date IS NOT NULL) THEN web.d_date ELSE store.d_date END)
                     Sort Method: quicksort  Memory: 126771kB
                     ->  Merge Full Join  (cost=4568.80..5026.55 rows=38793 width=72) (actual time=5672.663..5985.349 rows=1724275 loops=1)
                           Merge Cond: ((web.item_sk = store.item_sk) AND (web.d_date = store.d_date))
                           ->  Sort  (cost=836.23..860.48 rows=9699 width=40) (actual time=1153.204..1167.459 rows=415364 loops=1)
                                 Sort Key: web.item_sk, web.d_date
                                 Sort Method: quicksort  Memory: 31759kB
                                 ->  CTE Scan on web_v1 web  (cost=0.00..193.98 rows=9699 width=40) (actual time=165.926..1110.035 rows=415364 loops=1)
                           ->  Sort  (cost=3732.57..3829.55 rows=38793 width=40) (actual time=4519.455..4566.831 rows=1420126 loops=1)
                                 Sort Key: store.item_sk, store.d_date
                                 Sort Method: quicksort  Memory: 110260kB
                                 ->  CTE Scan on store_v1 store  (cost=0.00..775.86 rows=38793 width=40) (actual time=614.967..4334.432 rows=1420126 loops=1)
 Planning time: 0.357 ms
 Execution time: 6251.576 ms
(26 rows)

