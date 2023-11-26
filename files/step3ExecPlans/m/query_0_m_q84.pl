                                                               QUERY PLAN                                                               
----------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=63166.61..63167.34 rows=97 width=49) (actual time=721.032..721.097 rows=71 loops=1)
   ->  Remote Subquery Scan on all (dn1,dn2)  (cost=63166.61..63167.34 rows=97 width=49) (actual time=721.031..721.092 rows=71 loops=1)
 Planning time: 1.457 ms
 Execution time: 723.302 ms
(4 rows)

