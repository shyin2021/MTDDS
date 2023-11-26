                                                                   QUERY PLAN                                                                    
-------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=116808.58..116812.58 rows=100 width=163) (actual time=381.480..381.639 rows=100 loops=1)
   ->  Finalize GroupAggregate  (cost=116808.58..117362.50 rows=13848 width=163) (actual time=381.480..381.633 rows=100 loops=1)
         Group Key: foo.channel, foo.col_name, foo.d_year, foo.d_qoy, foo.i_category
         ->  Remote Subquery Scan on all (dn0)  (cost=116808.58..116912.44 rows=13848 width=163) (actual time=381.461..381.489 rows=101 loops=1)
 Planning time: 0.614 ms
 Execution time: 382.840 ms
(6 rows)

