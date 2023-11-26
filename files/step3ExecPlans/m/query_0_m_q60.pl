                                                                     QUERY PLAN                                                                     
----------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=290249.68..290249.92 rows=98 width=100) (actual time=526.676..526.684 rows=100 loops=1)
   CTE ss
     ->  GroupAggregate  (cost=140893.18..140894.58 rows=56 width=49) (actual time=262.888..266.119 rows=1547 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=140893.18..140893.60 rows=56 width=23) (actual time=262.863..265.297 rows=2418 loops=1)
   CTE cs
     ->  GroupAggregate  (cost=97061.75..97062.45 rows=28 width=49) (actual time=162.142..163.578 rows=1063 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=97061.75..97061.96 rows=28 width=23) (actual time=162.112..163.069 rows=1356 loops=1)
   CTE ws
     ->  GroupAggregate  (cost=52285.38..52285.73 rows=14 width=49) (actual time=92.559..93.203 rows=500 loops=1)
           Group Key: i_item_id
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=52285.38..52285.49 rows=14 width=23) (actual time=92.549..92.946 rows=570 loops=1)
   ->  Sort  (cost=6.92..7.16 rows=98 width=100) (actual time=526.674..526.677 rows=100 loops=1)
         Sort Key: ss.i_item_id, (sum(ss.total_sales))
         Sort Method: top-N heapsort  Memory: 38kB
         ->  HashAggregate  (cost=2.45..3.68 rows=98 width=100) (actual time=524.933..525.463 rows=2041 loops=1)
               Group Key: ss.i_item_id
               ->  Append  (cost=0.00..1.96 rows=98 width=100) (actual time=262.891..523.804 rows=3110 loops=1)
                     ->  CTE Scan on ss  (cost=0.00..1.12 rows=56 width=100) (actual time=262.890..266.465 rows=1547 loops=1)
                     ->  CTE Scan on cs  (cost=0.00..0.56 rows=28 width=100) (actual time=162.144..163.816 rows=1063 loops=1)
                     ->  CTE Scan on ws  (cost=0.00..0.28 rows=14 width=100) (actual time=92.561..93.305 rows=500 loops=1)
 Planning time: 2.027 ms
 Execution time: 533.262 ms
(24 rows)

