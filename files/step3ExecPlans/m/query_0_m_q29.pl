                                                                  QUERY PLAN                                                                   
-----------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=244074.26..244074.29 rows=1 width=153) (actual time=542.923..542.923 rows=0 loops=1)
   ->  GroupAggregate  (cost=244074.26..244074.29 rows=1 width=153) (actual time=542.912..542.912 rows=0 loops=1)
         Group Key: item.i_item_id, item.i_item_desc, store.s_store_id, store.s_store_name
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=244074.26..244074.27 rows=1 width=153) (actual time=542.911..542.911 rows=0 loops=1)
 Planning time: 9.897 ms
 Execution time: 545.793 ms
(6 rows)

