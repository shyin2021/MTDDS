                                                                                 QUERY PLAN                                                                                  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=72854.59..72854.84 rows=100 width=138) (actual time=516.597..516.606 rows=100 loops=1)
   ->  Sort  (cost=72854.59..72861.98 rows=2956 width=138) (actual time=516.596..516.599 rows=100 loops=1)
         Sort Key: c_last_name, c_first_name, ca_city, dn.bought_city, dn.ss_ticket_number
         Sort Method: top-N heapsort  Memory: 49kB
         ->  Hash Join  (cost=71082.74..72741.61 rows=2956 width=138) (actual time=449.328..512.995 rows=9808 loops=1)
               Hash Cond: (c_current_addr_sk = ca_address_sk)
               Join Filter: ((ca_city)::text <> (dn.bought_city)::text)
               Rows Removed by Join Filter: 662
               ->  Merge Join  (cost=70345.73..71996.83 rows=2961 width=133) (actual time=424.627..484.765 rows=10470 loops=1)
                     Merge Cond: (c_customer_sk = dn.ss_customer_sk)
                     ->  Remote Subquery Scan on all (dn0)  (cost=100.17..3790.16 rows=33333 width=60) (actual time=0.160..24.219 rows=100000 loops=1)
                     ->  Sort  (cost=70345.57..70352.97 rows=2961 width=81) (actual time=424.446..425.438 rows=10471 loops=1)
                           Sort Key: dn.ss_customer_sk
                           Sort Method: quicksort  Memory: 1228kB
                           ->  Subquery Scan on dn  (cost=69714.14..70174.84 rows=2961 width=81) (actual time=382.638..421.588 rows=10838 loops=1)
                                 ->  Finalize GroupAggregate  (cost=69714.14..70145.23 rows=2961 width=85) (actual time=382.638..420.823 rows=10838 loops=1)
                                       Group Key: ss_ticket_number, ss_customer_sk, ss_addr_sk, ca_city
                                       ->  Remote Subquery Scan on all (dn0)  (cost=69714.14..70051.45 rows=2468 width=85) (actual time=382.613..404.733 rows=10838 loops=1)
               ->  Hash  (cost=928.68..928.68 rows=16667 width=13) (actual time=24.678..24.678 rows=50000 loops=1)
                     Buckets: 65536 (originally 32768)  Batches: 1 (originally 1)  Memory Usage: 2807kB
                     ->  Remote Subquery Scan on all (dn0)  (cost=100.00..928.68 rows=16667 width=13) (actual time=0.312..13.449 rows=50000 loops=1)
 Planning time: 0.564 ms
 Execution time: 517.555 ms
(23 rows)

