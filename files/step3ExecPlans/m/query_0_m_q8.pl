                                                                                         QUERY PLAN                                                                                         
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=177060.59..177114.55 rows=10 width=37) (actual time=486.644..486.644 rows=0 loops=1)
   ->  GroupAggregate  (cost=177060.59..177114.55 rows=10 width=37) (actual time=486.643..486.643 rows=0 loops=1)
         Group Key: s_store_name
         ->  Sort  (cost=177060.59..177078.54 rows=7177 width=11) (actual time=486.642..486.642 rows=0 loops=1)
               Sort Key: s_store_name
               Sort Method: quicksort  Memory: 25kB
               ->  Hash Join  (cost=42090.86..176600.94 rows=7177 width=11) (actual time=486.638..486.638 rows=0 loops=1)
                     Hash Cond: (ss_store_sk = s_store_sk)
                     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=218.91..134741.13 rows=7177 width=10) (actual time=3.707..3.707 rows=1 loops=1)
                     ->  Hash  (cost=41971.68..41971.68 rows=22 width=9) (actual time=482.924..482.924 rows=0 loops=1)
                           Buckets: 1024  Batches: 1  Memory Usage: 8kB
                           ->  Hash Join  (cost=9045.37..41971.68 rows=22 width=9) (actual time=482.923..482.923 rows=0 loops=1)
                                 Hash Cond: (substr(a2.ca_zip, 1, 2) = substr((s_zip)::text, 1, 2))
                                 ->  Subquery Scan on a2  (cost=9043.87..41968.47 rows=200 width=32) (actual time=480.678..480.685 rows=5 loops=1)
                                       ->  HashSetOp Intersect  (cost=9043.87..41966.47 rows=200 width=36) (actual time=480.677..480.683 rows=5 loops=1)
                                             ->  Append  (cost=9043.87..41802.68 rows=65514 width=36) (actual time=65.207..480.448 rows=1456 loops=1)
                                                   ->  Subquery Scan on "*SELECT* 2"  (cost=9043.87..9377.61 rows=3209 width=36) (actual time=65.207..65.777 rows=1022 loops=1)
                                                         ->  Remote Subquery Scan on all (dn1)  (cost=9043.87..9345.52 rows=3209 width=32) (actual time=65.198..65.633 rows=1022 loops=1)
                                                   ->  Subquery Scan on "*SELECT* 1"  (cost=200.00..32425.07 rows=62305 width=36) (actual time=414.514..414.611 rows=434 loops=1)
                                                         ->  Remote Subquery Scan on all (dn1)  (cost=200.00..31802.02 rows=62305 width=32) (actual time=414.492..414.534 rows=434 loops=1)
                                 ->  Hash  (cost=101.77..101.77 rows=22 width=20) (actual time=2.232..2.232 rows=22 loops=1)
                                       Buckets: 1024  Batches: 1  Memory Usage: 10kB
                                       ->  Remote Subquery Scan on all (dn1)  (cost=100.00..101.77 rows=22 width=20) (actual time=2.209..2.212 rows=22 loops=1)
 Planning time: 0.598 ms
 Execution time: 490.731 ms
(25 rows)

