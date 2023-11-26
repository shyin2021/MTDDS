                                                                                      QUERY PLAN                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=69690.05..69690.07 rows=8 width=68) (actual time=310.559..310.566 rows=100 loops=1)
   ->  Sort  (cost=69690.05..69690.07 rows=8 width=68) (actual time=310.557..310.560 rows=100 loops=1)
         Sort Key: tmp1.i_manager_id, tmp1.avg_monthly_sales, tmp1.sum_sales
         Sort Method: top-N heapsort  Memory: 32kB
         ->  Subquery Scan on tmp1  (cost=69685.95..69689.93 rows=8 width=68) (actual time=307.082..310.429 rows=758 loops=1)
               Filter: (CASE WHEN (tmp1.avg_monthly_sales > '0'::numeric) THEN (abs((tmp1.sum_sales - tmp1.avg_monthly_sales)) / tmp1.avg_monthly_sales) ELSE NULL::numeric END > 0.1)
               Rows Removed by Filter: 93
               ->  WindowAgg  (cost=69685.95..69689.41 rows=23 width=72) (actual time=307.066..309.972 rows=851 loops=1)
                     ->  Finalize GroupAggregate  (cost=69685.95..69689.07 rows=23 width=40) (actual time=307.048..309.629 rows=851 loops=1)
                           Group Key: i_manager_id, d_moy
                           ->  Remote Subquery Scan on all (dn0)  (cost=69685.95..69688.58 rows=20 width=40) (actual time=307.032..308.945 rows=851 loops=1)
 Planning time: 0.463 ms
 Execution time: 310.995 ms
(13 rows)

