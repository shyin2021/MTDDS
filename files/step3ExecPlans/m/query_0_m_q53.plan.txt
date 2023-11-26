                                                                                         QUERY PLAN                                                                                          
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=136701.97..136702.01 rows=15 width=68) (actual time=343.741..343.749 rows=100 loops=1)
   ->  Sort  (cost=136701.97..136702.01 rows=15 width=68) (actual time=343.740..343.743 rows=100 loops=1)
         Sort Key: tmp1.avg_quarterly_sales, tmp1.sum_sales, tmp1.i_manufact_id
         Sort Method: top-N heapsort  Memory: 37kB
         ->  Subquery Scan on tmp1  (cost=136694.04..136701.68 rows=15 width=68) (actual time=334.347..343.192 rows=1893 loops=1)
               Filter: (CASE WHEN (tmp1.avg_quarterly_sales > '0'::numeric) THEN (abs((tmp1.sum_sales - tmp1.avg_quarterly_sales)) / tmp1.avg_quarterly_sales) ELSE NULL::numeric END > 0.1)
               Rows Removed by Filter: 247
               ->  WindowAgg  (cost=136694.04..136700.66 rows=45 width=72) (actual time=334.343..341.832 rows=2140 loops=1)
                     ->  Finalize GroupAggregate  (cost=136694.04..136699.99 rows=45 width=40) (actual time=334.330..340.517 rows=2140 loops=1)
                           Group Key: i_manufact_id, d_qoy
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=136694.04..136699.05 rows=38 width=40) (actual time=334.320..338.654 rows=2732 loops=1)
 Planning time: 0.656 ms
 Execution time: 346.872 ms
(13 rows)

