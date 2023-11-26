                                                                                            QUERY PLAN                                                                                             
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=149944.63..149944.64 rows=1 width=8) (actual time=2988.141..2988.142 rows=1 loops=1)
   ->  Aggregate  (cost=149944.63..149944.64 rows=1 width=8) (actual time=2988.140..2988.140 rows=1 loops=1)
         ->  Subquery Scan on hot_cust  (cost=26680.99..149936.44 rows=3279 width=0) (actual time=2987.829..2988.131 rows=108 loops=1)
               ->  HashSetOp Intersect  (cost=26680.99..149903.65 rows=3279 width=216) (actual time=2987.828..2988.122 rows=108 loops=1)
                     ->  Append  (cost=26680.99..149829.76 rows=9851 width=216) (actual time=317.789..2983.914 rows=12153 loops=1)
                           ->  Subquery Scan on "*SELECT* 3"  (cost=26680.99..26762.96 rows=3279 width=60) (actual time=317.789..444.462 rows=11839 loops=1)
                                 ->  Unique  (cost=26680.99..26730.17 rows=3279 width=56) (actual time=317.788..443.232 rows=11839 loops=1)
                                       ->  Remote Subquery Scan on all (dn0)  (cost=26680.99..26705.58 rows=3279 width=56) (actual time=317.775..361.865 rows=142657 loops=1)
                           ->  Result  (cost=49676.82..123066.80 rows=6572 width=216) (actual time=2537.915..2538.888 rows=314 loops=1)
                                 ->  HashSetOp Intersect  (cost=49676.82..123001.08 rows=6572 width=216) (actual time=2537.914..2538.861 rows=314 loops=1)
                                       ->  Append  (cost=49676.82..122853.30 rows=19705 width=216) (actual time=677.540..2516.033 rows=78390 loops=1)
                                             ->  Subquery Scan on "*SELECT* 2"  (cost=49676.82..49841.12 rows=6572 width=60) (actual time=677.539..907.693 rows=31578 loops=1)
                                                   ->  Unique  (cost=49676.82..49775.40 rows=6572 width=56) (actual time=677.538..904.392 rows=31578 loops=1)
                                                         ->  Remote Subquery Scan on all (dn0)  (cost=49676.82..49726.11 rows=6572 width=56) (actual time=677.524..743.600 rows=285262 loops=1)
                                             ->  Subquery Scan on "*SELECT* 1"  (cost=72683.86..73012.18 rows=13133 width=60) (actual time=1213.655..1604.483 rows=46812 loops=1)
                                                   ->  Unique  (cost=72683.86..72880.85 rows=13133 width=56) (actual time=1213.653..1600.279 rows=46812 loops=1)
                                                         ->  Remote Subquery Scan on all (dn0)  (cost=72683.86..72782.35 rows=13133 width=56) (actual time=1213.640..1323.552 rows=530865 loops=1)
 Planning time: 0.541 ms
 Execution time: 2998.951 ms
(19 rows)

