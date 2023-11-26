                                                                                         QUERY PLAN                                                                                          
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=69690.28..69690.30 rows=8 width=68) (actual time=328.576..328.584 rows=100 loops=1)
   ->  Sort  (cost=69690.28..69690.30 rows=8 width=68) (actual time=328.576..328.578 rows=100 loops=1)
         Sort Key: tmp1.avg_quarterly_sales, tmp1.sum_sales, tmp1.i_manufact_id
         Sort Method: top-N heapsort  Memory: 38kB
         ->  Subquery Scan on tmp1  (cost=69686.07..69690.16 rows=8 width=68) (actual time=319.299..328.144 rows=1491 loops=1)
               Filter: (CASE WHEN (tmp1.avg_quarterly_sales > '0'::numeric) THEN (abs((tmp1.sum_sales - tmp1.avg_quarterly_sales)) / tmp1.avg_quarterly_sales) ELSE NULL::numeric END > 0.1)
               Rows Removed by Filter: 197
               ->  WindowAgg  (cost=69686.07..69689.59 rows=25 width=72) (actual time=319.297..327.316 rows=1688 loops=1)
                     ->  Finalize GroupAggregate  (cost=69686.07..69689.22 rows=25 width=40) (actual time=319.285..326.441 rows=1688 loops=1)
                           Group Key: i_manufact_id, d_qoy
                           ->  Remote Subquery Scan on all (dn0)  (cost=69686.07..69688.71 rows=20 width=40) (actual time=319.271..325.049 rows=1688 loops=1)
 Planning time: 0.534 ms
 Execution time: 329.007 ms
(13 rows)

