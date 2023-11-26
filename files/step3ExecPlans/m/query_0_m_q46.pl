                                                                                    QUERY PLAN                                                                                     
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=149238.68..149238.93 rows=100 width=138) (actual time=739.003..739.012 rows=100 loops=1)
   ->  Sort  (cost=149238.68..149253.33 rows=5862 width=138) (actual time=739.002..739.005 rows=100 loops=1)
         Sort Key: c_last_name, c_first_name, ca_city, dn.bought_city, dn.ss_ticket_number
         Sort Method: top-N heapsort  Memory: 48kB
         ->  Hash Join  (cost=141969.38..149014.64 rows=5862 width=138) (actual time=570.921..731.831 rows=19336 loops=1)
               Hash Cond: (c_current_addr_sk = ca_address_sk)
               Join Filter: ((ca_city)::text <> (dn.bought_city)::text)
               Rows Removed by Join Filter: 1320
               ->  Merge Join  (cost=138783.38..145813.22 rows=5872 width=133) (actual time=519.193..671.844 rows=20656 loops=1)
                     Merge Cond: (c_customer_sk = dn.ss_customer_sk)
                     ->  Remote Subquery Scan on all (dn2)  (cost=100.17..16041.94 rows=144000 width=60) (actual time=0.377..93.861 rows=144000 loops=1)
                     ->  Sort  (cost=138783.21..138797.89 rows=5872 width=81) (actual time=518.803..521.418 rows=20657 loops=1)
                           Sort Key: dn.ss_customer_sk
                           Sort Method: quicksort  Memory: 2428kB
                           ->  Subquery Scan on dn  (cost=137502.06..138415.63 rows=5872 width=81) (actual time=396.503..511.180 rows=21321 loops=1)
                                 ->  Finalize GroupAggregate  (cost=137502.06..138356.91 rows=5872 width=85) (actual time=396.501..497.671 rows=21321 loops=1)
                                       Group Key: ss_ticket_number, ss_customer_sk, ss_addr_sk, ca_city
                                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137502.06..138170.95 rows=4894 width=85) (actual time=396.477..456.834 rows=41909 loops=1)
               ->  Hash  (cost=3682.00..3682.00 rows=72000 width=13) (actual time=51.592..51.592 rows=72000 loops=1)
                     Buckets: 131072  Batches: 1  Memory Usage: 4328kB
                     ->  Remote Subquery Scan on all (dn1)  (cost=100.00..3682.00 rows=72000 width=13) (actual time=0.568..32.688 rows=72000 loops=1)
 Planning time: 0.652 ms
 Execution time: 741.820 ms
(23 rows)

