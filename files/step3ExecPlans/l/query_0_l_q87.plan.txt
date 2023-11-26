                                                                                               QUERY PLAN                                                                                               
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=447173.61..447173.62 rows=1 width=8) (actual time=7961.581..7961.581 rows=1 loops=1)
   ->  Subquery Scan on cool_cust  (cost=217026.04..447076.63 rows=38793 width=0) (actual time=7937.592..7955.303 rows=140034 loops=1)
         ->  HashSetOp Except  (cost=217026.04..446688.70 rows=38793 width=216) (actual time=7937.591..7944.366 rows=140034 loops=1)
               ->  Append  (cost=217026.04..446325.01 rows=48492 width=216) (actual time=6572.775..7894.251 rows=175680 loops=1)
                     ->  Result  (cost=217026.04..367093.25 rows=38793 width=216) (actual time=6572.775..6602.634 rows=140256 loops=1)
                           ->  HashSetOp Except  (cost=217026.04..366705.32 rows=38793 width=216) (actual time=6572.774..6590.991 rows=140256 loops=1)
                                 ->  Append  (cost=217026.04..366268.91 rows=58188 width=216) (actual time=1588.653..6483.288 rows=235472 loops=1)
                                       ->  Subquery Scan on "*SELECT* 1"  (cost=217026.04..217995.87 rows=38793 width=60) (actual time=1588.653..4207.452 rows=141181 loops=1)
                                             ->  Unique  (cost=217026.04..217607.94 rows=38793 width=56) (actual time=1588.652..4188.168 rows=141181 loops=1)
                                                   ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=217026.04..217316.99 rows=38793 width=56) (actual time=1588.651..3915.880 rows=1608270 loops=1)
                                       ->  Subquery Scan on "*SELECT* 2"  (cost=147788.17..148273.04 rows=19395 width=60) (actual time=836.353..2256.707 rows=94291 loops=1)
                                             ->  Unique  (cost=147788.17..148079.09 rows=19395 width=56) (actual time=836.352..2244.139 rows=94291 loops=1)
                                                   ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=147788.17..147933.63 rows=19395 width=56) (actual time=836.350..2101.531 rows=855683 loops=1)
                     ->  Subquery Scan on "*SELECT* 3"  (cost=78989.29..79231.76 rows=9699 width=60) (actual time=437.350..1282.461 rows=35424 loops=1)
                           ->  Unique  (cost=78989.29..79134.77 rows=9699 width=56) (actual time=437.346..1275.515 rows=35424 loops=1)
                                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=78989.29..79062.03 rows=9699 width=56) (actual time=437.344..1188.087 rows=429740 loops=1)
 Planning time: 0.636 ms
 Execution time: 7982.908 ms
(18 rows)

