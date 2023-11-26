                                                                        QUERY PLAN                                                                         
-----------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=203645.04..203645.21 rows=65 width=91) (actual time=276.443..276.477 rows=100 loops=1)
   ->  Sort  (cost=203645.04..203645.21 rows=65 width=91) (actual time=276.441..276.448 rows=100 loops=1)
         Sort Key: (sum(store_sales.ss_ext_sales_price)) DESC, item.i_brand_id
         Sort Method: quicksort  Memory: 51kB
         ->  Finalize GroupAggregate  (cost=203634.42..203643.09 rows=65 width=91) (actual time=275.170..276.089 rows=191 loops=1)
               Group Key: dt.d_year, item.i_brand, item.i_brand_id
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203634.42..203641.60 rows=54 width=91) (actual time=275.149..275.801 rows=262 loops=1)
 Planning time: 0.389 ms
 Execution time: 282.845 ms
(9 rows)

