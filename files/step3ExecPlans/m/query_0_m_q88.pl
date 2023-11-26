                                                                                   QUERY PLAN                                                                                    
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=70001096225.98..70001096226.21 rows=1 width=64) (actual time=2353.727..2353.730 rows=1 loops=1)
   ->  Nested Loop  (cost=60000959202.08..60000959202.28 rows=1 width=56) (actual time=2046.244..2046.246 rows=1 loops=1)
         ->  Nested Loop  (cost=50000822173.96..50000822174.13 rows=1 width=48) (actual time=1767.550..1767.552 rows=1 loops=1)
               ->  Nested Loop  (cost=40000685146.97..40000685147.11 rows=1 width=40) (actual time=1486.731..1486.732 rows=1 loops=1)
                     ->  Nested Loop  (cost=30000548121.02..30000548121.13 rows=1 width=32) (actual time=1195.444..1195.445 rows=1 loops=1)
                           ->  Nested Loop  (cost=20000411096.19..20000411096.27 rows=1 width=24) (actual time=909.546..909.548 rows=1 loops=1)
                                 ->  Nested Loop  (cost=10000274059.11..10000274059.16 rows=1 width=16) (actual time=618.747..618.748 rows=1 loops=1)
                                       ->  Finalize Aggregate  (cost=137023.26..137023.27 rows=1 width=8) (actual time=336.303..336.303 rows=1 loops=1)
                                             ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137023.04..137023.26 rows=2 width=8) (actual time=336.287..336.290 rows=2 loops=1)
                                       ->  Finalize Aggregate  (cost=137035.84..137035.85 rows=1 width=8) (actual time=282.442..282.442 rows=1 loops=1)
                                             ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137035.62..137035.84 rows=2 width=8) (actual time=278.803..282.429 rows=2 loops=1)
                                 ->  Finalize Aggregate  (cost=137037.08..137037.09 rows=1 width=8) (actual time=290.796..290.797 rows=1 loops=1)
                                       ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137036.86..137037.08 rows=2 width=8) (actual time=290.780..290.783 rows=2 loops=1)
                           ->  Finalize Aggregate  (cost=137024.82..137024.83 rows=1 width=8) (actual time=285.894..285.894 rows=1 loops=1)
                                 ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137024.60..137024.82 rows=2 width=8) (actual time=283.183..285.879 rows=2 loops=1)
                     ->  Finalize Aggregate  (cost=137025.95..137025.96 rows=1 width=8) (actual time=291.285..291.285 rows=1 loops=1)
                           ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137025.73..137025.95 rows=2 width=8) (actual time=291.267..291.271 rows=2 loops=1)
               ->  Finalize Aggregate  (cost=137026.99..137027.00 rows=1 width=8) (actual time=280.817..280.817 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137026.77..137026.99 rows=2 width=8) (actual time=280.796..280.799 rows=2 loops=1)
         ->  Finalize Aggregate  (cost=137028.12..137028.13 rows=1 width=8) (actual time=278.691..278.691 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137027.89..137028.11 rows=2 width=8) (actual time=276.349..278.676 rows=2 loops=1)
   ->  Finalize Aggregate  (cost=137023.90..137023.91 rows=1 width=8) (actual time=307.480..307.480 rows=1 loops=1)
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=137023.67..137023.89 rows=2 width=8) (actual time=294.167..307.464 rows=2 loops=1)
 Planning time: 4.044 ms
 Execution time: 2363.833 ms
(25 rows)

