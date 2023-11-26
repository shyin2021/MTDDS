                                                                   QUERY PLAN                                                                    
-------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=45509.87..45669.57 rows=100 width=110) (actual time=305.737..331.179 rows=100 loops=1)
   ->  Finalize GroupAggregate  (cost=45509.87..45701.51 rows=120 width=110) (actual time=305.736..331.172 rows=100 loops=1)
         Group Key: substr((warehouse.w_warehouse_name)::text, 1, 20), ship_mode.sm_type, web_site.web_name
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=45509.87..45695.21 rows=240 width=110) (actual time=305.728..331.039 rows=201 loops=1)
 Planning time: 0.513 ms
 Execution time: 333.844 ms
(6 rows)

