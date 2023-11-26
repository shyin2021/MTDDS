                                                                        QUERY PLAN                                                                        
----------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=203628.73..203628.76 rows=11 width=87) (actual time=266.946..266.950 rows=51 loops=1)
   ->  Sort  (cost=203628.73..203628.76 rows=11 width=87) (actual time=266.945..266.946 rows=51 loops=1)
         Sort Key: (sum(store_sales.ss_ext_sales_price)) DESC, item.i_brand_id
         Sort Method: quicksort  Memory: 32kB
         ->  Finalize GroupAggregate  (cost=203626.99..203628.54 rows=11 width=87) (actual time=266.822..266.908 rows=51 loops=1)
               Group Key: item.i_brand, item.i_brand_id
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203626.99..203628.31 rows=10 width=87) (actual time=266.807..266.863 rows=57 loops=1)
 Planning time: 0.332 ms
 Execution time: 272.141 ms
(9 rows)

