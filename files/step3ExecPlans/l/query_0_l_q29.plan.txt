                                                                    QUERY PLAN                                                                     
---------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=365503.05..365503.09 rows=1 width=153) (actual time=607.752..607.752 rows=0 loops=1)
   ->  GroupAggregate  (cost=365503.05..365503.09 rows=1 width=153) (actual time=607.750..607.751 rows=0 loops=1)
         Group Key: item.i_item_id, item.i_item_desc, store.s_store_id, store.s_store_name
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=365503.05..365503.06 rows=1 width=153) (actual time=607.748..607.748 rows=0 loops=1)
 Planning time: 12.375 ms
 Execution time: 617.962 ms
(6 rows)

