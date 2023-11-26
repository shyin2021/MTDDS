                                                                  QUERY PLAN                                                                   
-----------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=241180.63..241180.73 rows=1 width=434) (actual time=440.045..440.045 rows=0 loops=1)
   ->  GroupAggregate  (cost=241180.63..241180.73 rows=1 width=434) (actual time=440.044..440.044 rows=0 loops=1)
         Group Key: item.i_item_id, item.i_item_desc, store.s_state
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=241180.63..241180.64 rows=1 width=134) (actual time=440.043..440.043 rows=0 loops=1)
 Planning time: 8.180 ms
 Execution time: 443.057 ms
(6 rows)

