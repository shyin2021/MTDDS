                                                                    QUERY PLAN                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=100527.71..100540.47 rows=100 width=43) (actual time=202.772..203.091 rows=100 loops=1)
   ->  Finalize GroupAggregate  (cost=100527.71..100582.45 rows=429 width=43) (actual time=202.772..203.084 rows=100 loops=1)
         Group Key: customer_address.ca_zip
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=100527.71..100574.40 rows=358 width=43) (actual time=202.736..202.884 rows=200 loops=1)
 Planning time: 0.600 ms
 Execution time: 205.316 ms
(6 rows)

SET
