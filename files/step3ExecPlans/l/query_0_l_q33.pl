                                                                        QUERY PLAN                                                                        
----------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=433683.02..433683.27 rows=100 width=36) (actual time=643.089..643.098 rows=100 loops=1)
   CTE ss
     ->  Finalize GroupAggregate  (cost=210628.85..210800.29 rows=1000 width=36) (actual time=295.667..299.296 rows=874 loops=1)
           Group Key: i_manufact_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=210628.85..210779.81 rows=1064 width=36) (actual time=295.654..297.377 rows=2490 loops=1)
   CTE cs
     ->  GroupAggregate  (cost=144966.73..144982.68 rows=638 width=36) (actual time=185.133..204.706 rows=869 loops=1)
           Group Key: i_manufact_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=144966.73..144971.52 rows=638 width=10) (actual time=185.085..201.294 rows=14151 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=77833.00..77840.98 rows=319 width=36) (actual time=122.299..136.108 rows=854 loops=1)
           Group Key: i_manufact_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=77833.00..77835.40 rows=319 width=10) (actual time=122.265..133.470 rows=7407 loops=1)
   ->  Sort  (cost=59.07..59.57 rows=200 width=36) (actual time=643.088..643.091 rows=100 loops=1)
         Sort Key: (sum(ss.total_sales))
         Sort Method: top-N heapsort  Memory: 33kB
         ->  HashAggregate  (cost=48.92..51.42 rows=200 width=36) (actual time=642.522..642.703 rows=875 loops=1)
               Group Key: ss.i_manufact_id
               ->  Append  (cost=0.00..39.14 rows=1957 width=36) (actual time=295.670..641.165 rows=2597 loops=1)
                     ->  CTE Scan on ss  (cost=0.00..20.00 rows=1000 width=36) (actual time=295.669..299.556 rows=874 loops=1)
                     ->  CTE Scan on cs  (cost=0.00..12.76 rows=638 width=36) (actual time=185.136..204.950 rows=869 loops=1)
                     ->  CTE Scan on ws  (cost=0.00..6.38 rows=319 width=36) (actual time=122.302..136.384 rows=854 loops=1)
 Planning time: 1.564 ms
 Execution time: 653.854 ms
(24 rows)

