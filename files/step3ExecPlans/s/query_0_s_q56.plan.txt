                                                                  QUERY PLAN                                                                  
----------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=145276.58..145276.78 rows=82 width=100) (actual time=490.762..490.771 rows=100 loops=1)
   CTE ss
     ->  GroupAggregate  (cost=70502.95..70504.12 rows=47 width=49) (actual time=251.243..252.079 rows=607 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn0)  (cost=70502.95..70503.30 rows=47 width=23) (actual time=251.217..251.470 rows=1097 loops=1)
   CTE cs
     ->  GroupAggregate  (cost=48609.56..48610.13 rows=23 width=49) (actual time=149.086..149.492 rows=441 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn0)  (cost=48609.56..48609.73 rows=23 width=23) (actual time=149.069..149.141 rows=641 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=26156.34..26156.64 rows=12 width=49) (actual time=87.892..88.076 rows=236 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn0)  (cost=26156.34..26156.43 rows=12 width=23) (actual time=87.878..87.907 rows=270 loops=1)
   ->  Sort  (cost=5.68..5.89 rows=82 width=100) (actual time=490.761..490.764 rows=100 loops=1)
         Sort Key: (sum(ss.total_sales)), ss.i_item_id
         Sort Method: top-N heapsort  Memory: 37kB
         ->  HashAggregate  (cost=2.05..3.08 rows=82 width=100) (actual time=490.359..490.526 rows=783 loops=1)
               Group Key: ss.i_item_id
               ->  Append  (cost=0.00..1.64 rows=82 width=100) (actual time=251.245..489.948 rows=1284 loops=1)
                     ->  CTE Scan on ss  (cost=0.00..0.94 rows=47 width=100) (actual time=251.245..252.186 rows=607 loops=1)
                     ->  CTE Scan on cs  (cost=0.00..0.46 rows=23 width=100) (actual time=149.088..149.571 rows=441 loops=1)
                     ->  CTE Scan on ws  (cost=0.00..0.24 rows=12 width=100) (actual time=87.893..88.134 rows=236 loops=1)
 Planning time: 1.857 ms
 Execution time: 494.161 ms
(24 rows)

