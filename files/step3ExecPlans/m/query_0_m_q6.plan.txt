                                                                            QUERY PLAN                                                                            
------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=55064220.66..55064220.79 rows=51 width=11) (actual time=206483.882..206483.885 rows=48 loops=1)
   InitPlan 1 (returns $0)
     ->  Remote Subquery Scan on all (dn1)  (cost=17.85..18.17 rows=32 width=4) (actual time=2.760..2.761 rows=1 loops=1)
   ->  Sort  (cost=55064202.49..55064202.62 rows=51 width=11) (actual time=206483.881..206483.882 rows=48 loops=1)
         Sort Key: (count(*)), a.ca_state
         Sort Method: quicksort  Memory: 27kB
         ->  GroupAggregate  (cost=55064188.70..55064201.04 rows=51 width=11) (actual time=206479.916..206483.862 rows=48 loops=1)
               Group Key: a.ca_state
               Filter: (count(*) >= 10)
               Rows Removed by Filter: 3
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=55064188.70..55064194.62 rows=789 width=3) (actual time=206479.901..206483.328 rows=5296 loops=1)
 Planning time: 0.634 ms
 Execution time: 206487.617 ms
(13 rows)

