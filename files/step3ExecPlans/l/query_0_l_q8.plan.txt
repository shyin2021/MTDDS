                                                                                         QUERY PLAN                                                                                         
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=257912.70..257993.55 rows=10 width=37) (actual time=686.950..686.950 rows=0 loops=1)
   ->  GroupAggregate  (cost=257912.70..257993.55 rows=10 width=37) (actual time=686.948..686.948 rows=0 loops=1)
         Group Key: s_store_name
         ->  Sort  (cost=257912.70..257939.61 rows=10763 width=11) (actual time=686.945..686.945 rows=0 loops=1)
               Sort Key: s_store_name
               Sort Method: quicksort  Memory: 25kB
               ->  Hash Join  (cost=55476.75..257191.91 rows=10763 width=11) (actual time=686.937..686.937 rows=0 loops=1)
                     Hash Cond: (ss_store_sk = s_store_sk)
                     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=218.91..201952.23 rows=10763 width=10) (actual time=3.298..3.298 rows=1 loops=1)
                     ->  Hash  (cost=55357.45..55357.45 rows=32 width=9) (actual time=683.633..683.633 rows=0 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 8kB
                           ->  Hash Join  (cost=11536.71..55357.45 rows=32 width=9) (actual time=683.632..683.632 rows=0 loops=1)
                                 Hash Cond: (substr(a2.ca_zip, 1, 2) = substr((s_zip)::text, 1, 2))
                                 ->  Subquery Scan on a2  (cost=11533.99..55352.91 rows=200 width=32) (actual time=680.903..680.935 rows=5 loops=1)
                                       ->  HashSetOp Intersect  (cost=11533.99..55350.91 rows=200 width=36) (actual time=680.901..680.931 rows=5 loops=1)
                                             ->  Append  (cost=11533.99..55139.47 rows=84575 width=36) (actual time=89.921..679.371 rows=1672 loops=1)
                                                   ->  Subquery Scan on "*SELECT* 2"  (cost=11533.99..11973.68 rows=3233 width=36) (actual time=89.920..93.220 rows=1100 loops=1)
                                                         ->  Remote Subquery Scan on all (dn3)  (cost=11533.99..11941.35 rows=3233 width=32) (actual time=89.899..92.524 rows=1100 loops=1)
                                                   ->  Subquery Scan on "*SELECT* 1"  (cost=200.00..43165.80 rows=81342 width=36) (actual time=528.418..585.861 rows=572 loops=1)
                                                         ->  Remote Subquery Scan on all (dn3)  (cost=200.00..42352.38 rows=81342 width=32) (actual time=528.400..585.590 rows=572 loops=1)
                                 ->  Hash  (cost=103.12..103.12 rows=32 width=20) (actual time=2.681..2.681 rows=31 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 10kB
                                       ->  Remote Subquery Scan on all (dn2)  (cost=100.00..103.12 rows=32 width=20) (actual time=2.652..2.656 rows=32 loops=1)
 Planning time: 1.970 ms
 Execution time: 707.251 ms
(25 rows)

