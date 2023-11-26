                                                                               QUERY PLAN                                                                                
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=210217.16..210218.60 rows=578 width=77) (actual time=427.762..427.762 rows=6 loops=1)
   Sort Key: dj.cnt DESC, c_last_name
   Sort Method: quicksort  Memory: 25kB
   ->  Merge Join  (cost=201119.04..210190.64 rows=578 width=77) (actual time=269.143..427.743 rows=6 loops=1)
         Merge Cond: (c_customer_sk = dj.ss_customer_sk)
         ->  Remote Subquery Scan on all (dn1)  (cost=100.17..22605.10 rows=188000 width=69) (actual time=0.391..83.693 rows=183393 loops=1)
         ->  Sort  (cost=201118.87..201120.32 rows=578 width=16) (actual time=267.353..267.355 rows=7 loops=1)
               Sort Key: dj.ss_customer_sk
               Sort Method: quicksort  Memory: 34kB
               ->  Subquery Scan on dj  (cost=201011.91..201092.36 rows=578 width=16) (actual time=257.690..267.262 rows=193 loops=1)
                     ->  Finalize GroupAggregate  (cost=201011.91..201086.58 rows=578 width=16) (actual time=257.689..267.245 rows=193 loops=1)
                           Group Key: ss_ticket_number, ss_customer_sk
                           Filter: ((count(*) >= 1) AND (count(*) <= 5))
                           Rows Removed by Filter: 2937
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=201011.91..201074.77 rows=482 width=16) (actual time=257.642..265.969 rows=8850 loops=1)
 Planning time: 0.421 ms
 Execution time: 432.997 ms
(17 rows)

