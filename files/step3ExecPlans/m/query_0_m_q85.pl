                                                                          QUERY PLAN                                                                           
---------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=167268.00..167268.01 rows=1 width=229) (actual time=786.594..786.595 rows=4 loops=1)
   ->  Sort  (cost=167268.00..167268.01 rows=1 width=229) (actual time=786.593..786.594 rows=4 loops=1)
         Sort Key: (substr((reason.r_reason_desc)::text, 1, 20)), (avg(web_sales.ws_quantity)), (avg(web_returns.wr_refunded_cash)), (avg(web_returns.wr_fee))
         Sort Method: quicksort  Memory: 26kB
         ->  GroupAggregate  (cost=167267.95..167267.99 rows=1 width=229) (actual time=786.579..786.586 rows=4 loops=1)
               Group Key: reason.r_reason_desc
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=167267.95..167267.96 rows=1 width=117) (actual time=786.567..786.569 rows=4 loops=1)
 Planning time: 4.933 ms
 Execution time: 789.888 ms
(9 rows)

