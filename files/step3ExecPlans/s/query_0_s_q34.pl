                                                                          QUERY PLAN                                                                           
---------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=70887.25..70888.83 rows=635 width=77) (actual time=387.479..387.490 rows=374 loops=1)
   Sort Key: c_last_name, c_first_name, c_salutation, c_preferred_cust_flag DESC, dn.ss_ticket_number
   Sort Method: quicksort  Memory: 76kB
   ->  Merge Join  (cost=69241.48..70857.69 rows=635 width=77) (actual time=295.354..387.011 rows=374 loops=1)
         Merge Cond: (c_customer_sk = dn.ss_customer_sk)
         ->  Remote Subquery Scan on all (dn0)  (cost=100.17..4090.16 rows=33333 width=69) (actual time=0.546..53.921 rows=99236 loops=1)
         ->  Sort  (cost=69241.31..69242.90 rows=635 width=16) (actual time=294.578..294.616 rows=374 loops=1)
               Sort Key: dn.ss_customer_sk
               Sort Method: quicksort  Memory: 54kB
               ->  Subquery Scan on dn  (cost=69123.30..69211.75 rows=635 width=16) (actual time=288.941..294.514 rows=374 loops=1)
                     ->  Finalize GroupAggregate  (cost=69123.30..69205.40 rows=635 width=16) (actual time=288.940..294.488 rows=374 loops=1)
                           Group Key: ss_ticket_number, ss_customer_sk
                           Filter: ((count(*) >= 15) AND (count(*) <= 20))
                           Rows Removed by Filter: 3513
                           ->  Remote Subquery Scan on all (dn0)  (cost=69123.30..69192.42 rows=530 width=16) (actual time=288.923..293.212 rows=3887 loops=1)
 Planning time: 2.259 ms
 Execution time: 388.328 ms
(17 rows)

SET
