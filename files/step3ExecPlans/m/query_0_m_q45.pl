                                                                  QUERY PLAN                                                                   
-----------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=58354.14..58356.89 rows=100 width=57) (actual time=141.772..141.800 rows=27 loops=1)
   ->  GroupAggregate  (cost=58354.14..58379.91 rows=937 width=57) (actual time=141.771..141.797 rows=27 loops=1)
         Group Key: customer_address.ca_zip, customer_address.ca_county
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=58354.14..58361.17 rows=937 width=31) (actual time=141.763..141.779 rows=27 loops=1)
 Planning time: 0.686 ms
 Execution time: 144.879 ms
(6 rows)

