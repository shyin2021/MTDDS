                                                                                                      QUERY PLAN                                                                                                       
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=73107.97..73108.22 rows=100 width=210) (actual time=1107.944..1107.953 rows=100 loops=1)
   ->  Sort  (cost=73107.97..73110.47 rows=1001 width=210) (actual time=1107.943..1107.946 rows=100 loops=1)
         Sort Key: ((GROUPING(item.i_category) + GROUPING(item.i_class))) DESC, (CASE WHEN (((GROUPING(item.i_category) + GROUPING(item.i_class))) = 0) THEN item.i_category ELSE NULL::bpchar END), (rank() OVER (?))
         Sort Method: quicksort  Memory: 58kB
         ->  WindowAgg  (cost=73037.18..73069.71 rows=1001 width=210) (actual time=1107.672..1107.758 rows=145 loops=1)
               ->  Sort  (cost=73037.18..73039.68 rows=1001 width=178) (actual time=1107.668..1107.673 rows=145 loops=1)
                     Sort Key: ((GROUPING(item.i_category) + GROUPING(item.i_class))), (CASE WHEN (GROUPING(item.i_class) = 0) THEN item.i_category ELSE NULL::bpchar END), (sum(web_sales.ws_net_paid)) DESC
                     Sort Method: quicksort  Memory: 58kB
                     ->  GroupAggregate  (cost=72824.29..72987.29 rows=1001 width=178) (actual time=319.058..1107.411 rows=145 loops=1)
                           Group Key: item.i_category, item.i_class
                           Group Key: item.i_category
                           Group Key: ()
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=72824.29..72897.03 rows=9699 width=108) (actual time=306.226..942.187 rows=431827 loops=1)
 Planning time: 0.279 ms
 Execution time: 1114.399 ms
(15 rows)

