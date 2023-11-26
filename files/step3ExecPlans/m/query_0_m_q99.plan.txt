                                                                   QUERY PLAN                                                                    
-------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=90542.65..90869.28 rows=100 width=116) (actual time=599.797..651.064 rows=100 loops=1)
   ->  Finalize GroupAggregate  (cost=90542.65..90934.60 rows=120 width=116) (actual time=599.796..651.056 rows=100 loops=1)
         Group Key: substr((warehouse.w_warehouse_name)::text, 1, 20), ship_mode.sm_type, call_center.cc_name
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=90542.65..90928.30 rows=240 width=116) (actual time=599.789..650.988 rows=201 loops=1)
 Planning time: 2.946 ms
 Execution time: 654.639 ms
(6 rows)

