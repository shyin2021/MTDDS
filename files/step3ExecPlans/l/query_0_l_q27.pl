                                                                     QUERY PLAN                                                                      
-----------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=247493.11..247496.24 rows=100 width=152) (actual time=587.889..588.161 rows=100 loops=1)
   ->  GroupAggregate  (cost=247493.11..247531.95 rows=1243 width=152) (actual time=587.888..588.154 rows=100 loops=1)
         Group Key: item.i_item_id, store.s_state
         Group Key: item.i_item_id
         Group Key: ()
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=247493.11..247497.77 rows=621 width=39) (actual time=587.871..587.975 rows=86 loops=1)
 Planning time: 0.470 ms
 Execution time: 595.314 ms
(8 rows)

