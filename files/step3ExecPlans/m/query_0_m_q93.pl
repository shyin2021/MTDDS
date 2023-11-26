                                                                                                                                              QUERY PLAN                                                                                                                                              
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=164172.44..164172.49 rows=21 width=36) (actual time=819.409..819.417 rows=100 loops=1)
   ->  Sort  (cost=164172.44..164172.49 rows=21 width=36) (actual time=819.408..819.411 rows=100 loops=1)
         Sort Key: (sum(CASE WHEN (store_returns.sr_return_quantity IS NOT NULL) THEN (((store_sales.ss_quantity - store_returns.sr_return_quantity))::numeric * store_sales.ss_sales_price) ELSE ((store_sales.ss_quantity)::numeric * store_sales.ss_sales_price) END)), store_sales.ss_customer_sk
         Sort Method: top-N heapsort  Memory: 32kB
         ->  Finalize GroupAggregate  (cost=164169.12..164171.97 rows=21 width=36) (actual time=791.474..817.073 rows=13705 loops=1)
               Group Key: store_sales.ss_customer_sk
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=164169.12..164171.58 rows=18 width=36) (actual time=791.446..807.611 rows=14188 loops=1)
 Planning time: 0.736 ms
 Execution time: 821.730 ms
(9 rows)

SET
