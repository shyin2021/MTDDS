                                                                                             QUERY PLAN                                                                                             
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=300596.84..300596.85 rows=1 width=8) (actual time=5853.503..5853.503 rows=1 loops=1)
   ->  Subquery Scan on cool_cust  (cost=145452.02..300534.94 rows=24763 width=0) (actual time=5837.178..5849.022 rows=94736 loops=1)
         ->  HashSetOp Except  (cost=145452.02..300287.31 rows=24763 width=216) (actual time=5837.177..5841.338 rows=94736 loops=1)
               ->  Append  (cost=145452.02..300055.18 rows=30950 width=216) (actual time=5055.129..5805.360 rows=118526 loops=1)
                     ->  Result  (cost=145452.02..246326.71 rows=24763 width=216) (actual time=5055.128..5075.052 rows=94862 loops=1)
                           ->  HashSetOp Except  (cost=145452.02..246079.08 rows=24763 width=216) (actual time=5055.128..5066.979 rows=94862 loops=1)
                                 ->  Append  (cost=145452.02..245800.51 rows=37143 width=216) (actual time=1920.210..4980.564 rows=158206 loops=1)
                                       ->  Subquery Scan on "*SELECT* 1"  (cost=145452.02..146071.09 rows=24763 width=60) (actual time=1920.209..3513.861 rows=95458 loops=1)
                                             ->  Unique  (cost=145452.02..145823.46 rows=24763 width=56) (actual time=1920.208..3498.200 rows=95458 loops=1)
                                                   ->  Remote Subquery Scan on all (dn1,dn2)  (cost=145452.02..145637.74 rows=24763 width=56) (actual time=1920.207..3296.833 rows=1085614 loops=1)
                                       ->  Subquery Scan on "*SELECT* 2"  (cost=99419.92..99729.42 rows=12380 width=60) (actual time=757.901..1453.617 rows=62748 loops=1)
                                             ->  Unique  (cost=99419.92..99605.62 rows=12380 width=56) (actual time=757.899..1446.161 rows=62748 loops=1)
                                                   ->  Remote Subquery Scan on all (dn1,dn2)  (cost=99419.92..99512.77 rows=12380 width=56) (actual time=757.898..1361.557 rows=568975 loops=1)
                     ->  Subquery Scan on "*SELECT* 3"  (cost=53573.79..53728.47 rows=6187 width=60) (actual time=374.087..724.704 rows=23664 loops=1)
                           ->  Unique  (cost=53573.79..53666.60 rows=6187 width=56) (actual time=374.085..722.117 rows=23664 loops=1)
                                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=53573.79..53620.20 rows=6187 width=56) (actual time=374.084..679.560 rows=285731 loops=1)
 Planning time: 0.710 ms
 Execution time: 5857.740 ms
(18 rows)

