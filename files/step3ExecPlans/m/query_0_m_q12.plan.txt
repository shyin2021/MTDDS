                                                                                            QUERY PLAN                                                                                             
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=50086.91..50087.16 rows=100 width=291) (actual time=109.320..109.328 rows=100 loops=1)
   ->  Sort  (cost=50086.91..50087.32 rows=164 width=291) (actual time=109.319..109.322 rows=100 loops=1)
         Sort Key: item.i_category, item.i_class, item.i_item_id, item.i_item_desc, ((((sum(web_sales.ws_ext_sales_price)) * '100'::numeric) / sum((sum(web_sales.ws_ext_sales_price))) OVER (?)))
         Sort Method: top-N heapsort  Memory: 78kB
         ->  WindowAgg  (cost=50077.19..50080.88 rows=164 width=291) (actual time=105.643..108.335 rows=2558 loops=1)
               ->  Sort  (cost=50077.19..50077.60 rows=164 width=259) (actual time=105.608..105.742 rows=2558 loops=1)
                     Sort Key: item.i_class
                     Sort Method: quicksort  Memory: 1084kB
                     ->  Finalize GroupAggregate  (cost=50048.31..50071.16 rows=164 width=259) (actual time=92.232..103.368 rows=2558 loops=1)
                           Group Key: item.i_item_id, item.i_item_desc, item.i_category, item.i_class, item.i_current_price
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=50048.31..50066.73 rows=136 width=259) (actual time=92.222..100.145 rows=2558 loops=1)
 Planning time: 0.841 ms
 Execution time: 114.602 ms
(13 rows)

