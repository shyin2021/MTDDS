                                                                      QUERY PLAN                                                                       
-------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=135750.93..136099.74 rows=100 width=116) (actual time=681.044..724.959 rows=100 loops=1)
   ->  Finalize GroupAggregate  (cost=135750.93..136378.79 rows=180 width=116) (actual time=681.043..724.925 rows=100 loops=1)
         Group Key: substr((warehouse.w_warehouse_name)::text, 1, 20), ship_mode.sm_type, call_center.cc_name
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=135750.93..136369.34 rows=360 width=116) (actual time=681.034..724.739 rows=301 loops=1)
 Planning time: 0.667 ms
 Execution time: 766.241 ms
(6 rows)

