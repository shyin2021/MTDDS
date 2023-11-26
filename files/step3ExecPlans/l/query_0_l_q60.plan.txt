                                                                        QUERY PLAN                                                                        
----------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=433463.66..433463.91 rows=100 width=100) (actual time=714.675..714.684 rows=100 loops=1)
   CTE ss
     ->  GroupAggregate  (cost=210717.60..210726.25 rows=346 width=49) (actual time=308.797..336.889 rows=3311 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=210717.60..210720.19 rows=346 width=23) (actual time=308.784..333.606 rows=14395 loops=1)
   CTE cs
     ->  GroupAggregate  (cost=144917.19..144921.51 rows=173 width=49) (actual time=204.239..234.580 rows=3031 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=144917.19..144918.49 rows=173 width=23) (actual time=204.216..228.624 rows=7989 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=77788.47..77790.62 rows=86 width=49) (actual time=124.537..131.987 rows=2329 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=77788.47..77789.12 rows=86 width=23) (actual time=124.527..130.737 rows=4022 loops=1)
   ->  Sort  (cost=25.27..25.77 rows=200 width=100) (actual time=714.674..714.677 rows=100 loops=1)
         Sort Key: ss.i_item_id, (sum(ss.total_sales))
         Sort Method: top-N heapsort  Memory: 38kB
         ->  HashAggregate  (cost=15.12..17.62 rows=200 width=100) (actual time=711.997..712.907 rows=3354 loops=1)
               Group Key: ss.i_item_id
               ->  Append  (cost=0.00..12.10 rows=605 width=100) (actual time=308.801..707.623 rows=8671 loops=1)
                     ->  CTE Scan on ss  (cost=0.00..6.92 rows=346 width=100) (actual time=308.800..337.881 rows=3311 loops=1)
                     ->  CTE Scan on cs  (cost=0.00..3.46 rows=173 width=100) (actual time=204.243..236.292 rows=3031 loops=1)
                     ->  CTE Scan on ws  (cost=0.00..1.72 rows=86 width=100) (actual time=124.539..132.564 rows=2329 loops=1)
 Planning time: 3.803 ms
 Execution time: 730.990 ms
(24 rows)

