                                                                                     QUERY PLAN                                                                                      
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=70001631348.10..70001631348.33 rows=1 width=64) (actual time=2336.221..2336.224 rows=1 loops=1)
   ->  Nested Loop  (cost=60001427420.72..60001427420.92 rows=1 width=56) (actual time=2050.981..2050.984 rows=1 loops=1)
         ->  Nested Loop  (cost=50001223502.12..50001223502.29 rows=1 width=48) (actual time=1757.205..1757.208 rows=1 loops=1)
               ->  Nested Loop  (cost=40001019587.38..40001019587.52 rows=1 width=40) (actual time=1469.586..1469.588 rows=1 loops=1)
                     ->  Nested Loop  (cost=30000815664.16..30000815664.27 rows=1 width=32) (actual time=1176.498..1176.500 rows=1 loops=1)
                           ->  Nested Loop  (cost=20000611744.97..20000611745.05 rows=1 width=24) (actual time=860.850..860.851 rows=1 loops=1)
                                 ->  Nested Loop  (cost=10000407829.04..10000407829.09 rows=1 width=16) (actual time=583.606..583.606 rows=1 loops=1)
                                       ->  Finalize Aggregate  (cost=203916.98..203916.99 rows=1 width=8) (actual time=280.749..280.749 rows=1 loops=1)
                                             ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203916.75..203916.97 rows=2 width=8) (actual time=280.730..280.734 rows=3 loops=1)
                                       ->  Finalize Aggregate  (cost=203912.06..203912.07 rows=1 width=8) (actual time=302.853..302.853 rows=1 loops=1)
                                             ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203911.84..203912.06 rows=2 width=8) (actual time=262.466..302.836 rows=3 loops=1)
                                 ->  Finalize Aggregate  (cost=203915.93..203915.94 rows=1 width=8) (actual time=277.239..277.240 rows=1 loops=1)
                                       ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203915.71..203915.93 rows=2 width=8) (actual time=262.514..277.218 rows=3 loops=1)
                           ->  Finalize Aggregate  (cost=203919.20..203919.21 rows=1 width=8) (actual time=315.644..315.644 rows=1 loops=1)
                                 ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203918.97..203919.19 rows=2 width=8) (actual time=276.974..315.626 rows=3 loops=1)
                     ->  Finalize Aggregate  (cost=203923.21..203923.22 rows=1 width=8) (actual time=293.083..293.084 rows=1 loops=1)
                           ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203922.99..203923.21 rows=2 width=8) (actual time=273.430..293.066 rows=3 loops=1)
               ->  Finalize Aggregate  (cost=203914.74..203914.75 rows=1 width=8) (actual time=287.615..287.615 rows=1 loops=1)
                     ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203914.52..203914.74 rows=2 width=8) (actual time=260.656..287.593 rows=3 loops=1)
         ->  Finalize Aggregate  (cost=203918.60..203918.61 rows=1 width=8) (actual time=293.769..293.769 rows=1 loops=1)
               ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203918.38..203918.60 rows=2 width=8) (actual time=266.947..293.746 rows=3 loops=1)
   ->  Finalize Aggregate  (cost=203927.38..203927.39 rows=1 width=8) (actual time=285.233..285.233 rows=1 loops=1)
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=203927.15..203927.37 rows=2 width=8) (actual time=271.626..285.216 rows=3 loops=1)
 Planning time: 1.941 ms
 Execution time: 2356.278 ms
(25 rows)

