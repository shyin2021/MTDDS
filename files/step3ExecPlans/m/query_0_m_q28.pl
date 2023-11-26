                                                                                  QUERY PLAN                                                                                  
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=50001100634.59..50001100634.76 rows=1 width=288) (actual time=2676.260..2676.262 rows=1 loops=1)
   ->  Nested Loop  (cost=50001100634.59..50001100634.76 rows=1 width=288) (actual time=2676.258..2676.261 rows=1 loops=1)
         ->  Nested Loop  (cost=40000918415.74..40000918415.88 rows=1 width=240) (actual time=2239.666..2239.668 rows=1 loops=1)
               ->  Nested Loop  (cost=30000733923.60..30000733923.71 rows=1 width=192) (actual time=1781.751..1781.752 rows=1 loops=1)
                     ->  Nested Loop  (cost=20000551215.70..20000551215.78 rows=1 width=144) (actual time=1346.806..1346.807 rows=1 loops=1)
                           ->  Nested Loop  (cost=10000367539.07..10000367539.12 rows=1 width=96) (actual time=914.349..914.349 rows=1 loops=1)
                                 ->  Aggregate  (cost=183485.14..183485.15 rows=1 width=48) (actual time=453.895..453.895 rows=1 loops=1)
                                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=200.00..182986.25 rows=66518 width=6) (actual time=6.666..415.923 rows=72893 loops=1)
                                 ->  Aggregate  (cost=184053.94..184053.95 rows=1 width=48) (actual time=460.451..460.451 rows=1 loops=1)
                                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=200.00..183519.05 rows=71318 width=6) (actual time=5.891..423.824 rows=73242 loops=1)
                           ->  Aggregate  (cost=183676.63..183676.64 rows=1 width=48) (actual time=432.455..432.455 rows=1 loops=1)
                                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=200.00..183165.62 rows=68134 width=6) (actual time=7.661..403.862 rows=58263 loops=1)
                     ->  Aggregate  (cost=182707.89..182707.90 rows=1 width=48) (actual time=434.942..434.942 rows=1 loops=1)
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=200.00..182258.20 rows=59959 width=6) (actual time=7.793..406.932 rows=56651 loops=1)
               ->  Aggregate  (cost=184492.15..184492.16 rows=1 width=48) (actual time=457.913..457.913 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=200.00..183929.53 rows=75016 width=6) (actual time=5.771..415.409 rows=78581 loops=1)
         ->  Aggregate  (cost=182218.84..182218.85 rows=1 width=48) (actual time=436.589..436.589 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=200.00..181800.10 rows=55832 width=6) (actual time=7.325..407.670 rows=59424 loops=1)
 Planning time: 0.692 ms
 Execution time: 2681.537 ms
(20 rows)

