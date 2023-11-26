                                                                                    QUERY PLAN                                                                                     
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=1268795.52..1268795.53 rows=1 width=32) (actual time=17719.301..17719.301 rows=1 loops=1)
   CTE frequent_ss_items
     ->  Finalize HashAggregate  (cost=222954.47..225114.40 rows=172795 width=48) (actual time=7870.499..8791.903 rows=889 loops=1)
           Group Key: substr((i_item_desc)::text, 1, 30), i_item_sk, d_date
           Filter: (count(*) > 4)
           Rows Removed by Filter: 5635464
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=205134.96..221154.52 rows=143996 width=48) (actual time=2287.860..3586.062 rows=5636353 loops=1)
   CTE max_store_sales
     ->  Aggregate  (cost=232539.34..232539.35 rows=1 width=32) (actual time=2270.040..2270.040 rows=1 loops=1)
           ->  Finalize HashAggregate  (cost=228219.47..230379.41 rows=172795 width=36) (actual time=2174.581..2258.688 rows=179219 loops=1)
                 Group Key: c_customer_sk
                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=211119.94..227139.50 rows=143996 width=36) (actual time=1624.939..1746.675 rows=536193 loops=1)
   CTE best_ss_customer
     ->  HashAggregate  (cost=589002.33..591822.33 rows=188000 width=36) (actual time=8564.483..8619.132 rows=8 loops=1)
           Group Key: c_customer_sk
           Filter: (sum(((ss_quantity)::numeric * ss_sales_price)) > (0.95000000000000000000 * $4))
           Rows Removed by Filter: 183940
           InitPlan 3 (returns $4)
             ->  CTE Scan on max_store_sales  (cost=0.00..0.02 rows=1 width=32) (actual time=2270.043..2270.044 rows=1 loops=1)
           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=9533.00..437808.79 rows=8639630 width=14) (actual time=38.849..1427.902 rows=8250571 loops=1)
   ->  Aggregate  (cost=219319.43..219319.44 rows=1 width=32) (actual time=17719.300..17719.300 rows=1 loops=1)
         ->  Append  (cost=8245.04..219317.71 rows=685 width=32) (actual time=17719.297..17719.297 rows=0 loops=1)
               ->  Hash Join  (cost=8245.04..143247.22 rows=456 width=32) (actual time=17595.332..17595.332 rows=0 loops=1)
                     Hash Cond: (cs_item_sk = frequent_ss_items.item_sk)
                     ->  Hash Join  (cost=4352.65..139345.09 rows=912 width=14) (actual time=8802.294..8802.294 rows=0 loops=1)
                           Hash Cond: (cs_bill_customer_sk = best_ss_customer.c_customer_sk)
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=218.16..135237.79 rows=1833 width=18) (actual time=7.513..168.144 rows=42279 loops=1)
                           ->  Hash  (cost=4232.00..4232.00 rows=200 width=4) (actual time=8619.160..8619.160 rows=8 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 9kB
                                 ->  HashAggregate  (cost=4230.00..4232.00 rows=200 width=4) (actual time=8619.155..8619.156 rows=8 loops=1)
                                       Group Key: best_ss_customer.c_customer_sk
                                       ->  CTE Scan on best_ss_customer  (cost=0.00..3760.00 rows=188000 width=4) (actual time=8564.487..8619.145 rows=8 loops=1)
                     ->  Hash  (cost=3889.89..3889.89 rows=200 width=4) (actual time=8793.028..8793.028 rows=874 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 39kB
                           ->  HashAggregate  (cost=3887.89..3889.89 rows=200 width=4) (actual time=8792.878..8792.956 rows=874 loops=1)
                                 Group Key: frequent_ss_items.item_sk
                                 ->  CTE Scan on frequent_ss_items  (cost=0.00..3455.90 rows=172795 width=4) (actual time=7870.503..8792.441 rows=889 loops=1)
               ->  Hash Join  (cost=8245.04..76063.64 rows=229 width=32) (actual time=123.962..123.962 rows=0 loops=1)
                     Hash Cond: (ws_bill_customer_sk = best_ss_customer_1.c_customer_sk)
                     ->  Hash Join  (cost=4010.54..71824.25 rows=458 width=14) (actual time=13.938..123.808 rows=734 loops=1)
                           Hash Cond: (ws_item_sk = frequent_ss_items_1.item_sk)
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=218.16..68045.45 rows=917 width=18) (actual time=13.536..113.532 rows=20780 loops=1)
                           ->  Hash  (cost=3889.89..3889.89 rows=200 width=4) (actual time=0.363..0.363 rows=874 loops=1)
                                 Buckets: 1024  Batches: 1  Memory Usage: 39kB
                                 ->  HashAggregate  (cost=3887.89..3889.89 rows=200 width=4) (actual time=0.233..0.297 rows=874 loops=1)
                                       Group Key: frequent_ss_items_1.item_sk
                                       ->  CTE Scan on frequent_ss_items frequent_ss_items_1  (cost=0.00..3455.90 rows=172795 width=4) (actual time=0.003..0.071 rows=889 loops=1)
                     ->  Hash  (cost=4232.00..4232.00 rows=200 width=4) (actual time=0.010..0.010 rows=8 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                           ->  HashAggregate  (cost=4230.00..4232.00 rows=200 width=4) (actual time=0.006..0.008 rows=8 loops=1)
                                 Group Key: best_ss_customer_1.c_customer_sk
                                 ->  CTE Scan on best_ss_customer best_ss_customer_1  (cost=0.00..3760.00 rows=188000 width=4) (actual time=0.001..0.002 rows=8 loops=1)
 Planning time: 1.094 ms
 Execution time: 17813.563 ms
(54 rows)

 c_last_name | c_first_name | sales 
-------------+--------------+-------
(0 rows)

