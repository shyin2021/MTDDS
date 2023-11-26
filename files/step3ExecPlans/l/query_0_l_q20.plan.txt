                                                                                                QUERY PLAN                                                                                                 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=140716.86..140717.11 rows=100 width=291) (actual time=213.252..213.261 rows=100 loops=1)
   ->  Sort  (cost=140716.86..140718.13 rows=509 width=291) (actual time=213.252..213.255 rows=100 loops=1)
         Sort Key: item.i_category, item.i_class, item.i_item_id, item.i_item_desc, ((((sum(catalog_sales.cs_ext_sales_price)) * '100'::numeric) / sum((sum(catalog_sales.cs_ext_sales_price))) OVER (?)))
         Sort Method: top-N heapsort  Memory: 102kB
         ->  WindowAgg  (cost=140685.95..140697.40 rows=509 width=291) (actual time=206.183..211.442 rows=4901 loops=1)
               ->  Sort  (cost=140685.95..140687.22 rows=509 width=259) (actual time=206.129..206.406 rows=4901 loops=1)
                     Sort Key: item.i_class
                     Sort Method: quicksort  Memory: 2060kB
                     ->  Finalize GroupAggregate  (cost=140591.86..140663.07 rows=509 width=259) (actual time=181.942..202.467 rows=4901 loops=1)
                           Group Key: item.i_item_id, item.i_item_desc, item.i_category, item.i_class, item.i_current_price
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=140591.86..140649.28 rows=424 width=259) (actual time=181.931..197.843 rows=4901 loops=1)
 Planning time: 0.400 ms
 Execution time: 220.070 ms
(13 rows)

