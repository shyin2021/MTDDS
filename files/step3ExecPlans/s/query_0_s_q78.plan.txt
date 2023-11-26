                                                                                                                                                                                                        QUERY PLAN                                                                                                                                                                                                        
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=294132.80..294133.05 rows=100 width=180) (actual time=25411.162..25432.772 rows=100 loops=1)
   CTE ws
     ->  Remote Subquery Scan on all (dn0)  (cost=47196.94..51570.17 rows=291549 width=84) (actual time=1079.278..1332.013 rows=647429 loops=1)
   CTE cs
     ->  Remote Subquery Scan on all (dn0)  (cost=93053.97..101296.32 rows=549490 width=84) (actual time=3200.576..3836.142 rows=1290853 loops=1)
   CTE ss
     ->  Remote Subquery Scan on all (dn0)  (cost=119974.11..120761.13 rows=52468 width=84) (actual time=15266.037..16479.523 rows=2449192 loops=1)
   ->  Sort  (cost=20505.17..20505.53 rows=146 width=180) (actual time=25411.161..25411.169 rows=100 loops=1)
         Sort Key: ss.ss_customer_sk, ss.ss_qty DESC, ss.ss_wc DESC, ss.ss_sp DESC, ((COALESCE(ws.ws_qty, '0'::bigint) + COALESCE(cs.cs_qty, '0'::bigint))), ((COALESCE(ws.ws_wc, '0'::numeric) + COALESCE(cs.cs_wc, '0'::numeric))), ((COALESCE(ws.ws_sp, '0'::numeric) + COALESCE(cs.cs_sp, '0'::numeric))), (round(((ss.ss_qty / (COALESCE(ws.ws_qty, '0'::bigint) + COALESCE(cs.cs_qty, '0'::bigint))))::numeric, 2))
         Sort Method: quicksort  Memory: 50kB
         ->  Hash Right Join  (cost=7845.13..20499.92 rows=146 width=180) (actual time=23576.169..25409.771 rows=178 loops=1)
               Hash Cond: ((cs.cs_sold_year = ss.ss_sold_year) AND (cs.cs_item_sk = ss.ss_item_sk) AND (cs.cs_customer_sk = ss.ss_customer_sk))
               Filter: ((COALESCE(ws.ws_qty, '0'::bigint) > 0) OR (COALESCE(cs.cs_qty, '0'::bigint) > 0))
               Rows Removed by Filter: 490259
               ->  CTE Scan on cs  (cost=0.00..12363.52 rows=2747 width=84) (actual time=3206.179..4650.745 rows=257020 loops=1)
                     Filter: (cs_sold_year = 1998)
                     Rows Removed by Filter: 1033833
               ->  Hash  (cost=7840.55..7840.55 rows=262 width=156) (actual time=20248.690..20248.690 rows=490437 loops=1)
                     Buckets: 524288 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 42045kB
                     ->  Merge Left Join  (cost=7827.52..7840.55 rows=262 width=156) (actual time=20002.805..20168.573 rows=490437 loops=1)
                           Merge Cond: ((ss.ss_item_sk = ws.ws_item_sk) AND (ss.ss_customer_sk = ws.ws_customer_sk))
                           Join Filter: (ws.ws_sold_year = ss.ss_sold_year)
                           ->  Sort  (cost=1191.05..1191.71 rows=262 width=84) (actual time=18206.975..18271.361 rows=490437 loops=1)
                                 Sort Key: ss.ss_item_sk, ss.ss_customer_sk
                                 Sort Method: quicksort  Memory: 50495kB
                                 ->  CTE Scan on ss  (cost=0.00..1180.53 rows=262 width=84) (actual time=15266.057..17972.895 rows=490437 loops=1)
                                       Filter: (ss_sold_year = 1998)
                                       Rows Removed by Filter: 1958755
                           ->  Sort  (cost=6636.47..6640.11 rows=1458 width=84) (actual time=1795.824..1812.498 rows=128881 loops=1)
                                 Sort Key: ws.ws_item_sk, ws.ws_customer_sk
                                 Sort Method: quicksort  Memory: 13141kB
                                 ->  CTE Scan on ws  (cost=0.00..6559.85 rows=1458 width=84) (actual time=1079.293..1708.143 rows=128881 loops=1)
                                       Filter: (ws_sold_year = 1998)
                                       Rows Removed by Filter: 518548
 Planning time: 4.805 ms
 Execution time: 26832.321 ms
(36 rows)

