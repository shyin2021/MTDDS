                                                                                                                                                                                                                          QUERY PLAN                                                                                                                                                                                                                          
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Hash Join  (cost=1699085.37..1736005.55 rows=1 width=210) (actual time=9650.564..9654.978 rows=168 loops=1)
   Hash Cond: ((ws2.ca_county)::text = (ss1.ca_county)::text)
   Join Filter: ((CASE WHEN (ws1.web_sales > '0'::numeric) THEN (ws2.web_sales / ws1.web_sales) ELSE NULL::numeric END > CASE WHEN (ss1.store_sales > '0'::numeric) THEN (ss2.store_sales / ss1.store_sales) ELSE NULL::numeric END) AND (CASE WHEN (ws2.web_sales > '0'::numeric) THEN (ws3.web_sales / ws2.web_sales) ELSE NULL::numeric END > CASE WHEN (ss2.store_sales > '0'::numeric) THEN (ss3.store_sales / ss2.store_sales) ELSE NULL::numeric END))
   Rows Removed by Join Filter: 1078
   CTE ss
     ->  Finalize GroupAggregate  (cost=659815.96..1134340.76 rows=1476800 width=54) (actual time=4362.140..5662.688 rows=37759 loops=1)
           Group Key: ca_county, d_qoy, d_year
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=659815.96..1078960.76 rows=2953600 width=54) (actual time=4362.093..5588.467 rows=113241 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=323880.34..380143.23 rows=1476800 width=54) (actual time=1092.616..3950.407 rows=33882 loops=1)
           Group Key: ca_county, d_qoy, d_year
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=323880.34..340081.58 rows=2160165 width=28) (actual time=1092.486..3516.286 rows=2159371 loops=1)
   ->  CTE Scan on ws ws2  (cost=0.00..36920.00 rows=37 width=110) (actual time=1092.737..1094.897 rows=1557 loops=1)
         Filter: ((d_year = 1998) AND (d_qoy = 2))
         Rows Removed by Filter: 32325
   ->  Hash  (cost=184601.37..184601.37 rows=1 width=554) (actual time=8557.779..8557.779 rows=1449 loops=1)
         Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 240kB
         ->  Hash Join  (cost=147681.22..184601.37 rows=1 width=554) (actual time=8554.760..8557.311 rows=1449 loops=1)
               Hash Cond: ((ws3.ca_county)::text = (ss1.ca_county)::text)
               ->  CTE Scan on ws ws3  (cost=0.00..36920.00 rows=37 width=110) (actual time=0.198..2.349 rows=1774 loops=1)
                     Filter: ((d_year = 1998) AND (d_qoy = 3))
                     Rows Removed by Filter: 32108
               ->  Hash  (cost=147681.21..147681.21 rows=1 width=444) (actual time=8554.556..8554.556 rows=1504 loops=1)
                     Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 214kB
                     ->  Hash Join  (cost=110761.06..147681.21 rows=1 width=444) (actual time=5682.252..8553.567 rows=1504 loops=1)
                           Hash Cond: ((ws1.ca_county)::text = (ss1.ca_county)::text)
                           ->  CTE Scan on ws ws1  (cost=0.00..36920.00 rows=37 width=110) (actual time=0.000..2869.509 rows=1513 loops=1)
                                 Filter: ((d_qoy = 1) AND (d_year = 1998))
                                 Rows Removed by Filter: 32369
                           ->  Hash  (cost=110761.05..110761.05 rows=1 width=334) (actual time=5682.248..5682.248 rows=1835 loops=1)
                                 Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 214kB
                                 ->  Hash Join  (cost=73840.90..110761.05 rows=1 width=334) (actual time=5678.927..5681.813 rows=1835 loops=1)
                                       Hash Cond: ((ss3.ca_county)::text = (ss1.ca_county)::text)
                                       ->  CTE Scan on ss ss3  (cost=0.00..36920.00 rows=37 width=110) (actual time=4362.560..4365.014 rows=1847 loops=1)
                                             Filter: ((d_year = 1998) AND (d_qoy = 3))
                                             Rows Removed by Filter: 35912
                                       ->  Hash  (cost=73840.81..73840.81 rows=7 width=224) (actual time=1316.344..1316.344 rows=1835 loops=1)
                                             Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 171kB
                                             ->  Hash Join  (cost=36920.46..73840.81 rows=7 width=224) (actual time=1313.045..1315.987 rows=1835 loops=1)
                                                   Hash Cond: ((ss1.ca_county)::text = (ss2.ca_county)::text)
                                                   ->  CTE Scan on ss ss1  (cost=0.00..36920.00 rows=37 width=114) (actual time=0.002..2.544 rows=1840 loops=1)
                                                         Filter: ((d_qoy = 1) AND (d_year = 1998))
                                                         Rows Removed by Filter: 35919
                                                   ->  Hash  (cost=36920.00..36920.00 rows=37 width=110) (actual time=1313.033..1313.033 rows=1842 loops=1)
                                                         Buckets: 2048 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 118kB
                                                         ->  CTE Scan on ss ss2  (cost=0.00..36920.00 rows=37 width=110) (actual time=0.003..1311.930 rows=1843 loops=1)
                                                               Filter: ((d_year = 1998) AND (d_qoy = 2))
                                                               Rows Removed by Filter: 35916
 Planning time: 1.299 ms
 Execution time: 9689.739 ms
(50 rows)

