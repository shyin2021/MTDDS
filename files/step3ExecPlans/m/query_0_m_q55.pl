                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=136024.91..136024.97 rows=21 width=87) (actual time=243.167..243.173 rows=85 loops=1)
   ->  Sort  (cost=136024.91..136024.97 rows=21 width=87) (actual time=243.166..243.168 rows=85 loops=1)
         Sort Key: (sum(store_sales.ss_ext_sales_price)) DESC, item.i_brand_id
         Sort Method: quicksort  Memory: 36kB
         ->  Finalize GroupAggregate  (cost=136021.64..136024.45 rows=21 width=87) (actual time=242.979..243.108 rows=85 loops=1)
               Group Key: item.i_brand, item.i_brand_id
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=136021.64..136024.01 rows=18 width=87) (actual time=242.970..243.047 rows=97 loops=1)
 Planning time: 0.336 ms
 Execution time: 278.697 ms
(9 rows)

