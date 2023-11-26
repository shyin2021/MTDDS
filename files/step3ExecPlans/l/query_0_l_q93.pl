                                                                                                                                              QUERY PLAN                                                                                                                                              
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=246095.98..246096.02 rows=15 width=36) (actual time=972.706..972.715 rows=100 loops=1)
   ->  Sort  (cost=246095.98..246096.02 rows=15 width=36) (actual time=972.705..972.708 rows=100 loops=1)
         Sort Key: (sum(CASE WHEN (store_returns.sr_return_quantity IS NOT NULL) THEN (((store_sales.ss_quantity - store_returns.sr_return_quantity))::numeric * store_sales.ss_sales_price) ELSE ((store_sales.ss_quantity)::numeric * store_sales.ss_sales_price) END)), store_sales.ss_customer_sk
         Sort Method: top-N heapsort  Memory: 33kB
         ->  Finalize GroupAggregate  (cost=246093.77..246095.69 rows=15 width=36) (actual time=916.907..967.778 rows=20072 loops=1)
               Group Key: store_sales.ss_customer_sk
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=246093.77..246095.41 rows=12 width=36) (actual time=916.872..949.185 rows=21015 loops=1)
 Planning time: 0.679 ms
 Execution time: 977.437 ms
(9 rows)

SET
