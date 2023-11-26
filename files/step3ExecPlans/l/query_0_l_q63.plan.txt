                                                                                      QUERY PLAN                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=204570.08..204570.14 rows=23 width=68) (actual time=356.870..356.878 rows=100 loops=1)
   ->  Sort  (cost=204570.08..204570.14 rows=23 width=68) (actual time=356.869..356.872 rows=100 loops=1)
         Sort Key: tmp1.i_manager_id, tmp1.avg_monthly_sales, tmp1.sum_sales
         Sort Method: top-N heapsort  Memory: 32kB
         ->  Subquery Scan on tmp1  (cost=204557.85..204569.56 rows=23 width=68) (actual time=348.594..356.539 rows=1145 loops=1)
               Filter: (CASE WHEN (tmp1.avg_monthly_sales > '0'::numeric) THEN (abs((tmp1.sum_sales - tmp1.avg_monthly_sales)) / tmp1.avg_monthly_sales) ELSE NULL::numeric END > 0.1)
               Rows Removed by Filter: 27
               ->  WindowAgg  (cost=204557.85..204567.99 rows=70 width=72) (actual time=348.591..355.745 rows=1172 loops=1)
                     ->  Finalize GroupAggregate  (cost=204557.85..204566.94 rows=70 width=40) (actual time=348.505..355.173 rows=1172 loops=1)
                           Group Key: i_manager_id, d_moy
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=204557.85..204565.48 rows=58 width=40) (actual time=348.493..353.182 rows=3097 loops=1)
 Planning time: 0.539 ms
 Execution time: 363.583 ms
(13 rows)

