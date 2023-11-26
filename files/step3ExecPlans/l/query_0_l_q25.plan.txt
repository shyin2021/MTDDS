                                                                    QUERY PLAN                                                                     
---------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=359989.79..359989.83 rows=1 width=237) (actual time=484.242..484.242 rows=0 loops=1)
   ->  GroupAggregate  (cost=359989.79..359989.83 rows=1 width=237) (actual time=484.241..484.241 rows=0 loops=1)
         Group Key: item.i_item_id, item.i_item_desc, store.s_store_id, store.s_store_name
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=359989.79..359989.80 rows=1 width=159) (actual time=484.240..484.240 rows=0 loops=1)
 Planning time: 14.295 ms
 Execution time: 492.801 ms
(6 rows)

