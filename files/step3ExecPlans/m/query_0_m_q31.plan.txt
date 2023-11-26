                                                                                                                                                                                                                             QUERY PLAN                                                                                                                                                                                                                             
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=1368899.76..1368899.77 rows=1 width=210) (actual time=7500.126..7500.133 rows=129 loops=1)
   Sort Key: ((ws2.web_sales / ws1.web_sales))
   Sort Method: quicksort  Memory: 43kB
   CTE ss
     ->  Finalize GroupAggregate  (cost=434447.00..893978.20 rows=1476800 width=54) (actual time=3872.855..4956.940 rows=37360 loops=1)
           Group Key: ca_county, d_qoy, d_year
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=434447.00..838598.20 rows=2953600 width=54) (actual time=3872.844..4907.993 rows=74712 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=213039.10..256216.51 rows=1439247 width=54) (actual time=1004.894..2506.495 rows=30559 loops=1)
           Group Key: ca_county, d_qoy, d_year
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=213039.10..223833.45 rows=1439247 width=28) (actual time=1004.880..2229.560 rows=1438728 loops=1)
   ->  Hash Join  (cost=181784.86..218705.04 rows=1 width=210) (actual time=7495.030..7500.068 rows=129 loops=1)
         Hash Cond: ((ss2.ca_county)::text = (ss1.ca_county)::text)
         Join Filter: ((CASE WHEN (ws1.web_sales > '0'::numeric) THEN (ws2.web_sales / ws1.web_sales) ELSE NULL::numeric END > CASE WHEN (ss1.store_sales > '0'::numeric) THEN (ss2.store_sales / ss1.store_sales) ELSE NULL::numeric END) AND (CASE WHEN (ws2.web_sales > '0'::numeric) THEN (ws3.web_sales / ws2.web_sales) ELSE NULL::numeric END > CASE WHEN (ss2.store_sales > '0'::numeric) THEN (ss3.store_sales / ss2.store_sales) ELSE NULL::numeric END))
         Rows Removed by Join Filter: 766
         ->  CTE Scan on ss ss2  (cost=0.00..36920.00 rows=37 width=110) (actual time=3872.876..3875.926 rows=1818 loops=1)
               Filter: ((d_year = 2000) AND (d_qoy = 2))
               Rows Removed by Filter: 35542
         ->  Hash  (cost=181784.85..181784.85 rows=1 width=554) (actual time=3622.126..3622.126 rows=904 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 148kB
               ->  Hash Join  (cost=144864.70..181784.85 rows=1 width=554) (actual time=3619.043..3621.858 rows=904 loops=1)
                     Hash Cond: ((ss3.ca_county)::text = (ss1.ca_county)::text)
                     ->  CTE Scan on ss ss3  (cost=0.00..36920.00 rows=37 width=110) (actual time=0.014..2.440 rows=1844 loops=1)
                           Filter: ((d_year = 2000) AND (d_qoy = 3))
                           Rows Removed by Filter: 35516
                     ->  Hash  (cost=144864.69..144864.69 rows=1 width=444) (actual time=3619.024..3619.024 rows=906 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 127kB
                           ->  Hash Join  (cost=107944.54..144864.69 rows=1 width=444) (actual time=2521.965..3618.299 rows=906 loops=1)
                                 Hash Cond: ((ss1.ca_county)::text = (ws1.ca_county)::text)
                                 ->  CTE Scan on ss ss1  (cost=0.00..36920.00 rows=37 width=114) (actual time=0.001..1094.885 rows=1825 loops=1)
                                       Filter: ((d_qoy = 1) AND (d_year = 2000))
                                       Rows Removed by Filter: 35535
                                 ->  Hash  (cost=107944.52..107944.52 rows=1 width=330) (actual time=2521.961..2521.961 rows=919 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 102kB
                                       ->  Hash Join  (cost=71963.21..107944.52 rows=1 width=330) (actual time=2519.477..2521.761 rows=919 loops=1)
                                             Hash Cond: ((ws3.ca_county)::text = (ws1.ca_county)::text)
                                             ->  CTE Scan on ws ws3  (cost=0.00..35981.18 rows=36 width=110) (actual time=1005.106..1007.104 rows=1616 loops=1)
                                                   Filter: ((d_year = 2000) AND (d_qoy = 3))
                                                   Rows Removed by Filter: 28943
                                             ->  Hash  (cost=71963.13..71963.13 rows=6 width=220) (actual time=1514.360..1514.360 rows=1011 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 88kB
                                                   ->  Hash Join  (cost=35981.62..71963.13 rows=6 width=220) (actual time=1511.936..1514.175 rows=1011 loops=1)
                                                         Hash Cond: ((ws1.ca_county)::text = (ws2.ca_county)::text)
                                                         ->  CTE Scan on ws ws1  (cost=0.00..35981.18 rows=36 width=110) (actual time=0.001..1.989 rows=1350 loops=1)
                                                               Filter: ((d_qoy = 1) AND (d_year = 2000))
                                                               Rows Removed by Filter: 29209
                                                         ->  Hash  (cost=35981.18..35981.18 rows=36 width=110) (actual time=1511.930..1511.930 rows=1335 loops=1)
                                                               Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 90kB
                                                               ->  CTE Scan on ws ws2  (cost=0.00..35981.18 rows=36 width=110) (actual time=0.001..1511.197 rows=1336 loops=1)
                                                                     Filter: ((d_year = 2000) AND (d_qoy = 2))
                                                                     Rows Removed by Filter: 29223
 Planning time: 1.344 ms
 Execution time: 7727.657 ms
(53 rows)

