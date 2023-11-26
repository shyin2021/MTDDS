                                                                QUERY PLAN                                                                 
-------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=27564.06..27566.81 rows=100 width=52) (actual time=131.068..131.081 rows=14 loops=1)
   ->  GroupAggregate  (cost=27564.06..27576.79 rows=463 width=52) (actual time=131.068..131.079 rows=14 loops=1)
         Group Key: customer_address.ca_zip, customer_address.ca_city
         ->  Remote Subquery Scan on all (dn0)  (cost=27564.06..27567.53 rows=463 width=26) (actual time=131.042..131.044 rows=14 loops=1)
 Planning time: 0.635 ms
 Execution time: 132.151 ms
(6 rows)

