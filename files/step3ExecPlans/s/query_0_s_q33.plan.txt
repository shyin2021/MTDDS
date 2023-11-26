                                                                  QUERY PLAN                                                                   
-----------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=145393.95..145394.20 rows=100 width=36) (actual time=515.618..515.627 rows=100 loops=1)
   CTE ss
     ->  Finalize GroupAggregate  (cost=70496.15..70538.40 rows=301 width=36) (actual time=260.042..262.410 rows=688 loops=1)
           Group Key: i_manufact_id
           ->  Remote Subquery Scan on all (dn0)  (cost=70496.15..70532.76 rows=250 width=36) (actual time=260.028..261.869 rows=688 loops=1)
   CTE cs
     ->  GroupAggregate  (cost=48641.22..48644.99 rows=151 width=36) (actual time=151.246..154.029 rows=676 loops=1)
           Group Key: i_manufact_id
           ->  Remote Subquery Scan on all (dn0)  (cost=48641.22..48642.35 rows=151 width=10) (actual time=151.226..152.636 rows=4351 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=26185.36..26187.24 rows=75 width=36) (actual time=96.121..97.729 rows=618 loops=1)
           Group Key: i_manufact_id
           ->  Remote Subquery Scan on all (dn0)  (cost=26185.36..26185.92 rows=75 width=10) (actual time=96.102..96.868 rows=2402 loops=1)
   ->  Sort  (cost=23.32..23.82 rows=200 width=36) (actual time=515.618..515.621 rows=100 loops=1)
         Sort Key: (sum(ss.total_sales))
         Sort Method: top-N heapsort  Memory: 33kB
         ->  HashAggregate  (cost=13.18..15.68 rows=200 width=36) (actual time=515.156..515.302 rows=698 loops=1)
               Group Key: ss.i_manufact_id
               ->  Append  (cost=0.00..10.54 rows=527 width=36) (actual time=260.044..514.584 rows=1982 loops=1)
                     ->  CTE Scan on ss  (cost=0.00..6.02 rows=301 width=36) (actual time=260.043..262.523 rows=688 loops=1)
                     ->  CTE Scan on cs  (cost=0.00..3.02 rows=151 width=36) (actual time=151.248..154.139 rows=676 loops=1)
                     ->  CTE Scan on ws  (cost=0.00..1.50 rows=75 width=36) (actual time=96.123..97.838 rows=618 loops=1)
 Planning time: 1.320 ms
 Execution time: 518.198 ms
(24 rows)

