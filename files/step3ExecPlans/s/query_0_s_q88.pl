                                                                                QUERY PLAN                                                                                 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=70000544914.30..70000544914.53 rows=1 width=64) (actual time=2586.474..2586.477 rows=1 loops=1)
   ->  Nested Loop  (cost=60000476799.82..60000476800.02 rows=1 width=56) (actual time=2270.847..2270.849 rows=1 loops=1)
         ->  Nested Loop  (cost=50000408685.41..50000408685.58 rows=1 width=48) (actual time=1942.312..1942.314 rows=1 loops=1)
               ->  Nested Loop  (cost=40000340570.96..40000340571.10 rows=1 width=40) (actual time=1621.141..1621.143 rows=1 loops=1)
                     ->  Nested Loop  (cost=30000272456.93..30000272457.04 rows=1 width=32) (actual time=1305.076..1305.077 rows=1 loops=1)
                           ->  Nested Loop  (cost=20000204342.85..20000204342.93 rows=1 width=24) (actual time=986.223..986.224 rows=1 loops=1)
                                 ->  Nested Loop  (cost=10000136228.51..10000136228.56 rows=1 width=16) (actual time=663.420..663.420 rows=1 loops=1)
                                       ->  Finalize Aggregate  (cost=68114.12..68114.13 rows=1 width=8) (actual time=346.525..346.525 rows=1 loops=1)
                                             ->  Remote Subquery Scan on all (dn0)  (cost=68113.89..68114.11 rows=2 width=8) (actual time=346.515..346.515 rows=1 loops=1)
                                       ->  Finalize Aggregate  (cost=68114.39..68114.40 rows=1 width=8) (actual time=316.878..316.878 rows=1 loops=1)
                                             ->  Remote Subquery Scan on all (dn0)  (cost=68114.17..68114.39 rows=2 width=8) (actual time=316.869..316.870 rows=1 loops=1)
                                 ->  Finalize Aggregate  (cost=68114.34..68114.35 rows=1 width=8) (actual time=322.800..322.800 rows=1 loops=1)
                                       ->  Remote Subquery Scan on all (dn0)  (cost=68114.11..68114.33 rows=2 width=8) (actual time=322.791..322.791 rows=1 loops=1)
                           ->  Finalize Aggregate  (cost=68114.08..68114.09 rows=1 width=8) (actual time=318.850..318.851 rows=1 loops=1)
                                 ->  Remote Subquery Scan on all (dn0)  (cost=68113.86..68114.08 rows=2 width=8) (actual time=318.842..318.843 rows=1 loops=1)
                     ->  Finalize Aggregate  (cost=68114.03..68114.04 rows=1 width=8) (actual time=316.063..316.063 rows=1 loops=1)
                           ->  Remote Subquery Scan on all (dn0)  (cost=68113.80..68114.02 rows=2 width=8) (actual time=316.055..316.055 rows=1 loops=1)
               ->  Finalize Aggregate  (cost=68114.45..68114.46 rows=1 width=8) (actual time=321.169..321.169 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn0)  (cost=68114.23..68114.45 rows=2 width=8) (actual time=321.160..321.160 rows=1 loops=1)
         ->  Finalize Aggregate  (cost=68114.40..68114.41 rows=1 width=8) (actual time=328.532..328.532 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn0)  (cost=68114.18..68114.40 rows=2 width=8) (actual time=328.512..328.513 rows=1 loops=1)
   ->  Finalize Aggregate  (cost=68114.48..68114.49 rows=1 width=8) (actual time=315.624..315.624 rows=1 loops=1)
         ->  Remote Subquery Scan on all (dn0)  (cost=68114.26..68114.48 rows=2 width=8) (actual time=315.615..315.616 rows=1 loops=1)
 Planning time: 3.861 ms
 Execution time: 2589.700 ms
(25 rows)

