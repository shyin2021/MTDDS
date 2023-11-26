                                                                    QUERY PLAN                                                                     
---------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=361192.40..361192.51 rows=1 width=434) (actual time=485.952..485.955 rows=2 loops=1)
   ->  GroupAggregate  (cost=361192.40..361192.51 rows=1 width=434) (actual time=485.951..485.954 rows=2 loops=1)
         Group Key: item.i_item_id, item.i_item_desc, store.s_state
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=361192.40..361192.41 rows=1 width=134) (actual time=485.937..485.937 rows=2 loops=1)
 Planning time: 8.011 ms
 Execution time: 492.376 ms
(6 rows)

