                                                                         QUERY PLAN                                                                          
-------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=248260.20..248260.45 rows=100 width=272) (actual time=795.560..795.568 rows=100 loops=1)
   ->  Sort  (cost=248260.20..248261.92 rows=689 width=272) (actual time=795.559..795.562 rows=100 loops=1)
         Sort Key: customer_address.ca_country, customer_address.ca_state, customer_address.ca_county, item.i_item_id
         Sort Method: top-N heapsort  Memory: 47kB
         ->  GroupAggregate  (cost=248206.32..248233.87 rows=689 width=272) (actual time=702.934..787.041 rows=25249 loops=1)
               Group Key: item.i_item_id, customer_address.ca_country, customer_address.ca_state, customer_address.ca_county
               Group Key: item.i_item_id, customer_address.ca_country, customer_address.ca_state
               Group Key: item.i_item_id, customer_address.ca_country
               Group Key: item.i_item_id
               Group Key: ()
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=248206.32..248207.61 rows=172 width=81) (actual time=702.898..720.568 rows=6964 loops=1)
 Planning time: 1.551 ms
 Execution time: 803.002 ms
(13 rows)

