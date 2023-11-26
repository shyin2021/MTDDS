                                                                                     QUERY PLAN                                                                                      
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=428644.27..428644.27 rows=1 width=16) (actual time=2346.260..2346.260 rows=0 loops=1)
   CTE my_customers
     ->  Unique  (cost=249795.63..249795.67 rows=5 width=8) (actual time=1934.497..1934.635 rows=899 loops=1)
           ->  Sort  (cost=249795.63..249795.64 rows=5 width=8) (actual time=1934.496..1934.534 rows=1046 loops=1)
                 Sort Key: c_customer_sk, c_current_addr_sk
                 Sort Method: quicksort  Memory: 98kB
                 ->  Hash Join  (cost=9457.10..249795.57 rows=5 width=8) (actual time=647.414..1934.134 rows=1046 loops=1)
                       Hash Cond: (cs_bill_customer_sk = c_customer_sk)
                       ->  Hash Join  (cost=2231.10..242569.56 rows=5 width=4) (actual time=548.191..1834.460 rows=1049 loops=1)
                             Hash Cond: (cs_item_sk = i_item_sk)
                             ->  Hash Join  (cost=118.16..240451.80 rows=1833 width=8) (actual time=439.764..1818.867 rows=42833 loops=1)
                                   Hash Cond: (cs_sold_date_sk = d_date_sk)
                                   ->  Append  (cost=100.00..229094.94 rows=4319257 width=12) (actual time=7.300..918.538 rows=4319305 loops=1)
                                         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=100.00..152592.27 rows=2880010 width=12) (actual time=7.300..496.310 rows=2880058 loops=1)
                                         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=100.00..76502.67 rows=1439247 width=12) (actual time=5.703..239.502 rows=1439247 loops=1)
                                   ->  Hash  (cost=118.05..118.05 rows=31 width=4) (actual time=5.478..5.478 rows=31 loops=1)
                                         Buckets: 1024  Batches: 1  Memory Usage: 10kB
                                         ->  Remote Subquery Scan on all (dn1)  (cost=100.17..118.05 rows=31 width=4) (actual time=5.462..5.466 rows=31 loops=1)
                             ->  Hash  (cost=2212.71..2212.71 rows=67 width=4) (actual time=11.746..11.746 rows=665 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 32kB
                                   ->  Remote Subquery Scan on all (dn1)  (cost=200.00..2212.71 rows=67 width=4) (actual time=10.285..11.630 rows=665 loops=1)
                       ->  Hash  (cost=7398.00..7398.00 rows=144000 width=8) (actual time=99.024..99.024 rows=144000 loops=1)
                             Buckets: 262144  Batches: 1  Memory Usage: 7673kB
                             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..7398.00 rows=144000 width=8) (actual time=5.497..63.632 rows=144000 loops=1)
   CTE my_revenue
     ->  GroupAggregate  (cost=178848.50..178848.52 rows=1 width=36) (actual time=2346.235..2346.235 rows=0 loops=1)
           Group Key: my_customers.c_customer_sk
           InitPlan 2 (returns $2)
             ->  Remote Subquery Scan on all (dn1)  (cost=17.92..18.31 rows=31 width=4) (actual time=5.406..5.406 rows=1 loops=1)
           InitPlan 3 (returns $3)
             ->  Remote Subquery Scan on all (dn1)  (cost=17.92..18.31 rows=31 width=4) (actual time=5.308..5.308 rows=1 loops=1)
           ->  Sort  (cost=178811.88..178811.89 rows=1 width=10) (actual time=2346.234..2346.234 rows=0 loops=1)
                 Sort Key: my_customers.c_customer_sk
                 Sort Method: quicksort  Memory: 25kB
                 ->  Hash Join  (cost=2580.15..178811.87 rows=1 width=10) (actual time=2346.232..2346.232 rows=0 loops=1)
                       Hash Cond: (((ca_county)::text = (s_county)::text) AND (ca_state = s_state))
                       ->  Hash Join  (cost=2578.61..178810.25 rows=1 width=27) (actual time=2005.784..2335.836 rows=1254 loops=1)
                             Hash Cond: (ss_customer_sk = my_customers.c_customer_sk)
                             ->  Remote Subquery Scan on all (dn1,dn2)  (cost=122.33..176677.80 rows=28785 width=10) (actual time=16.873..288.268 rows=225133 loops=1)
                             ->  Hash  (cost=2556.21..2556.21 rows=5 width=21) (actual time=1988.830..1988.830 rows=899 loops=1)
                                   Buckets: 1024  Batches: 1  Memory Usage: 55kB
                                   ->  Hash Join  (cost=0.16..2556.21 rows=5 width=21) (actual time=1940.669..1988.624 rows=899 loops=1)
                                         Hash Cond: (ca_address_sk = my_customers.c_current_addr_sk)
                                         ->  Remote Subquery Scan on all (dn1)  (cost=100.00..4258.00 rows=72000 width=21) (actual time=5.847..36.433 rows=72000 loops=1)
                                         ->  Hash  (cost=0.10..0.10 rows=5 width=8) (actual time=1934.796..1934.796 rows=899 loops=1)
                                               Buckets: 1024  Batches: 1  Memory Usage: 44kB
                                               ->  CTE Scan on my_customers  (cost=0.00..0.10 rows=5 width=8) (actual time=1934.500..1934.723 rows=899 loops=1)
                       ->  Hash  (cost=101.79..101.79 rows=22 width=21) (actual time=10.203..10.203 rows=22 loops=1)
                             Buckets: 1024  Batches: 1  Memory Usage: 10kB
                             ->  Remote Subquery Scan on all (dn1)  (cost=100.00..101.79 rows=22 width=21) (actual time=10.185..10.188 rows=22 loops=1)
   CTE segments
     ->  CTE Scan on my_revenue  (cost=0.00..0.03 rows=1 width=4) (actual time=2346.235..2346.235 rows=0 loops=1)
   ->  Sort  (cost=0.05..0.05 rows=1 width=16) (actual time=2346.259..2346.259 rows=0 loops=1)
         Sort Key: segments.segment, (count(*))
         Sort Method: quicksort  Memory: 25kB
         ->  HashAggregate  (cost=0.02..0.04 rows=1 width=16) (actual time=2346.237..2346.237 rows=0 loops=1)
               Group Key: segments.segment
               ->  CTE Scan on segments  (cost=0.00..0.02 rows=1 width=4) (actual time=2346.236..2346.236 rows=0 loops=1)
 Planning time: 0.919 ms
 Execution time: 2356.338 ms
(60 rows)

