                                                                   QUERY PLAN                                                                    
-------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=50057.62..50057.63 rows=1 width=32) (actual time=518.724..518.725 rows=1 loops=1)
   ->  Sort  (cost=50057.62..50057.63 rows=1 width=32) (actual time=518.722..518.722 rows=1 loops=1)
         Sort Key: (sum(web_sales.ws_ext_discount_amt))
         Sort Method: quicksort  Memory: 25kB
         ->  Aggregate  (cost=50057.60..50057.61 rows=1 width=32) (actual time=518.707..518.707 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=4771.56..50057.60 rows=1 width=6) (actual time=502.269..518.634 rows=18 loops=1)
 Planning time: 1.704 ms
 Execution time: 528.569 ms
(8 rows)

