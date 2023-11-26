                                                                     QUERY PLAN                                                                      
-----------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=73537.01..73537.01 rows=1 width=32) (actual time=791.763..791.764 rows=1 loops=1)
   ->  Sort  (cost=73537.01..73537.01 rows=1 width=32) (actual time=791.762..791.762 rows=1 loops=1)
         Sort Key: (sum(web_sales.ws_ext_discount_amt))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=73536.99..73537.00 rows=1 width=32) (actual time=791.753..791.753 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=5528.14..73536.98 rows=1 width=6) (actual time=700.409..791.715 rows=33 loops=1)
 Planning time: 1.428 ms
 Execution time: 804.160 ms
(8 rows)

