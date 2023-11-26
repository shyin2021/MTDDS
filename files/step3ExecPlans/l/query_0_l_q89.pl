                                                                                       QUERY PLAN                                                                                       
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=204541.69..204541.94 rows=100 width=266) (actual time=574.921..574.930 rows=100 loops=1)
   ->  Sort  (cost=204541.69..204542.90 rows=483 width=266) (actual time=574.920..574.923 rows=100 loops=1)
         Sort Key: ((tmp1.sum_sales - tmp1.avg_monthly_sales)), tmp1.s_store_name
         Sort Method: top-N heapsort  Memory: 69kB
         ->  Subquery Scan on tmp1  (cost=204453.19..204523.23 rows=483 width=266) (actual time=570.117..573.866 rows=2655 loops=1)
               Filter: (CASE WHEN (tmp1.avg_monthly_sales <> '0'::numeric) THEN (abs((tmp1.sum_sales - tmp1.avg_monthly_sales)) / tmp1.avg_monthly_sales) ELSE NULL::numeric END > 0.1)
               Rows Removed by Filter: 197
               ->  WindowAgg  (cost=204453.19..204489.42 rows=1449 width=234) (actual time=570.113..571.841 rows=2852 loops=1)
                     ->  Sort  (cost=204453.19..204456.82 rows=1449 width=202) (actual time=570.100..570.208 rows=2852 loops=1)
                           Sort Key: i_category, i_brand, s_store_name, s_company_name
                           Sort Method: quicksort  Memory: 854kB
                           ->  Finalize GroupAggregate  (cost=204169.74..204377.12 rows=1449 width=202) (actual time=522.814..569.057 rows=2852 loops=1)
                                 Group Key: i_category, i_class, i_brand, s_store_name, s_company_name, d_moy
                                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=204169.74..204334.84 rows=1208 width=202) (actual time=522.779..562.745 rows=7327 loops=1)
 Planning time: 0.564 ms
 Execution time: 580.364 ms
(16 rows)

