                                                                                   QUERY PLAN                                                                                    
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=211304.71..211304.96 rows=100 width=152) (actual time=744.452..744.461 rows=100 loops=1)
   ->  Sort  (cost=211304.71..211315.59 rows=4352 width=152) (actual time=744.451..744.454 rows=100 loops=1)
         Sort Key: c_last_name, c_first_name, (substr((ms.s_city)::text, 1, 30)), ms.profit
         Sort Method: top-N heapsort  Memory: 48kB
         ->  Merge Join  (cost=201999.29..211138.38 rows=4352 width=152) (actual time=462.182..733.922 rows=14240 loops=1)
               Merge Cond: (c_customer_sk = ms.ss_customer_sk)
               ->  Remote Subquery Scan on all (dn3)  (cost=100.17..20161.10 rows=188000 width=56) (actual time=1.588..158.606 rows=188000 loops=1)
               ->  Sort  (cost=201999.12..202010.00 rows=4352 width=79) (actual time=460.554..463.305 rows=14241 loops=1)
                     Sort Key: ms.ss_customer_sk
                     Sort Method: quicksort  Memory: 1556kB
                     ->  Subquery Scan on ms  (cost=201059.20..201736.10 rows=4352 width=79) (actual time=322.990..455.209 rows=15172 loops=1)
                           ->  Finalize GroupAggregate  (cost=201059.20..201692.58 rows=4352 width=83) (actual time=322.989..453.401 rows=15172 loops=1)
                                 Group Key: ss_ticket_number, ss_customer_sk, ss_addr_sk, s_city
                                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=201059.20..201554.78 rows=3626 width=83) (actual time=322.906..399.510 rows=41925 loops=1)
 Planning time: 0.480 ms
 Execution time: 751.902 ms
(16 rows)

