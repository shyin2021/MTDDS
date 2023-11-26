                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=291505.09..291505.34 rows=100 width=36) (actual time=573.860..573.868 rows=100 loops=1)
   CTE ss
     ->  GroupAggregate  (cost=141330.93..141350.96 rows=801 width=36) (actual time=271.660..288.116 rows=786 loops=1)
           Group Key: i_manufact_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=141330.93..141336.94 rows=801 width=10) (actual time=271.600..285.509 rows=16395 loops=1)
   CTE cs
     ->  GroupAggregate  (cost=97447.59..97457.59 rows=400 width=36) (actual time=168.637..176.423 rows=770 loops=1)
           Group Key: i_manufact_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=97447.59..97450.59 rows=400 width=10) (actual time=168.592..174.969 rows=8229 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=52646.32..52651.35 rows=201 width=36) (actual time=102.865..107.300 rows=736 loops=1)
           Group Key: i_manufact_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=52646.32..52647.83 rows=201 width=10) (actual time=102.809..106.471 rows=4304 loops=1)
   ->  Sort  (cost=45.19..45.69 rows=200 width=36) (actual time=573.859..573.862 rows=100 loops=1)
         Sort Key: (sum(ss.total_sales))
         Sort Method: top-N heapsort  Memory: 33kB
         ->  HashAggregate  (cost=35.05..37.55 rows=200 width=36) (actual time=573.318..573.500 rows=787 loops=1)
               Group Key: ss.i_manufact_id
               ->  Append  (cost=0.00..28.04 rows=1402 width=36) (actual time=271.662..572.527 rows=2292 loops=1)
                     ->  CTE Scan on ss  (cost=0.00..16.02 rows=801 width=36) (actual time=271.662..288.318 rows=786 loops=1)
                     ->  CTE Scan on cs  (cost=0.00..8.00 rows=400 width=36) (actual time=168.638..176.586 rows=770 loops=1)
                     ->  CTE Scan on ws  (cost=0.00..4.02 rows=201 width=36) (actual time=102.867..107.463 rows=736 loops=1)
 Planning time: 1.597 ms
 Execution time: 580.383 ms
(24 rows)

