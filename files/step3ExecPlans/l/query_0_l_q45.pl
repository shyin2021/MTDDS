                                                                     QUERY PLAN                                                                     
----------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=85162.92..85165.67 rows=100 width=57) (actual time=190.794..190.851 rows=40 loops=1)
   ->  GroupAggregate  (cost=85162.92..85201.59 rows=1406 width=57) (actual time=190.793..190.847 rows=40 loops=1)
         Group Key: customer_address.ca_zip, customer_address.ca_county
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=85162.92..85173.47 rows=1406 width=31) (actual time=190.782..190.816 rows=40 loops=1)
 Planning time: 0.641 ms
 Execution time: 198.961 ms
(6 rows)

