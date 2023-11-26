                                                                                       QUERY PLAN                                                                                       
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=475782.35..475782.36 rows=3 width=84) (actual time=1244.965..1244.968 rows=37 loops=1)
   ->  Sort  (cost=475782.35..475782.36 rows=3 width=84) (actual time=1244.964..1244.965 rows=37 loops=1)
         Sort Key: ('web'::text), web.return_rank, web.currency_rank, web.item
         Sort Method: quicksort  Memory: 27kB
         ->  HashAggregate  (cost=475782.27..475782.30 rows=3 width=84) (actual time=1244.937..1244.942 rows=37 loops=1)
               Group Key: ('web'::text), web.item, web.return_ratio, web.return_rank, web.currency_rank
               ->  Append  (cost=78690.64..475782.23 rows=3 width=84) (actual time=218.860..1244.910 rows=37 loops=1)
                     ->  Subquery Scan on web  (cost=78690.64..78690.67 rows=1 width=84) (actual time=218.859..218.882 rows=14 loops=1)
                           Filter: ((web.return_rank <= 10) OR (web.currency_rank <= 10))
                           Rows Removed by Filter: 33
                           ->  WindowAgg  (cost=78690.64..78690.66 rows=1 width=84) (actual time=218.857..218.876 rows=47 loops=1)
                                 ->  Sort  (cost=78690.64..78690.64 rows=1 width=76) (actual time=218.855..218.857 rows=47 loops=1)
                                       Sort Key: currency_ratio
                                       Sort Method: quicksort  Memory: 28kB
                                       ->  WindowAgg  (cost=78690.60..78690.63 rows=1 width=76) (actual time=218.785..218.839 rows=47 loops=1)
                                             ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=78690.60..78690.61 rows=1 width=68) (actual time=218.780..218.812 rows=47 loops=1)
                     ->  Subquery Scan on catalog  (cost=157107.80..157107.84 rows=1 width=84) (actual time=405.699..405.812 rows=12 loops=1)
                           Filter: ((catalog.return_rank <= 10) OR (catalog.currency_rank <= 10))
                           Rows Removed by Filter: 97
                           ->  WindowAgg  (cost=157107.80..157107.82 rows=1 width=84) (actual time=405.697..405.796 rows=109 loops=1)
                                 ->  Sort  (cost=157107.80..157107.81 rows=1 width=76) (actual time=405.694..405.702 rows=109 loops=1)
                                       Sort Key: currency_ratio
                                       Sort Method: quicksort  Memory: 33kB
                                       ->  WindowAgg  (cost=157107.77..157107.79 rows=1 width=76) (actual time=405.311..405.620 rows=109 loops=1)
                                             ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=157107.77..157107.78 rows=1 width=68) (actual time=405.303..405.510 rows=109 loops=1)
                     ->  Subquery Scan on store  (cost=239983.66..239983.69 rows=1 width=84) (actual time=620.193..620.210 rows=11 loops=1)
                           Filter: ((store.return_rank <= 10) OR (store.currency_rank <= 10))
                           Rows Removed by Filter: 25
                           ->  WindowAgg  (cost=239983.66..239983.68 rows=1 width=84) (actual time=620.191..620.206 rows=36 loops=1)
                                 ->  Sort  (cost=239983.66..239983.66 rows=1 width=76) (actual time=620.189..620.191 rows=36 loops=1)
                                       Sort Key: currency_ratio
                                       Sort Method: quicksort  Memory: 27kB
                                       ->  WindowAgg  (cost=239983.62..239983.65 rows=1 width=76) (actual time=620.133..620.171 rows=36 loops=1)
                                             ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=239983.62..239983.63 rows=1 width=68) (actual time=620.129..620.151 rows=36 loops=1)
 Planning time: 1.742 ms
 Execution time: 1253.615 ms
(36 rows)

