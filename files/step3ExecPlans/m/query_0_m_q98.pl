                                                                                           QUERY PLAN                                                                                            
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=138810.92..138812.56 rows=659 width=291) (actual time=312.218..312.367 rows=3850 loops=1)
   Sort Key: item.i_category, item.i_class, item.i_item_id, item.i_item_desc, ((((sum(store_sales.ss_ext_sales_price)) * '100'::numeric) / sum((sum(store_sales.ss_ext_sales_price))) OVER (?)))
   Sort Method: quicksort  Memory: 1639kB
   ->  WindowAgg  (cost=138765.23..138780.06 rows=659 width=291) (actual time=298.372..302.486 rows=3850 loops=1)
         ->  Sort  (cost=138765.23..138766.88 rows=659 width=259) (actual time=298.332..298.512 rows=3850 loops=1)
               Sort Key: item.i_class
               Sort Method: quicksort  Memory: 1575kB
               ->  Finalize GroupAggregate  (cost=138642.03..138734.38 rows=659 width=259) (actual time=280.716..295.659 rows=3850 loops=1)
                     Group Key: item.i_item_id, item.i_item_desc, item.i_category, item.i_class, item.i_current_price
                     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=138642.03..138716.52 rows=550 width=259) (actual time=280.670..291.073 rows=3850 loops=1)
 Planning time: 0.312 ms
 Execution time: 315.636 ms
(12 rows)

