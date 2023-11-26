                                                                       QUERY PLAN                                                                        
---------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=193948.47..193948.72 rows=100 width=272) (actual time=687.816..687.824 rows=100 loops=1)
   ->  Sort  (cost=193948.47..193949.67 rows=477 width=272) (actual time=687.815..687.818 rows=100 loops=1)
         Sort Key: customer_address.ca_country, customer_address.ca_state, customer_address.ca_county, item.i_item_id
         Sort Method: top-N heapsort  Memory: 46kB
         ->  GroupAggregate  (cost=193911.18..193930.24 rows=477 width=272) (actual time=627.868..681.891 rows=17519 loops=1)
               Group Key: item.i_item_id, customer_address.ca_country, customer_address.ca_state, customer_address.ca_county
               Group Key: item.i_item_id, customer_address.ca_country, customer_address.ca_state
               Group Key: item.i_item_id, customer_address.ca_country
               Group Key: item.i_item_id
               Group Key: ()
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=193911.18..193912.07 rows=119 width=81) (actual time=627.851..637.452 rows=4805 loops=1)
 Planning time: 1.828 ms
 Execution time: 691.226 ms
(13 rows)

