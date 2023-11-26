                                                                                                                              QUERY PLAN                                                                                                                               
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=153380.74..153380.75 rows=1 width=404) (actual time=3998.860..3998.869 rows=100 loops=1)
   CTE v1
     ->  WindowAgg  (cost=137858.37..144443.79 rows=33674 width=195) (actual time=2788.658..3562.188 rows=99669 loops=1)
           ->  WindowAgg  (cost=137858.37..143517.75 rows=33674 width=187) (actual time=2788.655..3487.954 rows=99669 loops=1)
                 ->  Finalize GroupAggregate  (cost=137858.37..142675.90 rows=33674 width=155) (actual time=2788.645..3395.122 rows=99669 loops=1)
                       Group Key: i_category, i_brand, s_store_name, s_company_name, d_year, d_moy
                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137858.37..141693.74 rows=28062 width=155) (actual time=2788.634..3276.301 rows=168861 loops=1)
   CTE v2
     ->  Hash Join  (cost=7589.93..8936.90 rows=1 width=372) (actual time=3826.777..3893.590 rows=81531 loops=1)
           Hash Cond: ((v1_lead.i_category = v1.i_category) AND (v1_lead.i_brand = v1.i_brand) AND ((v1_lead.s_store_name)::text = (v1.s_store_name)::text) AND ((v1_lead.s_company_name)::text = (v1.s_company_name)::text) AND ((v1_lead.rn - 1) = v1.rn))
           ->  CTE Scan on v1 v1_lead  (cost=0.00..673.48 rows=33674 width=684) (actual time=2788.659..2796.594 rows=99669 loops=1)
           ->  Hash  (cost=7589.91..7589.91 rows=1 width=1408) (actual time=1038.055..1038.055 rows=89345 loops=1)
                 Buckets: 131072 (originally 1024)  Batches: 1 (originally 1)  Memory Usage: 29126kB
                 ->  Merge Join  (cost=6411.31..7589.91 rows=1 width=1408) (actual time=922.945..993.441 rows=89345 loops=1)
                       Merge Cond: ((v1.i_category = v1_lag.i_category) AND (v1.i_brand = v1_lag.i_brand) AND ((v1.s_store_name)::text = (v1_lag.s_store_name)::text) AND ((v1.s_company_name)::text = (v1_lag.s_company_name)::text) AND (v1.rn = ((v1_lag.rn + 1))))
                       ->  Sort  (cost=3205.65..3289.84 rows=33674 width=724) (actual time=867.078..870.781 rows=98349 loops=1)
                             Sort Key: v1.i_category, v1.i_brand, v1.s_store_name, v1.s_company_name, v1.rn
                             Sort Method: quicksort  Memory: 29291kB
                             ->  CTE Scan on v1  (cost=0.00..673.48 rows=33674 width=724) (actual time=0.001..816.246 rows=99669 loops=1)
                       ->  Sort  (cost=3205.65..3289.84 rows=33674 width=684) (actual time=55.854..60.128 rows=98285 loops=1)
                             Sort Key: v1_lag.i_category, v1_lag.i_brand, v1_lag.s_store_name, v1_lag.s_company_name, ((v1_lag.rn + 1))
                             Sort Method: quicksort  Memory: 29283kB
                             ->  CTE Scan on v1 v1_lag  (cost=0.00..673.48 rows=33674 width=684) (actual time=0.001..13.088 rows=99669 loops=1)
   ->  Sort  (cost=0.05..0.06 rows=1 width=404) (actual time=3998.859..3998.862 rows=100 loops=1)
         Sort Key: ((v2.sum_sales - v2.avg_monthly_sales)), v2.avg_monthly_sales
         Sort Method: top-N heapsort  Memory: 49kB
         ->  CTE Scan on v2  (cost=0.00..0.04 rows=1 width=404) (actual time=3826.783..3980.153 rows=74003 loops=1)
               Filter: ((avg_monthly_sales > '0'::numeric) AND (d_year = 2000) AND (CASE WHEN (avg_monthly_sales > '0'::numeric) THEN (abs((sum_sales - avg_monthly_sales)) / avg_monthly_sales) ELSE NULL::numeric END > 0.1))
               Rows Removed by Filter: 7528
 Planning time: 0.732 ms
 Execution time: 4016.655 ms
(31 rows)

