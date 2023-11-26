                                                                                  QUERY PLAN                                                                                  
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=72797.03..72797.04 rows=1 width=72) (actual time=6341.066..6341.067 rows=1 loops=1)
   ->  Sort  (cost=72797.03..72797.04 rows=1 width=72) (actual time=6341.065..6341.065 rows=1 loops=1)
         Sort Key: (count(DISTINCT cs1.cs_order_number))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=72797.01..72797.02 rows=1 width=72) (actual time=6341.058..6341.058 rows=1 loops=1)
               ->  Nested Loop Anti Join  (cost=69843.09..72797.00 rows=1 width=16) (actual time=2401.372..6340.784 rows=172 loops=1)
                     ->  Nested Loop  (cost=69842.92..71716.29 rows=1 width=16) (actual time=2239.729..5441.656 rows=469 loops=1)
                           Join Filter: (cs1.cs_call_center_sk = call_center.cc_call_center_sk)
                           Rows Removed by Join Filter: 1176
                           ->  Nested Loop  (cost=69842.92..71701.11 rows=1 width=20) (actual time=2239.577..5440.851 rows=469 loops=1)
                                 ->  Remote Subquery Scan on all (dn0,dn1,dn2)  (cost=69942.75..71800.13 rows=6 width=24) (actual time=2234.509..2257.224 rows=27613 loops=1)
                                 ->  Materialize  (cost=100.16..100.19 rows=1 width=4) (actual time=0.113..0.113 rows=0 loops=27613)
                                       ->  Remote Subquery Scan on all (dn0)  (cost=100.16..100.19 rows=1 width=4) (actual time=0.113..0.113 rows=0 loops=27613)
                           ->  Materialize  (cost=100.00..115.00 rows=180 width=4) (actual time=0.000..0.001 rows=4 loops=469)
                                 ->  Remote Subquery Scan on all (dn0)  (cost=100.00..114.55 rows=180 width=4) (actual time=0.143..0.144 rows=6 loops=1)
                     ->  Materialize  (cost=100.17..1180.72 rows=2 width=4) (actual time=1.916..1.916 rows=1 loops=469)
                           ->  Remote Subquery Scan on all (dn0)  (cost=100.17..1180.71 rows=2 width=4) (actual time=1.916..1.916 rows=1 loops=469)
 Planning time: 3.010 ms
 Execution time: 6357.724 ms
(19 rows)

SET
