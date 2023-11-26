                                                                                       QUERY PLAN                                                                                       
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=68521.89..68522.14 rows=100 width=266) (actual time=471.384..471.393 rows=100 loops=1)
   ->  Sort  (cost=68521.89..68522.21 rows=131 width=266) (actual time=471.383..471.386 rows=100 loops=1)
         Sort Key: ((tmp1.sum_sales - tmp1.avg_monthly_sales)), tmp1.s_store_name
         Sort Method: top-N heapsort  Memory: 69kB
         ->  Subquery Scan on tmp1  (cost=68498.24..68517.28 rows=131 width=266) (actual time=468.104..470.648 rows=1863 loops=1)
               Filter: (CASE WHEN (tmp1.avg_monthly_sales <> '0'::numeric) THEN (abs((tmp1.sum_sales - tmp1.avg_monthly_sales)) / tmp1.avg_monthly_sales) ELSE NULL::numeric END > 0.1)
               Rows Removed by Filter: 155
               ->  WindowAgg  (cost=68498.24..68508.09 rows=394 width=234) (actual time=468.101..469.290 rows=2018 loops=1)
                     ->  Sort  (cost=68498.24..68499.22 rows=394 width=202) (actual time=468.088..468.156 rows=2018 loops=1)
                           Sort Key: i_category, i_brand, s_store_name, s_company_name
                           Sort Method: quicksort  Memory: 585kB
                           ->  Finalize GroupAggregate  (cost=68424.94..68481.25 rows=394 width=202) (actual time=445.518..467.442 rows=2018 loops=1)
                                 Group Key: i_category, i_class, i_brand, s_store_name, s_company_name, d_moy
                                 ->  Remote Subquery Scan on all (dn0)  (cost=68424.94..68469.77 rows=328 width=202) (actual time=445.500..464.602 rows=2018 loops=1)
 Planning time: 0.972 ms
 Execution time: 472.274 ms
(16 rows)

