                                                                     QUERY PLAN                                                                      
-----------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=68233.99..68404.88 rows=100 width=110) (actual time=326.186..347.233 rows=100 loops=1)
   ->  Finalize GroupAggregate  (cost=68233.99..68541.60 rows=180 width=110) (actual time=326.185..347.225 rows=100 loops=1)
         Group Key: substr((warehouse.w_warehouse_name)::text, 1, 20), ship_mode.sm_type, web_site.web_name
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=68233.99..68532.15 rows=360 width=110) (actual time=326.033..346.992 rows=301 loops=1)
 Planning time: 0.438 ms
 Execution time: 367.663 ms
(6 rows)

