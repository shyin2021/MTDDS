                                                                    QUERY PLAN                                                                     
---------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=10000047538.81..10000047538.81 rows=1 width=32) (actual time=194.355..194.355 rows=1 loops=1)
   ->  Sort  (cost=10000047538.81..10000047538.81 rows=1 width=32) (actual time=194.354..194.354 rows=1 loops=1)
         Sort Key: ((((count(*)))::numeric(15,4) / ((count(*)))::numeric(15,4)))
         Sort Method: quicksort  Memory: 25kB
         ->  Nested Loop  (cost=10000047538.74..10000047538.80 rows=1 width=32) (actual time=194.349..194.349 rows=1 loops=1)
               ->  Finalize Aggregate  (cost=23769.81..23769.82 rows=1 width=8) (actual time=102.766..102.766 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn0)  (cost=23769.59..23769.81 rows=2 width=8) (actual time=102.757..102.757 rows=1 loops=1)
               ->  Finalize Aggregate  (cost=23768.92..23768.93 rows=1 width=8) (actual time=91.577..91.577 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn0)  (cost=23768.70..23768.92 rows=2 width=8) (actual time=91.568..91.568 rows=1 loops=1)
 Planning time: 1.740 ms
 Execution time: 195.315 ms
(11 rows)

