                                                                               QUERY PLAN                                                                                
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=105414104.18..105414104.31 rows=51 width=11) (actual time=583039.163..583039.167 rows=50 loops=1)
   InitPlan 1 (returns $0)
     ->  Remote Subquery Scan on all (dn2)  (cost=17.85..18.16 rows=31 width=4) (actual time=1.356..1.357 rows=1 loops=1)
   ->  Sort  (cost=105414086.02..105414086.15 rows=51 width=11) (actual time=583039.161..583039.163 rows=50 loops=1)
         Sort Key: (count(*)), a.ca_state
         Sort Method: quicksort  Memory: 27kB
         ->  GroupAggregate  (cost=105414066.32..105414084.58 rows=51 width=11) (actual time=583031.074..583039.143 rows=50 loops=1)
               Group Key: a.ca_state
               Filter: (count(*) >= 10)
               Rows Removed by Filter: 2
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=105414066.32..105414075.20 rows=1183 width=3) (actual time=583031.044..583038.506 rows=7472 loops=1)
 Planning time: 0.534 ms
 Execution time: 583048.069 ms
(13 rows)

