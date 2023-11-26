                                                                                                 QUERY PLAN                                                                                                 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=260767.78..260767.87 rows=1 width=126) (actual time=945.589..982.878 rows=17 loops=1)
   ->  GroupAggregate  (cost=260767.78..260767.87 rows=1 width=126) (actual time=945.588..982.870 rows=17 loops=1)
         Group Key: store.s_store_name, store.s_company_id, store.s_street_number, store.s_street_name, store.s_street_type, store.s_suite_number, store.s_city, store.s_county, store.s_state, store.s_zip
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=260767.78..260767.79 rows=1 width=94) (actual time=940.513..974.227 rows=7238 loops=1)
 Planning time: 1.170 ms
 Execution time: 991.682 ms
(6 rows)

