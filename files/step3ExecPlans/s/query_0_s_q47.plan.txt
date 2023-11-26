                                                                                                                              QUERY PLAN                                                                                                                               
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=77589.23..77589.24 rows=1 width=400) (actual time=3119.073..3119.081 rows=100 loops=1)
   CTE v1
     ->  WindowAgg  (cost=70013.61..73299.06 rows=16800 width=195) (actual time=2522.154..2850.136 rows=63745 loops=1)
           ->  WindowAgg  (cost=70013.61..72837.06 rows=16800 width=187) (actual time=2522.151..2807.181 rows=63745 loops=1)
                 ->  Finalize GroupAggregate  (cost=70013.61..72417.06 rows=16800 width=155) (actual time=2522.139..2757.755 rows=63745 loops=1)
                       Group Key: i_category, i_brand, s_store_name, s_company_name, d_year, d_moy
                       ->  Remote Subquery Scan on all (dn0)  (cost=70013.61..71927.06 rows=14000 width=155) (actual time=2522.103..2675.352 rows=63745 loops=1)
   CTE v2
     ->  Hash Join  (cost=3618.11..4290.12 rows=1 width=368) (actual time=3009.780..3051.327 rows=52004 loops=1)
           Hash Cond: ((v1_lead.i_category = v1.i_category) AND (v1_lead.i_brand = v1.i_brand) AND ((v1_lead.s_store_name)::text = (v1.s_store_name)::text) AND ((v1_lead.s_company_name)::text = (v1.s_company_name)::text) AND ((v1_lead.rn - 1) = v1.rn))
           ->  CTE Scan on v1 v1_lead  (cost=0.00..336.00 rows=16800 width=684) (actual time=2522.155..2527.217 rows=63745 loops=1)
           ->  Hash  (cost=3618.09..3618.09 rows=1 width=1404) (actual time=487.600..487.600 rows=57128 loops=1)
                 Buckets: 65536 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 18187kB
                 ->  Merge Join  (cost=3030.08..3618.09 rows=1 width=1404) (actual time=415.691..460.047 rows=57128 loops=1)
                       Merge Cond: ((v1.i_category = v1_lag.i_category) AND (v1.i_brand = v1_lag.i_brand) AND ((v1.s_store_name)::text = (v1_lag.s_store_name)::text) AND ((v1.s_company_name)::text = (v1_lag.s_company_name)::text) AND (v1.rn = ((v1_lag.rn + 1))))
                       ->  Sort  (cost=1515.04..1557.04 rows=16800 width=720) (actual time=380.855..383.207 rows=62995 loops=1)
                             Sort Key: v1.i_category, v1.i_brand, v1.s_store_name, v1.s_company_name, v1.rn
                             Sort Method: quicksort  Memory: 18325kB
                             ->  CTE Scan on v1  (cost=0.00..336.00 rows=16800 width=720) (actual time=0.001..353.253 rows=63745 loops=1)
                       ->  Sort  (cost=1515.04..1557.04 rows=16800 width=684) (actual time=34.825..37.503 rows=62953 loops=1)
                             Sort Key: v1_lag.i_category, v1_lag.i_brand, v1_lag.s_store_name, v1_lag.s_company_name, ((v1_lag.rn + 1))
                             Sort Method: quicksort  Memory: 18325kB
                             ->  CTE Scan on v1 v1_lag  (cost=0.00..336.00 rows=16800 width=684) (actual time=0.001..8.302 rows=63745 loops=1)
   ->  Sort  (cost=0.05..0.06 rows=1 width=400) (actual time=3119.072..3119.075 rows=100 loops=1)
         Sort Key: ((v2.sum_sales - v2.avg_monthly_sales)), v2.nsum
         Sort Method: top-N heapsort  Memory: 49kB
         ->  CTE Scan on v2  (cost=0.00..0.04 rows=1 width=400) (actual time=3009.786..3106.956 rows=47161 loops=1)
               Filter: ((avg_monthly_sales > '0'::numeric) AND (d_year = 2000) AND (CASE WHEN (avg_monthly_sales > '0'::numeric) THEN (abs((sum_sales - avg_monthly_sales)) / avg_monthly_sales) ELSE NULL::numeric END > 0.1))
               Rows Removed by Filter: 4843
 Planning time: 0.563 ms
 Execution time: 3132.832 ms
(31 rows)

