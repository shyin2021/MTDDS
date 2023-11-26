                                                                   QUERY PLAN                                                                    
-------------------------------------------------------------------------------------------------------------------------------------------------
 GroupAggregate  (cost=169357.16..169357.19 rows=1 width=358) (actual time=281.804..281.804 rows=0 loops=1)
   Group Key: ssales.c_last_name, ssales.c_first_name, ssales.s_store_name
   Filter: (sum(ssales.netpaid) > $2)
   CTE ssales
     ->  GroupAggregate  (cost=169357.04..169357.09 rows=1 width=158) (actual time=281.795..281.796 rows=0 loops=1)
           Group Key: c_last_name, c_first_name, s_store_name, ca_state, s_state, i_color, i_current_price, i_manager_id, i_units, i_size
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=169357.04..169357.05 rows=1 width=132) (actual time=281.794..281.794 rows=0 loops=1)
   InitPlan 2 (returns $2)
     ->  Aggregate  (cost=0.02..0.04 rows=1 width=32) (never executed)
           ->  CTE Scan on ssales ssales_1  (cost=0.00..0.02 rows=1 width=32) (never executed)
   ->  Sort  (cost=0.03..0.04 rows=1 width=358) (actual time=281.803..281.803 rows=0 loops=1)
         Sort Key: ssales.c_last_name, ssales.c_first_name, ssales.s_store_name
         Sort Method: quicksort  Memory: 25kB
         ->  CTE Scan on ssales  (cost=0.00..0.02 rows=1 width=358) (actual time=281.797..281.797 rows=0 loops=1)
               Filter: (i_color = 'goldenrod'::bpchar)
 Planning time: 1.881 ms
 Execution time: 285.505 ms
(17 rows)

 c_last_name | c_first_name | s_store_name | paid 
-------------+--------------+--------------+------
(0 rows)

