                                                                                            QUERY PLAN                                                                                             
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=73573.45..73573.70 rows=100 width=291) (actual time=143.045..143.054 rows=100 loops=1)
   ->  Sort  (cost=73573.45..73574.13 rows=273 width=291) (actual time=143.044..143.047 rows=100 loops=1)
         Sort Key: item.i_category, item.i_class, item.i_item_id, item.i_item_desc, ((((sum(web_sales.ws_ext_sales_price)) * '100'::numeric) / sum((sum(web_sales.ws_ext_sales_price))) OVER (?)))
         Sort Method: top-N heapsort  Memory: 73kB
         ->  WindowAgg  (cost=73556.87..73563.01 rows=273 width=291) (actual time=137.255..141.342 rows=3819 loops=1)
               ->  Sort  (cost=73556.87..73557.55 rows=273 width=259) (actual time=137.213..137.412 rows=3819 loops=1)
                     Sort Key: item.i_class
                     Sort Method: quicksort  Memory: 1560kB
                     ->  Finalize GroupAggregate  (cost=73507.55..73545.83 rows=273 width=259) (actual time=117.672..133.491 rows=3819 loops=1)
                           Group Key: item.i_item_id, item.i_item_desc, item.i_category, item.i_class, item.i_current_price
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=73507.55..73538.42 rows=228 width=259) (actual time=117.660..129.616 rows=3819 loops=1)
 Planning time: 0.347 ms
 Execution time: 150.432 ms
(13 rows)

