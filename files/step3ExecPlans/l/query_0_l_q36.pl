                                                                                                                     QUERY PLAN                                                                                                                      
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=212630.02..212630.27 rows=100 width=210) (actual time=5154.761..5154.770 rows=100 loops=1)
   ->  Sort  (cost=212630.02..212632.52 rows=1001 width=210) (actual time=5154.761..5154.764 rows=100 loops=1)
         Sort Key: ((GROUPING(item.i_category) + GROUPING(item.i_class))) DESC, (CASE WHEN (((GROUPING(item.i_category) + GROUPING(item.i_class))) = 0) THEN item.i_category ELSE NULL::bpchar END), (rank() OVER (?))
         Sort Method: quicksort  Memory: 57kB
         ->  WindowAgg  (cost=212556.72..212591.76 rows=1001 width=210) (actual time=5154.483..5154.580 rows=138 loops=1)
               ->  Sort  (cost=212556.72..212559.23 rows=1001 width=178) (actual time=5154.478..5154.483 rows=138 loops=1)
                     Sort Key: ((GROUPING(item.i_category) + GROUPING(item.i_class))), (CASE WHEN (GROUPING(item.i_class) = 0) THEN item.i_category ELSE NULL::bpchar END), ((sum(store_sales.ss_net_profit) / sum(store_sales.ss_ext_sales_price)))
                     Sort Method: quicksort  Memory: 57kB
                     ->  GroupAggregate  (cost=211728.86..212506.84 rows=1001 width=178) (actual time=1359.252..5154.188 rows=138 loops=1)
                           Group Key: item.i_category, item.i_class
                           Group Key: item.i_category
                           Group Key: ()
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=211728.86..212052.63 rows=43169 width=114) (actual time=1327.999..4193.448 rows=1611214 loops=1)
 Planning time: 0.440 ms
 Execution time: 5170.976 ms
(15 rows)

