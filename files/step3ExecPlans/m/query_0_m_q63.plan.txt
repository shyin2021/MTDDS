                                                                                      QUERY PLAN                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=136701.97..136702.01 rows=15 width=68) (actual time=304.037..304.045 rows=100 loops=1)
   ->  Sort  (cost=136701.97..136702.01 rows=15 width=68) (actual time=304.037..304.039 rows=100 loops=1)
         Sort Key: tmp1.i_manager_id, tmp1.avg_monthly_sales, tmp1.sum_sales
         Sort Method: quicksort  Memory: 39kB
         ->  Subquery Scan on tmp1  (cost=136694.04..136701.68 rows=15 width=68) (actual time=302.905..303.817 rows=182 loops=1)
               Filter: (CASE WHEN (tmp1.avg_monthly_sales > '0'::numeric) THEN (abs((tmp1.sum_sales - tmp1.avg_monthly_sales)) / tmp1.avg_monthly_sales) ELSE NULL::numeric END > 0.1)
               Rows Removed by Filter: 80
               ->  WindowAgg  (cost=136694.04..136700.66 rows=45 width=72) (actual time=302.879..303.679 rows=262 loops=1)
                     ->  Finalize GroupAggregate  (cost=136694.04..136699.99 rows=45 width=40) (actual time=302.784..303.381 rows=262 loops=1)
                           Group Key: i_manager_id, d_moy
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=136694.04..136699.05 rows=38 width=40) (actual time=302.773..303.043 rows=394 loops=1)
 Planning time: 0.561 ms
 Execution time: 306.949 ms
(13 rows)

