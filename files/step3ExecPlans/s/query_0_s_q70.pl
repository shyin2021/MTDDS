                                                                                          QUERY PLAN                                                                                          
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=139778.05..139778.06 rows=3 width=129) (actual time=1071.575..1071.576 rows=3 loops=1)
   ->  Sort  (cost=139778.05..139778.06 rows=3 width=129) (actual time=1071.574..1071.575 rows=3 loops=1)
         Sort Key: ((GROUPING(s_state) + GROUPING(s_county))) DESC, (CASE WHEN (((GROUPING(s_state) + GROUPING(s_county))) = 0) THEN s_state ELSE NULL::bpchar END), (rank() OVER (?))
         Sort Method: quicksort  Memory: 25kB
         ->  WindowAgg  (cost=139777.93..139778.03 rows=3 width=129) (actual time=1071.567..1071.569 rows=3 loops=1)
               ->  Sort  (cost=139777.93..139777.94 rows=3 width=97) (actual time=1071.563..1071.563 rows=3 loops=1)
                     Sort Key: ((GROUPING(s_state) + GROUPING(s_county))), (CASE WHEN (GROUPING(s_county) = 0) THEN s_state ELSE NULL::bpchar END), (sum(ss_net_profit)) DESC
                     Sort Method: quicksort  Memory: 25kB
                     ->  MixedAggregate  (cost=71083.00..139777.91 rows=3 width=97) (actual time=1071.556..1071.558 rows=3 loops=1)
                           Hash Key: s_state, s_county
                           Hash Key: s_state
                           Group Key: ()
                           ->  Hash Join  (cost=71083.00..139564.90 rows=14197 width=27) (actual time=457.495..898.267 rows=532955 loops=1)
                                 Hash Cond: (s_state = tmp1.s_state)
                                 ->  Remote Subquery Scan on all (dn0)  (cost=1950.38..70691.37 rows=14197 width=27) (actual time=5.841..239.073 rows=532955 loops=1)
                                 ->  Hash  (cost=69232.61..69232.61 rows=1 width=3) (actual time=451.636..451.636 rows=1 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                       ->  Subquery Scan on tmp1  (cost=69232.58..69232.61 rows=1 width=3) (actual time=451.633..451.634 rows=1 loops=1)
                                             Filter: (tmp1.ranking <= 5)
                                             ->  WindowAgg  (cost=69232.58..69232.60 rows=1 width=43) (actual time=451.631..451.632 rows=1 loops=1)
                                                   ->  Sort  (cost=69232.58..69232.58 rows=1 width=35) (actual time=451.628..451.628 rows=1 loops=1)
                                                         Sort Key: s_state, (sum(ss_net_profit)) DESC
                                                         Sort Method: quicksort  Memory: 25kB
                                                         ->  Finalize GroupAggregate  (cost=69232.53..69232.57 rows=1 width=35) (actual time=451.625..451.625 rows=1 loops=1)
                                                               Group Key: s_state
                                                               ->  Remote Subquery Scan on all (dn0)  (cost=69232.53..69232.54 rows=2 width=35) (actual time=451.611..451.612 rows=1 loops=1)
 Planning time: 0.501 ms
 Execution time: 1072.378 ms
(28 rows)

