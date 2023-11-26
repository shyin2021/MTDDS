                                                                     QUERY PLAN                                                                      
-----------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=236065.54..236069.54 rows=100 width=163) (actual time=387.001..387.545 rows=100 loops=1)
   ->  Finalize GroupAggregate  (cost=236065.54..237175.38 rows=27746 width=163) (actual time=387.000..387.538 rows=100 loops=1)
         Group Key: foo.channel, foo.col_name, foo.d_year, foo.d_qoy, foo.i_category
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=236065.54..236273.64 rows=27746 width=163) (actual time=386.985..387.328 rows=197 loops=1)
 Planning time: 0.716 ms
 Execution time: 391.677 ms
(6 rows)

