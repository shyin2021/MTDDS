                                                                                QUERY PLAN                                                                                
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=50000557207.91..50000557208.08 rows=1 width=288) (actual time=2402.904..2402.907 rows=1 loops=1)
   ->  Nested Loop  (cost=50000557207.91..50000557208.08 rows=1 width=288) (actual time=2402.903..2402.905 rows=1 loops=1)
         ->  Nested Loop  (cost=40000464351.16..40000464351.30 rows=1 width=240) (actual time=1998.789..1998.790 rows=1 loops=1)
               ->  Nested Loop  (cost=30000371688.87..30000371688.98 rows=1 width=192) (actual time=1595.880..1595.882 rows=1 loops=1)
                     ->  Nested Loop  (cost=20000278788.16..20000278788.24 rows=1 width=144) (actual time=1197.474..1197.475 rows=1 loops=1)
                           ->  Nested Loop  (cost=10000186143.06..10000186143.11 rows=1 width=96) (actual time=799.394..799.394 rows=1 loops=1)
                                 ->  Aggregate  (cost=93064.12..93064.13 rows=1 width=48) (actual time=393.652..393.652 rows=1 loops=1)
                                       ->  Remote Subquery Scan on all (dn0)  (cost=1100.00..92794.69 rows=35924 width=6) (actual time=6.380..379.172 rows=30760 loops=1)
                                 ->  Aggregate  (cost=93078.93..93078.94 rows=1 width=48) (actual time=405.738..405.738 rows=1 loops=1)
                                       ->  Remote Subquery Scan on all (dn0)  (cost=1100.00..92808.56 rows=36049 width=6) (actual time=5.251..388.286 rows=37062 loops=1)
                           ->  Aggregate  (cost=92645.11..92645.12 rows=1 width=48) (actual time=398.077..398.077 rows=1 loops=1)
                                 ->  Remote Subquery Scan on all (dn0)  (cost=1100.00..92402.19 rows=32388 width=6) (actual time=6.751..382.439 rows=32718 loops=1)
                     ->  Aggregate  (cost=92900.71..92900.72 rows=1 width=48) (actual time=398.403..398.403 rows=1 loops=1)
                           ->  Remote Subquery Scan on all (dn0)  (cost=1100.00..92641.62 rows=34545 width=6) (actual time=5.949..382.402 rows=33270 loops=1)
               ->  Aggregate  (cost=92662.29..92662.30 rows=1 width=48) (actual time=402.906..402.906 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn0)  (cost=1100.00..92418.29 rows=32533 width=6) (actual time=6.479..388.431 rows=30945 loops=1)
         ->  Aggregate  (cost=92856.75..92856.76 rows=1 width=48) (actual time=404.111..404.112 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn0)  (cost=1100.00..92600.44 rows=34174 width=6) (actual time=5.671..386.734 rows=36525 loops=1)
 Planning time: 0.672 ms
 Execution time: 2404.260 ms
(20 rows)

