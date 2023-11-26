                                                                                               QUERY PLAN                                                                                               
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=407676.51..407676.52 rows=3 width=129) (actual time=2520.707..2520.708 rows=4 loops=1)
   ->  Sort  (cost=407676.51..407676.52 rows=3 width=129) (actual time=2520.707..2520.707 rows=4 loops=1)
         Sort Key: ((GROUPING(s_state) + GROUPING(s_county))) DESC, (CASE WHEN (((GROUPING(s_state) + GROUPING(s_county))) = 0) THEN s_state ELSE NULL::bpchar END), (rank() OVER (?))
         Sort Method: quicksort  Memory: 25kB
         ->  WindowAgg  (cost=407676.39..407676.49 rows=3 width=129) (actual time=2520.696..2520.701 rows=4 loops=1)
               ->  Sort  (cost=407676.39..407676.40 rows=3 width=97) (actual time=2520.692..2520.692 rows=4 loops=1)
                     Sort Key: ((GROUPING(s_state) + GROUPING(s_county))), (CASE WHEN (GROUPING(s_county) = 0) THEN s_state ELSE NULL::bpchar END), (sum(ss_net_profit)) DESC
                     Sort Method: quicksort  Memory: 25kB
                     ->  MixedAggregate  (cost=202138.33..407676.36 rows=3 width=97) (actual time=2520.681..2520.684 rows=4 loops=1)
                           Hash Key: s_state, s_county
                           Hash Key: s_state
                           Group Key: ()
                           ->  Hash Join  (cost=202138.33..407094.42 rows=38793 width=27) (actual time=505.208..1786.321 rows=1601932 loops=1)
                                 Hash Cond: (s_state = tmp1.s_state)
                                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=221.75..205885.80 rows=38793 width=27) (actual time=0.579..398.218 rows=1601932 loops=1)
                                 ->  Hash  (cost=202016.57..202016.57 rows=1 width=3) (actual time=504.613..504.613 rows=1 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                       ->  Subquery Scan on tmp1  (cost=202016.54..202016.57 rows=1 width=3) (actual time=504.607..504.609 rows=1 loops=1)
                                             Filter: (tmp1.ranking <= 5)
                                             ->  WindowAgg  (cost=202016.54..202016.56 rows=1 width=43) (actual time=504.605..504.607 rows=1 loops=1)
                                                   ->  Sort  (cost=202016.54..202016.54 rows=1 width=35) (actual time=504.600..504.600 rows=1 loops=1)
                                                         Sort Key: s_state, (sum(ss_net_profit)) DESC
                                                         Sort Method: quicksort  Memory: 25kB
                                                         ->  Finalize GroupAggregate  (cost=202016.48..202016.53 rows=1 width=35) (actual time=504.595..504.595 rows=1 loops=1)
                                                               Group Key: s_state
                                                               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=202016.48..202016.50 rows=2 width=35) (actual time=504.577..504.578 rows=3 loops=1)
 Planning time: 0.508 ms
 Execution time: 2527.870 ms
(28 rows)

