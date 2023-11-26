                                                                                         QUERY PLAN                                                                                          
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=204568.18..204568.24 rows=22 width=68) (actual time=347.772..347.780 rows=100 loops=1)
   ->  Sort  (cost=204568.18..204568.24 rows=22 width=68) (actual time=347.771..347.774 rows=100 loops=1)
         Sort Key: tmp1.avg_quarterly_sales, tmp1.sum_sales, tmp1.i_manufact_id
         Sort Method: top-N heapsort  Memory: 38kB
         ->  Subquery Scan on tmp1  (cost=204556.41..204567.69 rows=22 width=68) (actual time=340.771..347.246 rows=1797 loops=1)
               Filter: (CASE WHEN (tmp1.avg_quarterly_sales > '0'::numeric) THEN (abs((tmp1.sum_sales - tmp1.avg_quarterly_sales)) / tmp1.avg_quarterly_sales) ELSE NULL::numeric END > 0.1)
               Rows Removed by Filter: 263
               ->  WindowAgg  (cost=204556.41..204566.18 rows=67 width=72) (actual time=340.768..346.097 rows=2060 loops=1)
                     ->  Finalize GroupAggregate  (cost=204556.41..204565.18 rows=67 width=40) (actual time=340.754..344.665 rows=2060 loops=1)
                           Group Key: i_manufact_id, d_qoy
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=204556.41..204563.78 rows=56 width=40) (actual time=340.745..342.702 rows=2890 loops=1)
 Planning time: 0.491 ms
 Execution time: 354.247 ms
(13 rows)

