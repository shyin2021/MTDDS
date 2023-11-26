                                                                         QUERY PLAN                                                                          
-------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=70832.74..70832.99 rows=100 width=152) (actual time=2539.961..2539.969 rows=100 loops=1)
   ->  Sort  (cost=70832.74..70845.55 rows=5125 width=152) (actual time=2539.960..2539.963 rows=100 loops=1)
         Sort Key: customer.c_last_name, customer.c_first_name, (substr((store.s_city)::text, 1, 30)), (sum(store_sales.ss_net_profit))
         Sort Method: top-N heapsort  Memory: 49kB
         ->  Hash Join  (cost=69813.47..70636.87 rows=5125 width=152) (actual time=2477.759..2533.405 rows=15188 loops=1)
               Hash Cond: (store_sales.ss_customer_sk = customer.c_customer_sk)
               ->  Finalize GroupAggregate  (cost=68141.48..68887.36 rows=5125 width=83) (actual time=2288.331..2337.269 rows=16169 loops=1)
                     Group Key: store_sales.ss_ticket_number, store_sales.ss_customer_sk, store_sales.ss_addr_sk, store.s_city
                     ->  Remote Subquery Scan on all (dn0)  (cost=68141.48..68725.08 rows=4270 width=83) (actual time=2288.311..2312.253 rows=16169 loops=1)
               ->  Hash  (cost=3388.64..3388.64 rows=33333 width=56) (actual time=184.586..184.586 rows=100000 loops=1)
                     Buckets: 131072 (originally 65536)  Batches: 1 (originally 1)  Memory Usage: 9448kB
                     ->  Remote Subquery Scan on all (dn0)  (cost=100.00..3388.64 rows=33333 width=56) (actual time=17.332..107.361 rows=100000 loops=1)
 Planning time: 25.041 ms
 Execution time: 2545.886 ms
(14 rows)

