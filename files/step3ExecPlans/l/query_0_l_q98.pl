                                                                                           QUERY PLAN                                                                                            
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=206578.93..206581.52 rows=1033 width=291) (actual time=373.969..374.213 rows=5420 loops=1)
   Sort Key: item.i_category, item.i_class, item.i_item_id, item.i_item_desc, ((((sum(store_sales.ss_ext_sales_price)) * '100'::numeric) / sum((sum(store_sales.ss_ext_sales_price))) OVER (?)))
   Sort Method: quicksort  Memory: 2360kB
   ->  WindowAgg  (cost=206503.98..206527.22 rows=1033 width=291) (actual time=352.674..358.277 rows=5420 loops=1)
         ->  Sort  (cost=206503.98..206506.56 rows=1033 width=259) (actual time=352.479..352.761 rows=5420 loops=1)
               Sort Key: item.i_class
               Sort Method: quicksort  Memory: 2264kB
               ->  Finalize GroupAggregate  (cost=206307.83..206452.26 rows=1033 width=259) (actual time=314.375..348.769 rows=5420 loops=1)
                     Group Key: item.i_item_id, item.i_item_desc, item.i_category, item.i_class, item.i_current_price
                     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=206307.83..206424.30 rows=860 width=259) (actual time=314.341..339.386 rows=5420 loops=1)
 Planning time: 0.327 ms
 Execution time: 380.708 ms
(12 rows)

