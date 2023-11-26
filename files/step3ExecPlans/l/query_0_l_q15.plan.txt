                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=148627.73..148640.47 rows=100 width=43) (actual time=272.222..272.596 rows=100 loops=1)
   ->  Finalize GroupAggregate  (cost=148627.73..148710.01 rows=646 width=43) (actual time=272.220..272.587 rows=100 loops=1)
         Group Key: customer_address.ca_zip
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=148627.73..148697.90 rows=538 width=43) (actual time=272.206..272.410 rows=296 loops=1)
 Planning time: 0.517 ms
 Execution time: 280.036 ms
(6 rows)

SET
