                                                                  QUERY PLAN                                                                   
-----------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=299521.52..299521.59 rows=3 width=125) (actual time=299.430..299.430 rows=0 loops=1)
   ->  Finalize GroupAggregate  (cost=299521.52..299521.59 rows=3 width=125) (actual time=299.429..299.429 rows=0 loops=1)
         Group Key: item.i_item_id, item.i_item_desc, item.i_current_price
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=299521.52..299521.54 rows=3 width=125) (actual time=299.428..299.428 rows=0 loops=1)
 Planning time: 0.852 ms
 Execution time: 302.457 ms
(6 rows)

