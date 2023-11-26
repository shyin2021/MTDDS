                                                                                   QUERY PLAN                                                                                   
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=214634.81..214634.81 rows=1 width=16) (actual time=1371.057..1371.057 rows=0 loops=1)
   CTE my_customers
     ->  Unique  (cost=123402.13..123402.14 rows=2 width=8) (actual time=1057.614..1057.682 rows=464 loops=1)
           ->  Sort  (cost=123402.13..123402.13 rows=2 width=8) (actual time=1057.613..1057.633 rows=520 loops=1)
                 Sort Key: c_customer_sk, c_current_addr_sk
                 Sort Method: quicksort  Memory: 49kB
                 ->  Hash Join  (cost=3105.57..123402.12 rows=2 width=8) (actual time=212.549..1057.438 rows=520 loops=1)
                       Hash Cond: (cs_bill_customer_sk = c_customer_sk)
                       ->  Hash Join  (cost=1433.58..121730.12 rows=2 width=4) (actual time=164.846..1009.526 rows=521 loops=1)
                             Hash Cond: (cs_item_sk = i_item_sk)
                             ->  Hash Join  (cost=933.38..121227.59 rows=887 width=8) (actual time=112.387..998.628 rows=22529 loops=1)
                                   Hash Cond: (cs_sold_date_sk = d_date_sk)
                                   ->  Append  (cost=100.00..114720.46 rows=2161054 width=12) (actual time=4.681..572.734 rows=2160932 loops=1)
                                         ->  Remote Subquery Scan on all (dn0)  (cost=100.00..76430.09 rows=1441670 width=12) (actual time=4.681..328.217 rows=1441548 loops=1)
                                         ->  Remote Subquery Scan on all (dn0)  (cost=100.00..38290.37 rows=719384 width=12) (actual time=4.780..159.049 rows=719384 loops=1)
                                   ->  Hash  (cost=933.34..933.34 rows=10 width=4) (actual time=11.145..11.145 rows=31 loops=1)
                                         Buckets: 1024  Batches: 1  Memory Usage: 10kB
                                         ->  Remote Subquery Scan on all (dn0)  (cost=100.00..933.34 rows=10 width=4) (actual time=11.132..11.135 rows=31 loops=1)
                             ->  Hash  (cost=600.14..600.14 rows=16 width=4) (actual time=9.344..9.344 rows=451 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 24kB
                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..600.14 rows=16 width=4) (actual time=9.232..9.273 rows=451 loops=1)
                       ->  Hash  (cost=1788.66..1788.66 rows=33333 width=8) (actual time=47.657..47.657 rows=100000 loops=1)
                             Buckets: 131072 (originally 65536)  Batches: 1 (originally 1)  Memory Usage: 4931kB
                             ->  Remote Subquery Scan on all (dn0)  (cost=100.00..1788.66 rows=33333 width=8) (actual time=4.828..27.173 rows=100000 loops=1)
   CTE my_revenue
     ->  GroupAggregate  (cost=91232.57..91232.59 rows=1 width=36) (actual time=1371.051..1371.051 rows=0 loops=1)
           Group Key: my_customers.c_customer_sk
           InitPlan 2 (returns $1)
             ->  Remote Subquery Scan on all (dn0)  (cost=833.44..833.49 rows=10 width=4) (actual time=10.576..10.576 rows=1 loops=1)
           InitPlan 3 (returns $2)
             ->  Remote Subquery Scan on all (dn0)  (cost=833.44..833.49 rows=10 width=4) (actual time=10.341..10.341 rows=1 loops=1)
           ->  Sort  (cost=89565.59..89565.59 rows=1 width=10) (actual time=1371.050..1371.050 rows=0 loops=1)
                 Sort Key: my_customers.c_customer_sk
                 Sort Method: quicksort  Memory: 25kB
                 ->  Hash Join  (cost=1442.31..89565.58 rows=1 width=10) (actual time=1371.048..1371.048 rows=0 loops=1)
                       Hash Cond: (((ca_county)::text = (s_county)::text) AND (ca_state = s_state))
                       ->  Hash Join  (cost=1426.06..89548.69 rows=1 width=27) (actual time=1117.763..1362.982 rows=413 loops=1)
                             Hash Cond: (ss_customer_sk = my_customers.c_customer_sk)
                             ->  Remote Subquery Scan on all (dn0)  (cost=934.77..89219.78 rows=14434 width=10) (actual time=32.106..260.772 rows=76683 loops=1)
                             ->  Hash  (cost=591.26..591.26 rows=2 width=21) (actual time=1083.841..1083.841 rows=464 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 33kB
                                   ->  Hash Join  (cost=0.07..591.26 rows=2 width=21) (actual time=1062.495..1083.756 rows=464 loops=1)
                                         Hash Cond: (ca_address_sk = my_customers.c_current_addr_sk)
                                         ->  Remote Subquery Scan on all (dn0)  (cost=100.00..1062.01 rows=16667 width=21) (actual time=4.678..15.327 rows=50000 loops=1)
                                         ->  Hash  (cost=0.04..0.04 rows=2 width=8) (actual time=1057.765..1057.765 rows=464 loops=1)
                                               Buckets: 1024  Batches: 1  Memory Usage: 27kB
                                               ->  CTE Scan on my_customers  (cost=0.00..0.04 rows=2 width=8) (actual time=1057.616..1057.727 rows=464 loops=1)
                       ->  Hash  (cost=119.00..119.00 rows=250 width=21) (actual time=8.011..8.011 rows=12 loops=1)
                             Buckets: 1024  Batches: 1  Memory Usage: 9kB
                             ->  Remote Subquery Scan on all (dn0)  (cost=100.00..119.00 rows=250 width=21) (actual time=8.001..8.003 rows=12 loops=1)
   CTE segments
     ->  CTE Scan on my_revenue  (cost=0.00..0.03 rows=1 width=4) (actual time=1371.052..1371.052 rows=0 loops=1)
   ->  Sort  (cost=0.05..0.05 rows=1 width=16) (actual time=1371.056..1371.056 rows=0 loops=1)
         Sort Key: segments.segment, (count(*))
         Sort Method: quicksort  Memory: 25kB
         ->  HashAggregate  (cost=0.02..0.04 rows=1 width=16) (actual time=1371.053..1371.053 rows=0 loops=1)
               Group Key: segments.segment
               ->  CTE Scan on segments  (cost=0.00..0.02 rows=1 width=4) (actual time=1371.052..1371.052 rows=0 loops=1)
 Planning time: 0.743 ms
 Execution time: 1377.184 ms
(60 rows)

