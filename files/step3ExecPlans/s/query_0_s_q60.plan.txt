                                                                  QUERY PLAN                                                                  
----------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=145241.99..145242.24 rows=100 width=100) (actual time=543.856..543.865 rows=100 loops=1)
   CTE ss
     ->  GroupAggregate  (cost=70483.97..70485.89 rows=77 width=49) (actual time=273.596..276.315 rows=1494 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn0)  (cost=70483.97..70484.55 rows=77 width=23) (actual time=273.565..274.519 rows=3941 loops=1)
   CTE cs
     ->  GroupAggregate  (cost=48597.35..48598.33 rows=39 width=49) (actual time=164.532..166.064 rows=1135 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn0)  (cost=48597.35..48597.65 rows=39 width=23) (actual time=164.516..165.009 rows=2032 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=26147.46..26147.93 rows=19 width=49) (actual time=97.392..98.233 rows=782 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn0)  (cost=26147.46..26147.60 rows=19 width=23) (actual time=97.374..97.626 rows=1104 loops=1)
   ->  Sort  (cost=9.84..10.18 rows=135 width=100) (actual time=543.856..543.859 rows=100 loops=1)
         Sort Key: ss.i_item_id, (sum(ss.total_sales))
         Sort Method: top-N heapsort  Memory: 38kB
         ->  HashAggregate  (cost=3.38..5.06 rows=135 width=100) (actual time=542.384..542.767 rows=1610 loops=1)
               Group Key: ss.i_item_id
               ->  Append  (cost=0.00..2.70 rows=135 width=100) (actual time=273.599..541.378 rows=3411 loops=1)
                     ->  CTE Scan on ss  (cost=0.00..1.54 rows=77 width=100) (actual time=273.599..276.583 rows=1494 loops=1)
                     ->  CTE Scan on cs  (cost=0.00..0.78 rows=39 width=100) (actual time=164.534..166.264 rows=1135 loops=1)
                     ->  CTE Scan on ws  (cost=0.00..0.38 rows=19 width=100) (actual time=97.394..98.386 rows=782 loops=1)
 Planning time: 1.757 ms
 Execution time: 547.363 ms
(24 rows)

