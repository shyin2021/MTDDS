                                                                                                QUERY PLAN                                                                                                 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=94902.51..94902.76 rows=100 width=291) (actual time=179.835..179.843 rows=100 loops=1)
   ->  Sort  (cost=94902.51..94903.36 rows=340 width=291) (actual time=179.834..179.837 rows=100 loops=1)
         Sort Key: item.i_category, item.i_class, item.i_item_id, item.i_item_desc, ((((sum(catalog_sales.cs_ext_sales_price)) * '100'::numeric) / sum((sum(catalog_sales.cs_ext_sales_price))) OVER (?)))
         Sort Method: top-N heapsort  Memory: 75kB
         ->  WindowAgg  (cost=94881.87..94889.52 rows=340 width=291) (actual time=175.117..178.680 rows=3390 loops=1)
               ->  Sort  (cost=94881.87..94882.72 rows=340 width=259) (actual time=175.074..175.230 rows=3390 loops=1)
                     Sort Key: item.i_class
                     Sort Method: quicksort  Memory: 1380kB
                     ->  Finalize GroupAggregate  (cost=94819.89..94867.57 rows=340 width=259) (actual time=163.055..173.036 rows=3390 loops=1)
                           Group Key: item.i_item_id, item.i_item_desc, item.i_category, item.i_class, item.i_current_price
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=94819.89..94858.35 rows=284 width=259) (actual time=163.030..170.178 rows=3390 loops=1)
 Planning time: 0.397 ms
 Execution time: 182.817 ms
(13 rows)

