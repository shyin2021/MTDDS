                                                                                       QUERY PLAN                                                                                       
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=218941.11..218941.36 rows=100 width=170) (actual time=710.377..710.387 rows=100 loops=1)
   ->  Sort  (cost=218941.11..218946.26 rows=2059 width=170) (actual time=710.376..710.379 rows=100 loops=1)
         Sort Key: c_last_name, dn.ss_ticket_number
         Sort Method: top-N heapsort  Memory: 47kB
         ->  Hash Join  (cost=209763.14..218862.41 rows=2059 width=170) (actual time=494.434..703.935 rows=6020 loops=1)
               Hash Cond: (c_current_addr_sk = ca_address_sk)
               Join Filter: ((ca_city)::text <> (dn.bought_city)::text)
               Rows Removed by Join Filter: 455
               ->  Merge Join  (cost=205604.14..214698.00 rows=2062 width=165) (actual time=413.821..617.877 rows=6475 loops=1)
                     Merge Cond: (c_customer_sk = dn.ss_customer_sk)
                     ->  Remote Subquery Scan on all (dn2)  (cost=100.17..20913.10 rows=188000 width=60) (actual time=0.381..102.967 rows=187987 loops=1)
                     ->  Sort  (cost=205603.97..205609.13 rows=2062 width=113) (actual time=413.401..414.980 rows=6476 loops=1)
                           Sort Key: dn.ss_customer_sk
                           Sort Method: quicksort  Memory: 749kB
                           ->  Subquery Scan on dn  (cost=205151.70..205490.46 rows=2062 width=113) (actual time=325.969..410.818 rows=6685 loops=1)
                                 ->  Finalize GroupAggregate  (cost=205151.70..205469.84 rows=2062 width=117) (actual time=325.967..410.087 rows=6685 loops=1)
                                       Group Key: ss_ticket_number, ss_customer_sk, ss_addr_sk, ca_city
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=205151.70..205390.80 rows=1718 width=117) (actual time=325.876..372.707 rows=19251 loops=1)
               ->  Hash  (cost=4776.00..4776.00 rows=94000 width=13) (actual time=80.382..80.382 rows=94000 loops=1)
                     Buckets: 131072  Batches: 1  Memory Usage: 5338kB
                     ->  Remote Subquery Scan on all (dn2)  (cost=100.00..4776.00 rows=94000 width=13) (actual time=0.471..44.650 rows=94000 loops=1)
 Planning time: 0.601 ms
 Execution time: 717.855 ms
(23 rows)

SET
