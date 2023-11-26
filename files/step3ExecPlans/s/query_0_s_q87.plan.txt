                                                                                         QUERY PLAN                                                                                          
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=146927.79..146927.80 rows=1 width=8) (actual time=2964.016..2964.016 rows=1 loops=1)
   ->  Subquery Scan on cool_cust  (cost=71533.35..146898.50 rows=11713 width=0) (actual time=2956.087..2961.917 rows=47049 loops=1)
         ->  HashSetOp Except  (cost=71533.35..146781.37 rows=11713 width=216) (actual time=2956.086..2958.252 rows=47049 loops=1)
               ->  Append  (cost=71533.35..146671.59 rows=14638 width=216) (actual time=2515.688..2941.648 rows=58861 loops=1)
                     ->  Result  (cost=71533.35..120876.50 rows=11713 width=216) (actual time=2515.688..2524.478 rows=47117 loops=1)
                           ->  HashSetOp Except  (cost=71533.35..120759.37 rows=11713 width=216) (actual time=2515.687..2520.669 rows=47117 loops=1)
                                 ->  Append  (cost=71533.35..120627.56 rows=17574 width=216) (actual time=1202.675..2495.364 rows=79108 loops=1)
                                       ->  Subquery Scan on "*SELECT* 1"  (cost=71533.35..71826.17 rows=11713 width=60) (actual time=1202.674..1607.018 rows=47428 loops=1)
                                             ->  Unique  (cost=71533.35..71709.04 rows=11713 width=56) (actual time=1202.673..1602.362 rows=47428 loops=1)
                                                   ->  Remote Subquery Scan on all (dn0)  (cost=71533.35..71621.20 rows=11713 width=56) (actual time=1202.660..1317.704 rows=537699 loops=1)
                                       ->  Subquery Scan on "*SELECT* 2"  (cost=48654.86..48801.39 rows=5861 width=60) (actual time=657.496..884.581 rows=31680 loops=1)
                                             ->  Unique  (cost=48654.86..48742.78 rows=5861 width=56) (actual time=657.495..881.604 rows=31680 loops=1)
                                                   ->  Remote Subquery Scan on all (dn0)  (cost=48654.86..48698.82 rows=5861 width=56) (actual time=657.481..730.576 rows=285976 loops=1)
                     ->  Subquery Scan on "*SELECT* 3"  (cost=25721.97..25795.09 rows=2925 width=60) (actual time=297.352..414.710 rows=11744 loops=1)
                           ->  Unique  (cost=25721.97..25765.84 rows=2925 width=56) (actual time=297.350..413.534 rows=11744 loops=1)
                                 ->  Remote Subquery Scan on all (dn0)  (cost=25721.97..25743.91 rows=2925 width=56) (actual time=297.338..337.578 rows=141650 loops=1)
 Planning time: 1.208 ms
 Execution time: 2965.411 ms
(18 rows)

