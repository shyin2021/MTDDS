                                                                                                                                                                                                                             QUERY PLAN                                                                                                                                                                                                                             
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=423998.53..423998.53 rows=1 width=210) (actual time=2054.503..2054.504 rows=43 loops=1)
   Sort Key: ((ss3.store_sales / ss2.store_sales))
   Sort Method: quicksort  Memory: 31kB
   CTE ss
     ->  Finalize HashAggregate  (cost=170818.91..189371.21 rows=1484184 width=54) (actual time=1537.583..1554.642 rows=35136 loops=1)
           Group Key: ca_county, d_qoy, d_year
           ->  Remote Subquery Scan on all (dn0)  (cost=126293.39..152266.61 rows=1484184 width=54) (actual time=1465.580..1505.754 rows=35136 loops=1)
   CTE ws
     ->  Finalize HashAggregate  (cost=60366.45..69358.75 rows=719384 width=54) (actual time=467.252..476.803 rows=23320 loops=1)
           Group Key: ca_county, d_qoy, d_year
           ->  Remote Subquery Scan on all (dn0)  (cost=38784.93..51374.15 rows=719384 width=54) (actual time=439.491..447.089 rows=23320 loops=1)
   ->  Hash Join  (cost=128163.77..165268.56 rows=1 width=210) (actual time=2051.688..2054.481 rows=43 loops=1)
         Hash Cond: ((ss2.ca_county)::text = (ss1.ca_county)::text)
         Join Filter: ((CASE WHEN (ws1.web_sales > '0'::numeric) THEN (ws2.web_sales / ws1.web_sales) ELSE NULL::numeric END > CASE WHEN (ss1.store_sales > '0'::numeric) THEN (ss2.store_sales / ss1.store_sales) ELSE NULL::numeric END) AND (CASE WHEN (ws2.web_sales > '0'::numeric) THEN (ws3.web_sales / ws2.web_sales) ELSE NULL::numeric END > CASE WHEN (ss2.store_sales > '0'::numeric) THEN (ss3.store_sales / ss2.store_sales) ELSE NULL::numeric END))
         Rows Removed by Join Filter: 324
         ->  CTE Scan on ss ss2  (cost=0.00..37104.60 rows=37 width=110) (actual time=1537.597..1539.739 rows=1635 loops=1)
               Filter: ((d_year = 1999) AND (d_qoy = 2))
               Rows Removed by Filter: 33501
         ->  Hash  (cost=128163.76..128163.76 rows=1 width=554) (actual time=514.005..514.005 rows=381 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 67kB
               ->  Hash Join  (cost=91059.01..128163.76 rows=1 width=554) (actual time=511.583..513.894 rows=381 loops=1)
                     Hash Cond: ((ss3.ca_county)::text = (ss1.ca_county)::text)
                     ->  CTE Scan on ss ss3  (cost=0.00..37104.60 rows=37 width=110) (actual time=0.001..2.099 rows=1798 loops=1)
                           Filter: ((d_year = 1999) AND (d_qoy = 3))
                           Rows Removed by Filter: 33338
                     ->  Hash  (cost=91059.00..91059.00 rows=1 width=444) (actual time=511.578..511.578 rows=384 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 58kB
                           ->  Hash Join  (cost=53954.25..91059.00 rows=1 width=444) (actual time=485.782..511.407 rows=384 loops=1)
                                 Hash Cond: ((ss1.ca_county)::text = (ws1.ca_county)::text)
                                 ->  CTE Scan on ss ss1  (cost=0.00..37104.60 rows=37 width=114) (actual time=0.001..25.344 rows=1647 loops=1)
                                       Filter: ((d_qoy = 1) AND (d_year = 1999))
                                       Rows Removed by Filter: 33489
                                 ->  Hash  (cost=53954.24..53954.24 rows=1 width=330) (actual time=485.776..485.776 rows=400 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 49kB
                                       ->  Hash Join  (cost=35969.56..53954.24 rows=1 width=330) (actual time=484.129..485.685 rows=400 loops=1)
                                             Hash Cond: ((ws3.ca_county)::text = (ws1.ca_county)::text)
                                             ->  CTE Scan on ws ws3  (cost=0.00..17984.60 rows=18 width=110) (actual time=467.259..468.658 rows=1261 loops=1)
                                                   Filter: ((d_year = 1999) AND (d_qoy = 3))
                                                   Rows Removed by Filter: 22059
                                             ->  Hash  (cost=35969.54..35969.54 rows=2 width=220) (actual time=16.862..16.862 rows=503 loops=1)
                                                   Buckets: 1024  Batches: 1  Memory Usage: 48kB
                                                   ->  Hash Join  (cost=17984.83..35969.54 rows=2 width=220) (actual time=15.253..16.771 rows=503 loops=1)
                                                         Hash Cond: ((ws1.ca_county)::text = (ws2.ca_county)::text)
                                                         ->  CTE Scan on ws ws1  (cost=0.00..17984.60 rows=18 width=110) (actual time=0.001..1.369 rows=911 loops=1)
                                                               Filter: ((d_qoy = 1) AND (d_year = 1999))
                                                               Rows Removed by Filter: 22409
                                                         ->  Hash  (cost=17984.60..17984.60 rows=18 width=110) (actual time=15.247..15.247 rows=924 loops=1)
                                                               Buckets: 1024  Batches: 1  Memory Usage: 59kB
                                                               ->  CTE Scan on ws ws2  (cost=0.00..17984.60 rows=18 width=110) (actual time=0.016..15.083 rows=925 loops=1)
                                                                     Filter: ((d_year = 1999) AND (d_qoy = 2))
                                                                     Rows Removed by Filter: 22395
 Planning time: 1.362 ms
 Execution time: 2092.696 ms
(53 rows)

