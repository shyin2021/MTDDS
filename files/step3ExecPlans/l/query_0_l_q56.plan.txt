                                                                      QUERY PLAN                                                                       
-------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=432724.65..432724.87 rows=88 width=100) (actual time=614.536..614.555 rows=100 loops=1)
   CTE ss
     ->  GroupAggregate  (cost=210472.34..210473.59 rows=50 width=49) (actual time=282.002..282.935 rows=379 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=210472.34..210472.72 rows=50 width=23) (actual time=281.991..282.699 rows=852 loops=1)
   CTE cs
     ->  GroupAggregate  (cost=144683.61..144684.24 rows=25 width=49) (actual time=206.243..206.803 rows=290 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=144683.61..144683.80 rows=25 width=23) (actual time=206.233..206.645 rows=468 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=77560.35..77560.68 rows=13 width=49) (actual time=122.654..123.426 rows=185 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=77560.35..77560.45 rows=13 width=23) (actual time=122.631..123.188 rows=230 loops=1)
   ->  Sort  (cost=6.14..6.36 rows=88 width=100) (actual time=614.533..614.540 rows=100 loops=1)
         Sort Key: (sum(ss.total_sales)), ss.i_item_id
         Sort Method: top-N heapsort  Memory: 38kB
         ->  HashAggregate  (cost=2.20..3.30 rows=88 width=100) (actual time=613.900..614.101 rows=426 loops=1)
               Group Key: ss.i_item_id
               ->  Append  (cost=0.00..1.76 rows=88 width=100) (actual time=282.004..613.515 rows=854 loops=1)
                     ->  CTE Scan on ss  (cost=0.00..1.00 rows=50 width=100) (actual time=282.004..283.040 rows=379 loops=1)
                     ->  CTE Scan on cs  (cost=0.00..0.50 rows=25 width=100) (actual time=206.245..206.866 rows=290 loops=1)
                     ->  CTE Scan on ws  (cost=0.00..0.26 rows=13 width=100) (actual time=122.658..123.535 rows=185 loops=1)
 Planning time: 2.022 ms
 Execution time: 629.681 ms
(24 rows)

