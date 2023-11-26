                                                                              QUERY PLAN                                                                               
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=141530.90..141534.06 rows=1264 width=77) (actual time=439.622..439.649 rows=751 loops=1)
   Sort Key: c_last_name, c_first_name, c_salutation, c_preferred_cust_flag DESC, dn.ss_ticket_number
   Sort Method: quicksort  Memory: 129kB
   ->  Merge Join  (cost=134505.05..141465.78 rows=1264 width=77) (actual time=305.169..438.488 rows=751 loops=1)
         Merge Cond: (c_customer_sk = dn.ss_customer_sk)
         ->  Remote Subquery Scan on all (dn2)  (cost=100.17..17337.94 rows=144000 width=69) (actual time=1.136..72.647 rows=143948 loops=1)
         ->  Sort  (cost=134504.88..134508.04 rows=1264 width=16) (actual time=304.001..304.122 rows=751 loops=1)
               Sort Key: dn.ss_customer_sk
               Sort Method: quicksort  Memory: 83kB
               ->  Subquery Scan on dn  (cost=134263.84..134439.76 rows=1264 width=16) (actual time=287.398..303.852 rows=751 loops=1)
                     ->  Finalize GroupAggregate  (cost=134263.84..134427.12 rows=1264 width=16) (actual time=287.398..303.797 rows=751 loops=1)
                           Group Key: ss_ticket_number, ss_customer_sk
                           Filter: ((count(*) >= 15) AND (count(*) <= 20))
                           Rows Removed by Filter: 7259
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=134263.84..134401.30 rows=1054 width=16) (actual time=287.362..301.363 rows=15494 loops=1)
 Planning time: 0.424 ms
 Execution time: 441.982 ms
(17 rows)

