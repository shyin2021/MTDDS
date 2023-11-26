                                                                                     QUERY PLAN                                                                                     
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=50001647847.13..50001647847.30 rows=1 width=288) (actual time=3317.495..3317.497 rows=1 loops=1)
   ->  Nested Loop  (cost=50001647847.13..50001647847.30 rows=1 width=288) (actual time=3317.494..3317.496 rows=1 loops=1)
         ->  Nested Loop  (cost=40001372574.99..40001372575.13 rows=1 width=240) (actual time=2766.719..2766.721 rows=1 loops=1)
               ->  Nested Loop  (cost=30001096683.33..30001096683.44 rows=1 width=192) (actual time=2154.237..2154.239 rows=1 loops=1)
                     ->  Nested Loop  (cost=20000821399.34..20000821399.42 rows=1 width=144) (actual time=1585.637..1585.638 rows=1 loops=1)
                           ->  Nested Loop  (cost=10000548332.13..10000548332.18 rows=1 width=96) (actual time=1055.172..1055.172 rows=1 loops=1)
                                 ->  Aggregate  (cost=272972.89..272972.90 rows=1 width=48) (actual time=548.513..548.513 rows=1 loops=1)
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=200.00..272357.03 rows=82114 width=6) (actual time=8.485..494.299 rows=82559 loops=1)
                                 ->  Aggregate  (cost=275359.24..275359.25 rows=1 width=48) (actual time=506.654..506.654 rows=1 loops=1)
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=200.00..274592.35 rows=102252 width=6) (actual time=6.620..449.333 rows=109137 loops=1)
                           ->  Aggregate  (cost=273067.21..273067.22 rows=1 width=48) (actual time=530.462..530.462 rows=1 loops=1)
                                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=200.00..272445.39 rows=82910 width=6) (actual time=7.576..471.765 rows=89403 loops=1)
                     ->  Aggregate  (cost=275283.99..275284.00 rows=1 width=48) (actual time=568.597..568.597 rows=1 loops=1)
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=200.00..274521.86 rows=101617 width=6) (actual time=6.427..510.080 rows=109298 loops=1)
               ->  Aggregate  (cost=275891.66..275891.67 rows=1 width=48) (actual time=612.479..612.479 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=200.00..275091.07 rows=106745 width=6) (actual time=6.137..518.865 rows=109799 loops=1)
         ->  Aggregate  (cost=275272.14..275272.15 rows=1 width=48) (actual time=550.771..550.771 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=200.00..274510.76 rows=101517 width=6) (actual time=6.102..478.770 rows=108718 loops=1)
 Planning time: 0.601 ms
 Execution time: 3331.323 ms
(20 rows)

