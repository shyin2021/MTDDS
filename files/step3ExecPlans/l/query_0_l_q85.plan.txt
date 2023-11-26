                                                                          QUERY PLAN                                                                           
---------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=202090.66..202090.66 rows=1 width=229) (actual time=762.792..762.793 rows=6 loops=1)
   ->  Sort  (cost=202090.66..202090.66 rows=1 width=229) (actual time=762.792..762.792 rows=6 loops=1)
         Sort Key: (substr((reason.r_reason_desc)::text, 1, 20)), (avg(web_sales.ws_quantity)), (avg(web_returns.wr_refunded_cash)), (avg(web_returns.wr_fee))
         Sort Method: quicksort  Memory: 26kB
         ->  GroupAggregate  (cost=202090.60..202090.65 rows=1 width=229) (actual time=762.770..762.784 rows=6 loops=1)
               Group Key: reason.r_reason_desc
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=202090.60..202090.61 rows=1 width=117) (actual time=762.757..762.762 rows=6 loops=1)
 Planning time: 13.466 ms
 Execution time: 772.634 ms
(9 rows)

