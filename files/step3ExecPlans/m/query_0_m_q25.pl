                                                                  QUERY PLAN                                                                   
-----------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=240384.99..240385.03 rows=1 width=237) (actual time=421.743..421.743 rows=0 loops=1)
   ->  GroupAggregate  (cost=240384.99..240385.03 rows=1 width=237) (actual time=421.742..421.743 rows=0 loops=1)
         Group Key: item.i_item_id, item.i_item_desc, store.s_store_id, store.s_store_name
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=240384.99..240385.00 rows=1 width=159) (actual time=421.741..421.741 rows=0 loops=1)
 Planning time: 14.137 ms
 Execution time: 425.189 ms
(6 rows)

