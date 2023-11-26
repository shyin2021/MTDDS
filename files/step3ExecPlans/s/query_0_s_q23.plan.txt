                                                                                  QUERY PLAN                                                                                  
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=424510.99..424511.00 rows=1 width=32) (actual time=6871.563..6871.563 rows=1 loops=1)
   CTE frequent_ss_items
     ->  Finalize HashAggregate  (cost=75614.63..76331.89 rows=57381 width=48) (actual time=2972.982..3200.388 rows=43 loops=1)
           Group Key: substr((i_item_desc)::text, 1, 30), i_item_sk, d_date
           Filter: (count(*) > 4)
           Rows Removed by Filter: 1491101
           ->  Remote Subquery Scan on all (dn0)  (cost=69697.15..75016.90 rows=47818 width=48) (actual time=1588.461..1970.654 rows=1491144 loops=1)
   CTE max_store_sales
     ->  Aggregate  (cost=77276.07..77276.08 rows=1 width=32) (actual time=1215.916..1215.916 rows=1 loops=1)
           ->  Finalize HashAggregate  (cost=76442.75..76859.41 rows=33333 width=36) (actual time=1189.001..1211.172 rows=76412 loops=1)
                 Group Key: c_customer_sk
                 ->  Remote Subquery Scan on all (dn0)  (cost=70764.36..76084.11 rows=47818 width=36) (actual time=1113.660..1134.673 rows=76412 loops=1)
   CTE best_ss_customer
     ->  HashAggregate  (cost=194992.23..195492.23 rows=33333 width=36) (actual time=3420.019..3456.081 rows=17 loops=1)
           Group Key: c_customer_sk
           Filter: (sum(((ss_quantity)::numeric * ss_sales_price)) > (0.95000000000000000000 * $4))
           Rows Removed by Filter: 90841
           InitPlan 3 (returns $4)
             ->  CTE Scan on max_store_sales  (cost=0.00..0.02 rows=1 width=32) (actual time=1215.919..1215.920 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn0)  (cost=1771.99..144576.64 rows=2880890 width=14) (actual time=17.788..797.687 rows=2750652 loops=1)
   ->  Aggregate  (cost=75410.78..75410.79 rows=1 width=32) (actual time=6871.562..6871.562 rows=1 loops=1)
         ->  Append  (cost=3883.44..75410.23 rows=221 width=32) (actual time=6871.560..6871.560 rows=0 loops=1)
               ->  Hash Join  (cost=3883.44..48939.70 rows=147 width=32) (actual time=6796.842..6796.842 rows=0 loops=1)
                     Hash Cond: (cs_item_sk = frequent_ss_items.item_sk)
                     ->  Hash Join  (cost=2587.87..47640.97 rows=295 width=14) (actual time=3596.368..3596.368 rows=0 loops=1)
                           Hash Cond: (cs_bill_customer_sk = best_ss_customer.c_customer_sk)
                           ->  Remote Subquery Scan on all (dn0)  (cost=1933.38..46995.25 rows=592 width=18) (actual time=68.204..136.038 rows=14018 loops=1)
                           ->  Hash  (cost=751.99..751.99 rows=200 width=4) (actual time=3456.107..3456.107 rows=17 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                 ->  HashAggregate  (cost=749.99..751.99 rows=200 width=4) (actual time=3456.100..3456.102 rows=17 loops=1)
                                       Group Key: best_ss_customer.c_customer_sk
                                       ->  CTE Scan on best_ss_customer  (cost=0.00..666.66 rows=33333 width=4) (actual time=3420.021..3456.091 rows=17 loops=1)
                     ->  Hash  (cost=1293.07..1293.07 rows=200 width=4) (actual time=3200.468..3200.468 rows=43 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 10kB
                           ->  HashAggregate  (cost=1291.07..1293.07 rows=200 width=4) (actual time=3200.454..3200.459 rows=43 loops=1)
                                 Group Key: frequent_ss_items.item_sk
                                 ->  CTE Scan on frequent_ss_items  (cost=0.00..1147.62 rows=57381 width=4) (actual time=2972.985..3200.429 rows=43 loops=1)
               ->  Hash Join  (cost=3883.44..26468.32 rows=74 width=32) (actual time=74.716..74.716 rows=0 loops=1)
                     Hash Cond: (ws_item_sk = frequent_ss_items_1.item_sk)
                     ->  Hash Join  (cost=2587.87..25171.17 rows=147 width=14) (actual time=74.687..74.687 rows=0 loops=1)
                           Hash Cond: (ws_bill_customer_sk = best_ss_customer_1.c_customer_sk)
                           ->  Remote Subquery Scan on all (dn0)  (cost=1933.38..24521.05 rows=295 width=18) (actual time=10.564..72.613 rows=6668 loops=1)
                           ->  Hash  (cost=751.99..751.99 rows=200 width=4) (actual time=0.010..0.010 rows=17 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                 ->  HashAggregate  (cost=749.99..751.99 rows=200 width=4) (actual time=0.006..0.008 rows=17 loops=1)
                                       Group Key: best_ss_customer_1.c_customer_sk
                                       ->  CTE Scan on best_ss_customer best_ss_customer_1  (cost=0.00..666.66 rows=33333 width=4) (actual time=0.001..0.002 rows=17 loops=1)
                     ->  Hash  (cost=1293.07..1293.07 rows=200 width=4) (actual time=0.022..0.022 rows=43 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 10kB
                           ->  HashAggregate  (cost=1291.07..1293.07 rows=200 width=4) (actual time=0.013..0.018 rows=43 loops=1)
                                 Group Key: frequent_ss_items_1.item_sk
                                 ->  CTE Scan on frequent_ss_items frequent_ss_items_1  (cost=0.00..1147.62 rows=57381 width=4) (actual time=0.001..0.005 rows=43 loops=1)
 Planning time: 3.002 ms
 Execution time: 6901.692 ms
(54 rows)

 c_last_name | c_first_name | sales 
-------------+--------------+-------
(0 rows)

