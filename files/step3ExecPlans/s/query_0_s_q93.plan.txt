                                                                                                                                              QUERY PLAN                                                                                                                                              
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=82197.83..82197.84 rows=1 width=36) (actual time=0.221..0.221 rows=0 loops=1)
   ->  Sort  (cost=82197.83..82197.84 rows=1 width=36) (actual time=0.221..0.221 rows=0 loops=1)
         Sort Key: (sum(CASE WHEN (store_returns.sr_return_quantity IS NOT NULL) THEN (((store_sales.ss_quantity - store_returns.sr_return_quantity))::numeric * store_sales.ss_sales_price) ELSE ((store_sales.ss_quantity)::numeric * store_sales.ss_sales_price) END)), store_sales.ss_customer_sk
         Sort Method: quicksort  Memory: 25kB
         ->  GroupAggregate  (cost=82197.78..82197.82 rows=1 width=36) (actual time=0.217..0.217 rows=0 loops=1)
               Group Key: store_sales.ss_customer_sk
               ->  Remote Subquery Scan on all (dn0)  (cost=82197.78..82197.79 rows=1 width=18) (actual time=0.216..0.216 rows=0 loops=1)
 Planning time: 1.297 ms
 Execution time: 0.817 ms
(9 rows)

SET
