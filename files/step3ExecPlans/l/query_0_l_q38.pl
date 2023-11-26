                                                                                                  QUERY PLAN                                                                                                  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=446470.47..446470.48 rows=1 width=8) (actual time=7345.005..7345.005 rows=1 loops=1)
   ->  Aggregate  (cost=446470.47..446470.48 rows=1 width=8) (actual time=7345.004..7345.004 rows=1 loops=1)
         ->  Subquery Scan on hot_cust  (cost=78989.29..446446.23 rows=9699 width=0) (actual time=7343.921..7344.986 rows=282 loops=1)
               ->  HashSetOp Intersect  (cost=78989.29..446349.24 rows=9699 width=216) (actual time=7343.920..7344.954 rows=282 loops=1)
                     ->  Append  (cost=78989.29..446131.03 rows=29094 width=216) (actual time=452.153..7330.500 rows=36645 loops=1)
                           ->  Subquery Scan on "*SELECT* 3"  (cost=78989.29..79231.76 rows=9699 width=60) (actual time=452.153..1094.843 rows=35670 loops=1)
                                 ->  Unique  (cost=78989.29..79134.77 rows=9699 width=56) (actual time=452.152..1090.711 rows=35670 loops=1)
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=78989.29..79062.03 rows=9699 width=56) (actual time=452.150..1022.816 rows=433236 loops=1)
                           ->  Result  (cost=147788.17..366899.27 rows=19395 width=216) (actual time=6230.099..6232.858 rows=975 loops=1)
                                 ->  HashSetOp Intersect  (cost=147788.17..366705.32 rows=19395 width=216) (actual time=6230.098..6232.765 rows=975 loops=1)
                                       ->  Append  (cost=147788.17..366268.91 rows=58188 width=216) (actual time=848.670..6152.633 rows=234518 loops=1)
                                             ->  Subquery Scan on "*SELECT* 2"  (cost=147788.17..148273.04 rows=19395 width=60) (actual time=848.669..2153.013 rows=93930 loops=1)
                                                   ->  Unique  (cost=147788.17..148079.09 rows=19395 width=56) (actual time=848.666..2141.420 rows=93930 loops=1)
                                                         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=147788.17..147933.63 rows=19395 width=56) (actual time=848.664..2007.966 rows=851622 loops=1)
                                             ->  Subquery Scan on "*SELECT* 1"  (cost=217026.04..217995.87 rows=38793 width=60) (actual time=1611.902..3981.016 rows=140588 loops=1)
                                                   ->  Unique  (cost=217026.04..217607.94 rows=38793 width=56) (actual time=1611.899..3963.843 rows=140588 loops=1)
                                                         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=217026.04..217316.99 rows=38793 width=56) (actual time=1611.897..3715.936 rows=1602144 loops=1)
 Planning time: 0.599 ms
 Execution time: 7361.218 ms
(19 rows)

