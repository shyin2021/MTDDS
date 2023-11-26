                                                                                                           QUERY PLAN                                                                                                           
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=51455.81..51455.82 rows=1 width=690) (actual time=1335.235..1335.252 rows=100 loops=1)
   CTE v1
     ->  WindowAgg  (cost=47890.62..49466.43 rows=8407 width=194) (actual time=1097.844..1243.414 rows=25263 loops=1)
           ->  WindowAgg  (cost=47890.62..49256.25 rows=8407 width=186) (actual time=1097.842..1227.970 rows=25263 loops=1)
                 ->  Finalize GroupAggregate  (cost=47890.62..49067.10 rows=8407 width=154) (actual time=1097.833..1209.926 rows=25263 loops=1)
                       Group Key: i_category, i_brand, cc_name, d_year, d_moy
                       ->  Remote Subquery Scan on all (dn0)  (cost=47890.62..48839.40 rows=7006 width=154) (actual time=1097.806..1178.941 rows=25263 loops=1)
   CTE v2
     ->  Hash Join  (cost=1684.57..1989.34 rows=1 width=658) (actual time=1295.466..1308.953 rows=19663 loops=1)
           Hash Cond: ((v1_lead.i_category = v1.i_category) AND (v1_lead.i_brand = v1.i_brand) AND ((v1_lead.cc_name)::text = (v1.cc_name)::text) AND ((v1_lead.rn - 1) = v1.rn))
           ->  CTE Scan on v1 v1_lead  (cost=0.00..168.14 rows=8407 width=566) (actual time=1097.845..1099.745 rows=25263 loops=1)
           ->  Hash  (cost=1684.55..1684.55 rows=1 width=1168) (actual time=197.604..197.604 rows=22033 loops=1)
                 Buckets: 32768 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 6978kB
                 ->  Merge Join  (cost=1432.33..1684.55 rows=1 width=1168) (actual time=173.915..188.568 rows=22033 loops=1)
                       Merge Cond: ((v1.i_category = v1_lag.i_category) AND (v1.i_brand = v1_lag.i_brand) AND ((v1.cc_name)::text = (v1_lag.cc_name)::text) AND (v1.rn = ((v1_lag.rn + 1))))
                       ->  Sort  (cost=716.17..737.18 rows=8407 width=602) (actual time=162.863..163.717 rows=24986 loops=1)
                             Sort Key: v1.i_category, v1.i_brand, v1.cc_name, v1.rn
                             Sort Method: quicksort  Memory: 7415kB
                             ->  CTE Scan on v1  (cost=0.00..168.14 rows=8407 width=602) (actual time=0.001..154.908 rows=25263 loops=1)
                       ->  Sort  (cost=716.17..737.18 rows=8407 width=566) (actual time=11.045..12.121 rows=24966 loops=1)
                             Sort Key: v1_lag.i_category, v1_lag.i_brand, v1_lag.cc_name, ((v1_lag.rn + 1))
                             Sort Method: quicksort  Memory: 7415kB
                             ->  CTE Scan on v1 v1_lag  (cost=0.00..168.14 rows=8407 width=566) (actual time=0.001..3.114 rows=25263 loops=1)
   ->  Sort  (cost=0.05..0.06 rows=1 width=690) (actual time=1335.234..1335.238 rows=100 loops=1)
         Sort Key: ((v2.sum_sales - v2.avg_monthly_sales)), v2.avg_monthly_sales
         Sort Method: top-N heapsort  Memory: 70kB
         ->  CTE Scan on v2  (cost=0.00..0.04 rows=1 width=690) (actual time=1295.470..1329.913 rows=17977 loops=1)
               Filter: ((avg_monthly_sales > '0'::numeric) AND (d_year = 2001) AND (CASE WHEN (avg_monthly_sales > '0'::numeric) THEN (abs((sum_sales - avg_monthly_sales)) / avg_monthly_sales) ELSE NULL::numeric END > 0.1))
               Rows Removed by Filter: 1686
 Planning time: 0.605 ms
 Execution time: 1342.678 ms
(31 rows)

