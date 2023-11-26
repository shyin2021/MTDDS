                                                                                    QUERY PLAN                                                                                     
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=849471.61..849471.62 rows=1 width=32) (actual time=12447.306..12447.306 rows=1 loops=1)
   CTE frequent_ss_items
     ->  Finalize HashAggregate  (cost=148948.38..150388.62 rows=115219 width=48) (actual time=5707.266..6361.033 rows=509 loops=1)
           Group Key: substr((i_item_desc)::text, 1, 30), i_item_sk, d_date
           Filter: (count(*) > 4)
           Rows Removed by Filter: 3804411
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137066.40..147748.18 rows=96016 width=48) (actual time=2281.261..2912.952 rows=3804920 loops=1)
   CTE max_store_sales
     ->  Aggregate  (cost=156093.74..156093.75 rows=1 width=32) (actual time=1848.389..1848.389 rows=1 loops=1)
           ->  Finalize HashAggregate  (cost=153213.26..154653.50 rows=115219 width=36) (actual time=1785.200..1839.888 rows=133881 loops=1)
                 Group Key: c_customer_sk
                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=141811.36..152493.14 rows=96016 width=36) (actual time=1476.910..1554.757 rows=267670 loops=1)
   CTE best_ss_customer
     ->  HashAggregate  (cost=393720.69..395880.69 rows=144000 width=36) (actual time=5796.737..5852.636 rows=31 loops=1)
           Group Key: c_customer_sk
           Filter: (sum(((ss_quantity)::numeric * ss_sales_price)) > (0.95000000000000000000 * $4))
           Rows Removed by Filter: 138780
           InitPlan 3 (returns $4)
             ->  CTE Scan on max_store_sales  (cost=0.00..0.02 rows=1 width=32) (actual time=1848.393..1848.393 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=7326.00..292905.62 rows=5760860 width=14) (actual time=31.268..906.741 rows=5501511 loops=1)
   ->  Aggregate  (cost=147108.55..147108.56 rows=1 width=32) (actual time=12447.305..12447.305 rows=1 loops=1)
         ->  Append  (cost=5959.55..147107.52 rows=413 width=32) (actual time=12391.771..12447.297 rows=3 loops=1)
               ->  Hash Join  (cost=5959.55..95967.05 rows=275 width=32) (actual time=12362.703..12362.703 rows=0 loops=1)
                     Hash Cond: (cs_item_sk = frequent_ss_items.item_sk)
                     ->  Hash Join  (cost=3362.62..93364.25 rows=549 width=14) (actual time=6000.994..6000.994 rows=0 loops=1)
                           Hash Cond: (cs_bill_customer_sk = best_ss_customer.c_customer_sk)
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=218.12..90236.14 rows=1104 width=18) (actual time=6.229..138.886 rows=25451 loops=1)
                           ->  Hash  (cost=3242.00..3242.00 rows=200 width=4) (actual time=5852.680..5852.680 rows=31 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 10kB
                                 ->  HashAggregate  (cost=3240.00..3242.00 rows=200 width=4) (actual time=5852.670..5852.674 rows=31 loops=1)
                                       Group Key: best_ss_customer.c_customer_sk
                                       ->  CTE Scan on best_ss_customer  (cost=0.00..2880.00 rows=144000 width=4) (actual time=5796.739..5852.655 rows=31 loops=1)
                     ->  Hash  (cost=2594.43..2594.43 rows=200 width=4) (actual time=6361.704..6361.704 rows=504 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 26kB
                           ->  HashAggregate  (cost=2592.43..2594.43 rows=200 width=4) (actual time=6361.612..6361.661 rows=504 loops=1)
                                 Group Key: frequent_ss_items.item_sk
                                 ->  CTE Scan on frequent_ss_items  (cost=0.00..2304.38 rows=115219 width=4) (actual time=5707.269..6361.362 rows=509 loops=1)
               ->  Hash Join  (cost=5959.55..51136.34 rows=138 width=32) (actual time=29.067..84.592 rows=3 loops=1)
                     Hash Cond: (ws_bill_customer_sk = best_ss_customer_1.c_customer_sk)
                     ->  Hash Join  (cost=2715.05..47888.89 rows=276 width=14) (actual time=7.791..84.510 rows=383 loops=1)
                           Hash Cond: (ws_item_sk = frequent_ss_items_1.item_sk)
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=218.12..45400.14 rows=552 width=18) (actual time=7.535..78.904 rows=13095 loops=1)
                           ->  Hash  (cost=2594.43..2594.43 rows=200 width=4) (actual time=0.209..0.209 rows=504 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 26kB
                                 ->  HashAggregate  (cost=2592.43..2594.43 rows=200 width=4) (actual time=0.127..0.169 rows=504 loops=1)
                                       Group Key: frequent_ss_items_1.item_sk
                                       ->  CTE Scan on frequent_ss_items frequent_ss_items_1  (cost=0.00..2304.38 rows=115219 width=4) (actual time=0.002..0.042 rows=509 loops=1)
                     ->  Hash  (cost=3242.00..3242.00 rows=200 width=4) (actual time=0.016..0.016 rows=31 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 10kB
                           ->  HashAggregate  (cost=3240.00..3242.00 rows=200 width=4) (actual time=0.010..0.013 rows=31 loops=1)
                                 Group Key: best_ss_customer_1.c_customer_sk
                                 ->  CTE Scan on best_ss_customer best_ss_customer_1  (cost=0.00..2880.00 rows=144000 width=4) (actual time=0.001..0.003 rows=31 loops=1)
 Planning time: 1.054 ms
 Execution time: 12497.841 ms
(54 rows)

          c_last_name           |     c_first_name     |  sales  
--------------------------------+----------------------+---------
 Chamberlain                    | Richard              | 3825.11
 Mcdonald                       | Bradley              | 6905.25
(2 rows)

