                                                                   QUERY PLAN                                                                    
-------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=178300.40..178303.52 rows=100 width=152) (actual time=558.916..559.234 rows=100 loops=1)
   ->  GroupAggregate  (cost=178300.40..178326.29 rows=829 width=152) (actual time=558.915..559.227 rows=100 loops=1)
         Group Key: item.i_item_id, store.s_state
         Group Key: item.i_item_id
         Group Key: ()
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=178300.40..178303.50 rows=414 width=39) (actual time=558.901..558.981 rows=84 loops=1)
 Planning time: 0.496 ms
 Execution time: 569.534 ms
(8 rows)

