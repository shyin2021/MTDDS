                                                                                     QUERY PLAN                                                                                      
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=81733.82..81751.01 rows=100 width=37) (actual time=628.644..628.644 rows=0 loops=1)
   ->  GroupAggregate  (cost=81733.82..81762.53 rows=167 width=37) (actual time=628.644..628.644 rows=0 loops=1)
         Group Key: s_store_name
         ->  Sort  (cost=81733.82..81742.70 rows=3549 width=11) (actual time=628.643..628.643 rows=0 loops=1)
               Sort Key: s_store_name
               Sort Method: quicksort  Memory: 25kB
               ->  Hash Join  (cost=13915.24..81524.55 rows=3549 width=11) (actual time=628.640..628.640 rows=0 loops=1)
                     Hash Cond: (substr((s_zip)::text, 1, 2) = substr(a2.ca_zip, 1, 2))
                     ->  Remote Subquery Scan on all (dn0)  (cost=1949.25..69255.13 rows=3549 width=22) (actual time=7.728..269.573 rows=77230 loops=1)
                     ->  Hash  (cost=12063.49..12063.49 rows=200 width=32) (actual time=321.183..321.183 rows=5 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                           ->  Subquery Scan on a2  (cost=2296.42..12063.49 rows=200 width=32) (actual time=321.171..321.179 rows=5 loops=1)
                                 ->  HashSetOp Intersect  (cost=2296.42..12061.49 rows=200 width=36) (actual time=321.170..321.177 rows=5 loops=1)
                                       ->  Append  (cost=2296.42..12017.50 rows=17596 width=36) (actual time=37.554..320.991 rows=1262 loops=1)
                                             ->  Subquery Scan on "*SELECT* 2"  (cost=2296.42..2524.88 rows=3173 width=36) (actual time=37.554..38.013 rows=962 loops=1)
                                                   ->  Remote Subquery Scan on all (dn0)  (cost=2296.42..2493.15 rows=3173 width=32) (actual time=37.548..37.886 rows=962 loops=1)
                                             ->  Subquery Scan on "*SELECT* 1"  (cost=100.00..9492.62 rows=14423 width=36) (actual time=282.858..282.923 rows=300 loops=1)
                                                   ->  Remote Subquery Scan on all (dn0)  (cost=100.00..9348.39 rows=14423 width=32) (actual time=282.848..282.876 rows=300 loops=1)
 Planning time: 0.540 ms
 Execution time: 629.528 ms
(20 rows)

