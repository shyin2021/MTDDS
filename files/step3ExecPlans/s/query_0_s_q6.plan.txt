                                                                        QUERY PLAN                                                                        
----------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=3011794.14..3011794.26 rows=51 width=11) (actual time=72099.514..72099.518 rows=44 loops=1)
   InitPlan 1 (returns $0)
     ->  Remote Subquery Scan on all (dn0)  (cost=833.44..833.50 rows=11 width=4) (actual time=6.758..6.758 rows=1 loops=1)
   ->  Sort  (cost=3010960.64..3010960.77 rows=51 width=11) (actual time=72099.514..72099.515 rows=44 loops=1)
         Sort Key: (count(*)), a.ca_state
         Sort Method: quicksort  Memory: 27kB
         ->  GroupAggregate  (cost=3010952.77..3010959.19 rows=51 width=11) (actual time=72098.548..72099.497 rows=44 loops=1)
               Group Key: a.ca_state
               Filter: (count(*) >= 10)
               Rows Removed by Filter: 6
               ->  Remote Subquery Scan on all (dn0)  (cost=3010952.77..3010955.73 rows=394 width=3) (actual time=72098.531..72099.082 rows=2707 loops=1)
 Planning time: 1.266 ms
 Execution time: 72100.551 ms
(13 rows)

