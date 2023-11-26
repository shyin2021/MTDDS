                                                                                       QUERY PLAN                                                                                       
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=136601.52..136601.77 rows=100 width=266) (actual time=512.704..512.712 rows=100 loops=1)
   ->  Sort  (cost=136601.52..136602.18 rows=265 width=266) (actual time=512.703..512.706 rows=100 loops=1)
         Sort Key: ((tmp1.sum_sales - tmp1.avg_monthly_sales)), tmp1.s_store_name
         Sort Method: top-N heapsort  Memory: 70kB
         ->  Subquery Scan on tmp1  (cost=136553.02..136591.39 rows=265 width=266) (actual time=506.455..511.443 rows=3499 loops=1)
               Filter: (CASE WHEN (tmp1.avg_monthly_sales <> '0'::numeric) THEN (abs((tmp1.sum_sales - tmp1.avg_monthly_sales)) / tmp1.avg_monthly_sales) ELSE NULL::numeric END > 0.1)
               Rows Removed by Filter: 305
               ->  WindowAgg  (cost=136553.02..136572.87 rows=794 width=234) (actual time=506.452..508.799 rows=3804 loops=1)
                     ->  Sort  (cost=136553.02..136555.00 rows=794 width=202) (actual time=506.439..506.564 rows=3804 loops=1)
                           Sort Key: i_category, i_brand, s_store_name, s_company_name
                           Sort Method: quicksort  Memory: 1107kB
                           ->  Finalize GroupAggregate  (cost=136401.13..136514.77 rows=794 width=202) (actual time=468.426..504.679 rows=3804 loops=1)
                                 Group Key: i_category, i_class, i_brand, s_store_name, s_company_name, d_moy
                                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=136401.13..136491.61 rows=662 width=202) (actual time=468.379..497.272 rows=6365 loops=1)
 Planning time: 0.544 ms
 Execution time: 515.816 ms
(16 rows)

