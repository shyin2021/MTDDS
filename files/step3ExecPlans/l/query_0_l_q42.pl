                                                                        QUERY PLAN                                                                        
----------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=203645.04..203645.21 rows=65 width=91) (actual time=296.779..296.780 rows=10 loops=1)
   ->  Sort  (cost=203645.04..203645.21 rows=65 width=91) (actual time=296.778..296.778 rows=10 loops=1)
         Sort Key: (sum(store_sales.ss_ext_sales_price)) DESC, item.i_category_id, item.i_category
         Sort Method: quicksort  Memory: 26kB
         ->  Finalize GroupAggregate  (cost=203634.42..203643.09 rows=65 width=91) (actual time=296.733..296.765 rows=10 loops=1)
               Group Key: dt.d_year, item.i_category_id, item.i_category
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203634.42..203641.60 rows=54 width=91) (actual time=296.718..296.737 rows=30 loops=1)
 Planning time: 0.304 ms
 Execution time: 303.211 ms
(9 rows)

