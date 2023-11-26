                                                                                             QUERY PLAN                                                                                             
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=271751.99..271752.00 rows=3 width=129) (actual time=1796.929..1796.929 rows=3 loops=1)
   ->  Sort  (cost=271751.99..271752.00 rows=3 width=129) (actual time=1796.927..1796.927 rows=3 loops=1)
         Sort Key: ((GROUPING(s_state) + GROUPING(s_county))) DESC, (CASE WHEN (((GROUPING(s_state) + GROUPING(s_county))) = 0) THEN s_state ELSE NULL::bpchar END), (rank() OVER (?))
         Sort Method: quicksort  Memory: 25kB
         ->  WindowAgg  (cost=271751.87..271751.97 rows=3 width=129) (actual time=1796.914..1796.916 rows=3 loops=1)
               ->  Sort  (cost=271751.87..271751.88 rows=3 width=97) (actual time=1796.910..1796.910 rows=3 loops=1)
                     Sort Key: ((GROUPING(s_state) + GROUPING(s_county))), (CASE WHEN (GROUPING(s_county) = 0) THEN s_state ELSE NULL::bpchar END), (sum(ss_net_profit)) DESC
                     Sort Method: quicksort  Memory: 25kB
                     ->  MixedAggregate  (cost=134834.62..271751.85 rows=3 width=97) (actual time=1796.900..1796.902 rows=3 loops=1)
                           Hash Key: s_state, s_county
                           Hash Key: s_state
                           Group Key: ()
                           ->  Hash Join  (cost=134834.62..271380.35 rows=24763 width=27) (actual time=494.103..1315.515 rows=1076041 loops=1)
                                 Hash Cond: (s_state = tmp1.s_state)
                                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=220.07..137217.72 rows=24763 width=27) (actual time=2.322..228.749 rows=1076041 loops=1)
                                 ->  Hash  (cost=134714.54..134714.54 rows=1 width=3) (actual time=491.762..491.762 rows=1 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                       ->  Subquery Scan on tmp1  (cost=134714.51..134714.54 rows=1 width=3) (actual time=491.758..491.759 rows=1 loops=1)
                                             Filter: (tmp1.ranking <= 5)
                                             ->  WindowAgg  (cost=134714.51..134714.53 rows=1 width=43) (actual time=491.756..491.756 rows=1 loops=1)
                                                   ->  Sort  (cost=134714.51..134714.51 rows=1 width=35) (actual time=491.752..491.752 rows=1 loops=1)
                                                         Sort Key: s_state, (sum(ss_net_profit)) DESC
                                                         Sort Method: quicksort  Memory: 25kB
                                                         ->  Finalize GroupAggregate  (cost=134714.45..134714.50 rows=1 width=35) (actual time=491.744..491.744 rows=1 loops=1)
                                                               Group Key: s_state
                                                               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=134714.45..134714.47 rows=2 width=35) (actual time=491.734..491.734 rows=2 loops=1)
 Planning time: 2.236 ms
 Execution time: 1809.835 ms
(28 rows)

