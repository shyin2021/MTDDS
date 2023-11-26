                                                                                    QUERY PLAN                                                                                     
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=317854.38..317854.38 rows=3 width=84) (actual time=1148.238..1148.240 rows=36 loops=1)
   ->  Sort  (cost=317854.38..317854.38 rows=3 width=84) (actual time=1148.237..1148.238 rows=36 loops=1)
         Sort Key: ('web'::text), web.return_rank, web.currency_rank, web.item
         Sort Method: quicksort  Memory: 27kB
         ->  HashAggregate  (cost=317854.29..317854.32 rows=3 width=84) (actual time=1148.190..1148.195 rows=36 loops=1)
               Group Key: ('web'::text), web.item, web.return_ratio, web.return_rank, web.currency_rank
               ->  Append  (cost=52850.38..317854.25 rows=3 width=84) (actual time=193.079..1148.165 rows=36 loops=1)
                     ->  Subquery Scan on web  (cost=52850.38..52850.41 rows=1 width=84) (actual time=193.078..193.094 rows=11 loops=1)
                           Filter: ((web.return_rank <= 10) OR (web.currency_rank <= 10))
                           Rows Removed by Filter: 20
                           ->  WindowAgg  (cost=52850.38..52850.40 rows=1 width=84) (actual time=193.076..193.090 rows=31 loops=1)
                                 ->  Sort  (cost=52850.38..52850.38 rows=1 width=76) (actual time=193.072..193.074 rows=31 loops=1)
                                       Sort Key: currency_ratio
                                       Sort Method: quicksort  Memory: 27kB
                                       ->  WindowAgg  (cost=52850.34..52850.37 rows=1 width=76) (actual time=193.024..193.058 rows=31 loops=1)
                                             ->  Remote Subquery Scan on all (dn1,dn2)  (cost=52850.34..52850.35 rows=1 width=68) (actual time=193.016..193.035 rows=31 loops=1)
                     ->  Subquery Scan on catalog  (cost=104852.83..104852.86 rows=1 width=84) (actual time=381.574..381.606 rows=13 loops=1)
                           Filter: ((catalog.return_rank <= 10) OR (catalog.currency_rank <= 10))
                           Rows Removed by Filter: 47
                           ->  WindowAgg  (cost=104852.83..104852.85 rows=1 width=84) (actual time=381.572..381.599 rows=60 loops=1)
                                 ->  Sort  (cost=104852.83..104852.83 rows=1 width=76) (actual time=381.568..381.570 rows=60 loops=1)
                                       Sort Key: currency_ratio
                                       Sort Method: quicksort  Memory: 29kB
                                       ->  WindowAgg  (cost=104852.79..104852.82 rows=1 width=76) (actual time=381.464..381.541 rows=60 loops=1)
                                             ->  Remote Subquery Scan on all (dn1,dn2)  (cost=104852.79..104852.80 rows=1 width=68) (actual time=381.452..381.489 rows=60 loops=1)
                     ->  Subquery Scan on store  (cost=160150.92..160150.95 rows=1 width=84) (actual time=573.442..573.461 rows=12 loops=1)
                           Filter: ((store.return_rank <= 10) OR (store.currency_rank <= 10))
                           Rows Removed by Filter: 24
                           ->  WindowAgg  (cost=160150.92..160150.94 rows=1 width=84) (actual time=573.440..573.457 rows=36 loops=1)
                                 ->  Sort  (cost=160150.92..160150.92 rows=1 width=76) (actual time=573.437..573.438 rows=36 loops=1)
                                       Sort Key: currency_ratio
                                       Sort Method: quicksort  Memory: 27kB
                                       ->  WindowAgg  (cost=160150.88..160150.91 rows=1 width=76) (actual time=573.355..573.415 rows=36 loops=1)
                                             ->  Remote Subquery Scan on all (dn1,dn2)  (cost=160150.88..160150.89 rows=1 width=68) (actual time=573.349..573.371 rows=36 loops=1)
 Planning time: 1.903 ms
 Execution time: 1153.963 ms
(36 rows)

