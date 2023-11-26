                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=146434.88..146434.90 rows=9 width=142) (actual time=287.824..287.827 rows=43 loops=1)
   ->  Sort  (cost=146434.88..146434.90 rows=9 width=142) (actual time=287.823..287.824 rows=43 loops=1)
         Sort Key: (sum(store_sales.ss_ext_sales_price)) DESC, item.i_brand, item.i_brand_id, item.i_manufact_id, item.i_manufact
         Sort Method: quicksort  Memory: 36kB
         ->  Finalize GroupAggregate  (cost=146434.44..146434.74 rows=9 width=142) (actual time=287.642..287.790 rows=43 loops=1)
               Group Key: item.i_brand, item.i_brand_id, item.i_manufact_id, item.i_manufact
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=146434.44..146434.50 rows=8 width=142) (actual time=287.619..287.724 rows=43 loops=1)
 Planning time: 1.017 ms
 Execution time: 291.241 ms
(9 rows)

