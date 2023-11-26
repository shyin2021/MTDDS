                                                                                                                     QUERY PLAN                                                                                                                      
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=142009.67..142009.92 rows=100 width=210) (actual time=3321.314..3321.323 rows=100 loops=1)
   ->  Sort  (cost=142009.67..142012.17 rows=1001 width=210) (actual time=3321.314..3321.317 rows=100 loops=1)
         Sort Key: ((GROUPING(item.i_category) + GROUPING(item.i_class))) DESC, (CASE WHEN (((GROUPING(item.i_category) + GROUPING(item.i_class))) = 0) THEN item.i_category ELSE NULL::bpchar END), (rank() OVER (?))
         Sort Method: quicksort  Memory: 57kB
         ->  WindowAgg  (cost=141936.38..141971.41 rows=1001 width=210) (actual time=3321.060..3321.136 rows=135 loops=1)
               ->  Sort  (cost=141936.38..141938.88 rows=1001 width=178) (actual time=3321.054..3321.059 rows=135 loops=1)
                     Sort Key: ((GROUPING(item.i_category) + GROUPING(item.i_class))), (CASE WHEN (GROUPING(item.i_class) = 0) THEN item.i_category ELSE NULL::bpchar END), ((sum(store_sales.ss_net_profit) / sum(store_sales.ss_ext_sales_price)))
                     Sort Method: quicksort  Memory: 57kB
                     ->  GroupAggregate  (cost=141360.23..141886.49 rows=1001 width=178) (actual time=1217.134..3320.806 rows=135 loops=1)
                           Group Key: item.i_category, item.i_class
                           Group Key: item.i_category
                           Group Key: ()
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=141360.23..141576.12 rows=28785 width=114) (actual time=1204.671..2731.559 rows=1072318 loops=1)
 Planning time: 0.426 ms
 Execution time: 3331.979 ms
(15 rows)

