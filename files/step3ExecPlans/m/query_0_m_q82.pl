                                                                   QUERY PLAN                                                                    
-------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=344076.00..344076.07 rows=3 width=125) (actual time=1731.451..1731.452 rows=1 loops=1)
   ->  Finalize GroupAggregate  (cost=344076.00..344076.07 rows=3 width=125) (actual time=1731.450..1731.450 rows=1 loops=1)
         Group Key: item.i_item_id, item.i_item_desc, item.i_current_price
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=344076.00..344076.02 rows=3 width=125) (actual time=1731.446..1731.446 rows=1 loops=1)
 Planning time: 2.523 ms
 Execution time: 1734.949 ms
(6 rows)

