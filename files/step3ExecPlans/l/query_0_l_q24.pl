                                                                      QUERY PLAN                                                                       
-------------------------------------------------------------------------------------------------------------------------------------------------------
 GroupAggregate  (cost=259070.97..259071.00 rows=1 width=358) (actual time=710.636..710.636 rows=0 loops=1)
   Group Key: ssales.c_last_name, ssales.c_first_name, ssales.s_store_name
   Filter: (sum(ssales.netpaid) > $2)
   CTE ssales
     ->  GroupAggregate  (cost=259070.85..259070.90 rows=1 width=158) (actual time=710.290..710.563 rows=116 loops=1)
           Group Key: c_last_name, c_first_name, s_store_name, ca_state, s_state, i_color, i_current_price, i_manager_id, i_units, i_size
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=259070.85..259070.86 rows=1 width=132) (actual time=710.279..710.480 rows=116 loops=1)
   InitPlan 2 (returns $2)
     ->  Aggregate  (cost=0.02..0.04 rows=1 width=32) (never executed)
           ->  CTE Scan on ssales ssales_1  (cost=0.00..0.02 rows=1 width=32) (never executed)
   ->  Sort  (cost=0.03..0.04 rows=1 width=358) (actual time=710.635..710.635 rows=0 loops=1)
         Sort Key: ssales.c_last_name, ssales.c_first_name, ssales.s_store_name
         Sort Method: quicksort  Memory: 25kB
         ->  CTE Scan on ssales  (cost=0.00..0.02 rows=1 width=358) (actual time=710.627..710.627 rows=0 loops=1)
               Filter: (i_color = 'powder'::bpchar)
               Rows Removed by Filter: 116
 Planning time: 1.874 ms
 Execution time: 720.428 ms
(18 rows)

 c_last_name | c_first_name | s_store_name | paid 
-------------+--------------+--------------+------
(0 rows)

