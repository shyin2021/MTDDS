                                                                                                      QUERY PLAN                                                                                                       
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=49235.62..49235.87 rows=100 width=210) (actual time=754.537..754.545 rows=100 loops=1)
   ->  Sort  (cost=49235.62..49238.12 rows=1001 width=210) (actual time=754.536..754.539 rows=100 loops=1)
         Sort Key: ((GROUPING(item.i_category) + GROUPING(item.i_class))) DESC, (CASE WHEN (((GROUPING(item.i_category) + GROUPING(item.i_class))) = 0) THEN item.i_category ELSE NULL::bpchar END), (rank() OVER (?))
         Sort Method: quicksort  Memory: 58kB
         ->  WindowAgg  (cost=49164.83..49197.36 rows=1001 width=210) (actual time=754.267..754.351 rows=145 loops=1)
               ->  Sort  (cost=49164.83..49167.33 rows=1001 width=178) (actual time=754.262..754.267 rows=145 loops=1)
                     Sort Key: ((GROUPING(item.i_category) + GROUPING(item.i_class))), (CASE WHEN (GROUPING(item.i_class) = 0) THEN item.i_category ELSE NULL::bpchar END), (sum(web_sales.ws_net_paid)) DESC
                     Sort Method: quicksort  Memory: 58kB
                     ->  GroupAggregate  (cost=48981.28..49114.94 rows=1001 width=178) (actual time=326.374..754.002 rows=145 loops=1)
                           Group Key: item.i_category, item.i_class
                           Group Key: item.i_category
                           Group Key: ()
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=48981.28..49039.35 rows=7743 width=108) (actual time=323.223..651.472 rows=288747 loops=1)
 Planning time: 0.430 ms
 Execution time: 757.184 ms
(15 rows)

