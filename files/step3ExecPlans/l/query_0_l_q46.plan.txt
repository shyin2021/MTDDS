                                                                                      QUERY PLAN                                                                                       
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=221103.42..221103.67 rows=100 width=138) (actual time=978.295..978.304 rows=100 loops=1)
   ->  Sort  (cost=221103.42..221125.94 rows=9008 width=138) (actual time=978.294..978.297 rows=100 loops=1)
         Sort Key: c_last_name, c_first_name, ca_city, dn.bought_city, dn.ss_ticket_number
         Sort Method: top-N heapsort  Memory: 49kB
         ->  Hash Join  (cost=211537.18..220759.14 rows=9008 width=138) (actual time=755.070..968.178 rows=27532 loops=1)
               Hash Cond: (c_current_addr_sk = ca_address_sk)
               Join Filter: ((ca_city)::text <> (dn.bought_city)::text)
               Rows Removed by Join Filter: 2112
               ->  Merge Join  (cost=207378.18..216576.46 rows=9023 width=133) (actual time=645.384..846.452 rows=29644 loops=1)
                     Merge Cond: (c_customer_sk = dn.ss_customer_sk)
                     ->  Remote Subquery Scan on all (dn2)  (cost=100.17..20913.10 rows=188000 width=60) (actual time=0.386..123.046 rows=187998 loops=1)
                     ->  Sort  (cost=207378.01..207400.57 rows=9023 width=81) (actual time=644.978..648.881 rows=29645 loops=1)
                           Sort Key: dn.ss_customer_sk
                           Sort Method: quicksort  Memory: 3151kB
                           ->  Subquery Scan on dn  (cost=205381.46..206785.23 rows=9023 width=81) (actual time=418.588..636.145 rows=30621 loops=1)
                                 ->  Finalize GroupAggregate  (cost=205381.46..206695.00 rows=9023 width=85) (actual time=418.587..633.761 rows=30621 loops=1)
                                       Group Key: ss_ticket_number, ss_customer_sk, ss_addr_sk, ca_city
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=205381.46..206409.25 rows=7520 width=85) (actual time=418.570..552.134 rows=88192 loops=1)
               ->  Hash  (cost=4776.00..4776.00 rows=94000 width=13) (actual time=109.587..109.587 rows=94000 loops=1)
                     Buckets: 131072  Batches: 1  Memory Usage: 5338kB
                     ->  Remote Subquery Scan on all (dn3)  (cost=100.00..4776.00 rows=94000 width=13) (actual time=1.540..83.454 rows=94000 loops=1)
 Planning time: 0.609 ms
 Execution time: 986.604 ms
(23 rows)

