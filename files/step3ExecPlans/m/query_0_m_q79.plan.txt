                                                                                  QUERY PLAN                                                                                   
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=142555.20..142555.45 rows=100 width=152) (actual time=7562.555..7562.565 rows=100 loops=1)
   ->  Sort  (cost=142555.20..142567.42 rows=4890 width=152) (actual time=7562.554..7562.557 rows=100 loops=1)
         Sort Key: c_last_name, c_first_name, (substr((ms.s_city)::text, 1, 30)), ms.profit
         Sort Method: top-N heapsort  Memory: 49kB
         ->  Merge Join  (cost=135340.96..142368.31 rows=4890 width=152) (actual time=7397.928..7556.626 rows=15557 loops=1)
               Merge Cond: (c_customer_sk = ms.ss_customer_sk)
               ->  Remote Subquery Scan on all (dn1)  (cost=100.17..15465.94 rows=144000 width=56) (actual time=13.233..117.085 rows=144000 loops=1)
               ->  Sort  (cost=135340.79..135353.02 rows=4890 width=79) (actual time=7384.673..7386.701 rows=15558 loops=1)
                     Sort Key: ms.ss_customer_sk
                     Sort Method: quicksort  Memory: 2046kB
                     ->  Subquery Scan on ms  (cost=134280.29..135041.14 rows=4890 width=79) (actual time=7298.732..7379.358 rows=16539 loops=1)
                           ->  Finalize GroupAggregate  (cost=134280.29..134992.24 rows=4890 width=83) (actual time=7298.730..7378.051 rows=16539 loops=1)
                                 Group Key: ss_ticket_number, ss_customer_sk, ss_addr_sk, s_city
                                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=134280.29..134837.37 rows=4076 width=83) (actual time=7298.699..7344.529 rows=31544 loops=1)
 Planning time: 1.786 ms
 Execution time: 7569.687 ms
(16 rows)

