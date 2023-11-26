                                                                                    QUERY PLAN                                                                                     
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=147874.51..147874.76 rows=100 width=170) (actual time=562.025..562.035 rows=100 loops=1)
   ->  Sort  (cost=147874.51..147878.05 rows=1418 width=170) (actual time=562.024..562.027 rows=100 loops=1)
         Sort Key: c_last_name, dn.ss_ticket_number
         Sort Method: top-N heapsort  Memory: 49kB
         ->  Hash Join  (cost=140853.52..147820.31 rows=1418 width=170) (actual time=382.903..556.295 rows=4418 loops=1)
               Hash Cond: (c_current_addr_sk = ca_address_sk)
               Join Filter: ((ca_city)::text <> (dn.bought_city)::text)
               Rows Removed by Join Filter: 273
               ->  Merge Join  (cost=137667.52..144630.59 rows=1420 width=165) (actual time=321.780..490.873 rows=4691 loops=1)
                     Merge Cond: (c_customer_sk = dn.ss_customer_sk)
                     ->  Remote Subquery Scan on all (dn2)  (cost=100.17..16041.94 rows=144000 width=60) (actual time=0.217..74.128 rows=143919 loops=1)
                     ->  Sort  (cost=137667.35..137670.90 rows=1420 width=113) (actual time=321.515..322.622 rows=4692 loops=1)
                           Sort Key: dn.ss_customer_sk
                           Sort Method: quicksort  Memory: 598kB
                           ->  Subquery Scan on dn  (cost=137359.56..137593.00 rows=1420 width=113) (actual time=272.449..320.066 rows=4829 loops=1)
                                 ->  Finalize GroupAggregate  (cost=137359.56..137578.80 rows=1420 width=117) (actual time=272.448..319.311 rows=4829 loops=1)
                                       Group Key: ss_ticket_number, ss_customer_sk, ss_addr_sk, ca_city
                                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137359.56..137524.35 rows=1184 width=117) (actual time=272.399..294.915 rows=9503 loops=1)
               ->  Hash  (cost=3682.00..3682.00 rows=72000 width=13) (actual time=60.838..60.838 rows=72000 loops=1)
                     Buckets: 131072  Batches: 1  Memory Usage: 4328kB
                     ->  Remote Subquery Scan on all (dn2)  (cost=100.00..3682.00 rows=72000 width=13) (actual time=0.840..32.071 rows=72000 loops=1)
 Planning time: 0.631 ms
 Execution time: 565.120 ms
(23 rows)

SET
