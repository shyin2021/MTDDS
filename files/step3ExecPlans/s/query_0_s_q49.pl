                                                                                 QUERY PLAN                                                                                  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=166532.08..166532.09 rows=3 width=84) (actual time=1130.377..1130.380 rows=34 loops=1)
   ->  Sort  (cost=166532.08..166532.09 rows=3 width=84) (actual time=1130.376..1130.378 rows=34 loops=1)
         Sort Key: ('web'::text), web.return_rank, web.currency_rank, web.item
         Sort Method: quicksort  Memory: 27kB
         ->  HashAggregate  (cost=166531.99..166532.02 rows=3 width=84) (actual time=1130.352..1130.357 rows=34 loops=1)
               Group Key: ('web'::text), web.item, web.return_ratio, web.return_rank, web.currency_rank
               ->  Append  (cost=28498.26..166531.96 rows=3 width=84) (actual time=188.840..1130.334 rows=34 loops=1)
                     ->  Subquery Scan on web  (cost=28498.26..28498.30 rows=1 width=84) (actual time=188.839..188.849 rows=11 loops=1)
                           Filter: ((web.return_rank <= 10) OR (web.currency_rank <= 10))
                           Rows Removed by Filter: 8
                           ->  WindowAgg  (cost=28498.26..28498.28 rows=1 width=84) (actual time=188.838..188.846 rows=19 loops=1)
                                 ->  Sort  (cost=28498.26..28498.27 rows=1 width=76) (actual time=188.836..188.837 rows=19 loops=1)
                                       Sort Key: currency_ratio
                                       Sort Method: quicksort  Memory: 26kB
                                       ->  WindowAgg  (cost=28498.23..28498.25 rows=1 width=76) (actual time=188.810..188.829 rows=19 loops=1)
                                             ->  Remote Subquery Scan on all (dn0)  (cost=28498.23..28498.24 rows=1 width=68) (actual time=188.791..188.793 rows=19 loops=1)
                     ->  Subquery Scan on catalog  (cost=55179.81..55179.84 rows=1 width=84) (actual time=367.855..367.879 rows=10 loops=1)
                           Filter: ((catalog.return_rank <= 10) OR (catalog.currency_rank <= 10))
                           Rows Removed by Filter: 40
                           ->  WindowAgg  (cost=55179.81..55179.83 rows=1 width=84) (actual time=367.854..367.874 rows=50 loops=1)
                                 ->  Sort  (cost=55179.81..55179.81 rows=1 width=76) (actual time=367.852..367.854 rows=50 loops=1)
                                       Sort Key: currency_ratio
                                       Sort Method: quicksort  Memory: 28kB
                                       ->  WindowAgg  (cost=55179.77..55179.80 rows=1 width=76) (actual time=367.791..367.835 rows=50 loops=1)
                                             ->  Remote Subquery Scan on all (dn0)  (cost=55179.77..55179.78 rows=1 width=68) (actual time=367.777..367.783 rows=50 loops=1)
                     ->  Subquery Scan on store  (cost=82853.75..82853.78 rows=1 width=84) (actual time=573.593..573.603 rows=13 loops=1)
                           Filter: ((store.return_rank <= 10) OR (store.currency_rank <= 10))
                           Rows Removed by Filter: 6
                           ->  WindowAgg  (cost=82853.75..82853.77 rows=1 width=84) (actual time=573.591..573.600 rows=19 loops=1)
                                 ->  Sort  (cost=82853.75..82853.75 rows=1 width=76) (actual time=573.590..573.591 rows=19 loops=1)
                                       Sort Key: currency_ratio
                                       Sort Method: quicksort  Memory: 26kB
                                       ->  WindowAgg  (cost=82853.71..82853.74 rows=1 width=76) (actual time=573.561..573.580 rows=19 loops=1)
                                             ->  Remote Subquery Scan on all (dn0)  (cost=82853.71..82853.72 rows=1 width=68) (actual time=573.549..573.551 rows=19 loops=1)
 Planning time: 1.732 ms
 Execution time: 1132.122 ms
(36 rows)

