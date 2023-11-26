                                                                                 QUERY PLAN                                                                                 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=72240.48..72240.73 rows=100 width=170) (actual time=364.895..364.904 rows=100 loops=1)
   ->  Sort  (cost=72240.48..72242.25 rows=709 width=170) (actual time=364.894..364.897 rows=100 loops=1)
         Sort Key: c_last_name, dn.ss_ticket_number
         Sort Method: top-N heapsort  Memory: 49kB
         ->  Hash Join  (cost=70594.18..72213.38 rows=709 width=170) (actual time=300.775..363.464 rows=2105 loops=1)
               Hash Cond: (c_current_addr_sk = ca_address_sk)
               Join Filter: ((ca_city)::text <> (dn.bought_city)::text)
               Rows Removed by Join Filter: 144
               ->  Merge Join  (cost=69857.18..71474.51 rows=710 width=165) (actual time=275.560..337.250 rows=2249 loops=1)
                     Merge Cond: (c_customer_sk = dn.ss_customer_sk)
                     ->  Remote Subquery Scan on all (dn0)  (cost=100.17..3790.16 rows=33333 width=60) (actual time=0.164..28.434 rows=100000 loops=1)
                     ->  Sort  (cost=69857.01..69858.79 rows=710 width=113) (actual time=275.369..275.528 rows=2250 loops=1)
                           Sort Key: dn.ss_customer_sk
                           Sort Method: quicksort  Memory: 289kB
                           ->  Subquery Scan on dn  (cost=69706.67..69823.39 rows=710 width=113) (actual time=264.368..274.571 rows=2320 loops=1)
                                 ->  Finalize GroupAggregate  (cost=69706.67..69816.29 rows=710 width=117) (actual time=264.367..274.402 rows=2320 loops=1)
                                       Group Key: ss_ticket_number, ss_customer_sk, ss_addr_sk, ca_city
                                       ->  Remote Subquery Scan on all (dn0)  (cost=69706.67..69789.06 rows=592 width=117) (actual time=264.340..269.723 rows=2320 loops=1)
               ->  Hash  (cost=928.68..928.68 rows=16667 width=13) (actual time=25.190..25.190 rows=50000 loops=1)
                     Buckets: 65536 (originally 32768)  Batches: 1 (originally 1)  Memory Usage: 2807kB
                     ->  Remote Subquery Scan on all (dn0)  (cost=100.00..928.68 rows=16667 width=13) (actual time=0.355..13.878 rows=50000 loops=1)
 Planning time: 0.541 ms
 Execution time: 365.931 ms
(23 rows)

SET
