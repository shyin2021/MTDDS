                                                                                                 QUERY PLAN                                                                                                 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=174522.17..174522.27 rows=1 width=126) (actual time=406.181..416.602 rows=12 loops=1)
   ->  GroupAggregate  (cost=174522.17..174522.27 rows=1 width=126) (actual time=406.180..416.599 rows=12 loops=1)
         Group Key: store.s_store_name, store.s_company_id, store.s_street_number, store.s_street_name, store.s_street_type, store.s_suite_number, store.s_city, store.s_county, store.s_state, store.s_zip
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=174522.17..174522.18 rows=1 width=94) (actual time=405.463..413.684 rows=4841 loops=1)
 Planning time: 1.255 ms
 Execution time: 419.373 ms
(6 rows)

