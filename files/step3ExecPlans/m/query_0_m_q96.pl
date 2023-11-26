                                                                    QUERY PLAN                                                                     
---------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=136910.48..136910.48 rows=1 width=8) (actual time=278.101..278.101 rows=1 loops=1)
   ->  Sort  (cost=136910.48..136910.48 rows=1 width=8) (actual time=278.100..278.100 rows=1 loops=1)
         Sort Key: (count(*))
         Sort Method: quicksort  Memory: 25kB
         ->  Finalize Aggregate  (cost=136910.46..136910.47 rows=1 width=8) (actual time=278.095..278.095 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=136910.23..136910.45 rows=2 width=8) (actual time=266.975..278.080 rows=2 loops=1)
 Planning time: 0.297 ms
 Execution time: 280.756 ms
(8 rows)

