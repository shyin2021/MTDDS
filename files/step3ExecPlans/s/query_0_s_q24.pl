                                                                QUERY PLAN                                                                
------------------------------------------------------------------------------------------------------------------------------------------
 GroupAggregate  (cost=80861.32..80861.35 rows=1 width=358) (actual time=15.231..15.231 rows=0 loops=1)
   Group Key: ssales.c_last_name, ssales.c_first_name, ssales.s_store_name
   Filter: (sum(ssales.netpaid) > $2)
   CTE ssales
     ->  GroupAggregate  (cost=80861.20..80861.25 rows=1 width=158) (actual time=15.223..15.223 rows=0 loops=1)
           Group Key: c_last_name, c_first_name, s_store_name, ca_state, s_state, i_color, i_current_price, i_manager_id, i_units, i_size
           ->  Remote Subquery Scan on all (dn0)  (cost=80861.20..80861.21 rows=1 width=132) (actual time=15.222..15.222 rows=0 loops=1)
   InitPlan 2 (returns $2)
     ->  Aggregate  (cost=0.02..0.04 rows=1 width=32) (never executed)
           ->  CTE Scan on ssales ssales_1  (cost=0.00..0.02 rows=1 width=32) (never executed)
   ->  Sort  (cost=0.03..0.04 rows=1 width=358) (actual time=15.230..15.230 rows=0 loops=1)
         Sort Key: ssales.c_last_name, ssales.c_first_name, ssales.s_store_name
         Sort Method: quicksort  Memory: 25kB
         ->  CTE Scan on ssales  (cost=0.00..0.02 rows=1 width=358) (actual time=15.224..15.224 rows=0 loops=1)
               Filter: (i_color = 'aquamarine'::bpchar)
 Planning time: 3.131 ms
 Execution time: 16.769 ms
(17 rows)

 c_last_name | c_first_name | s_store_name | paid 
-------------+--------------+--------------+------
(0 rows)

