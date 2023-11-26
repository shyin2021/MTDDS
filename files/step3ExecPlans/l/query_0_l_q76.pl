                                                                       QUERY PLAN                                                                        
---------------------------------------------------------------------------------------------------------------------------------------------------------
 Limit  (cost=350016.67..350020.67 rows=100 width=163) (actual time=490.181..492.264 rows=100 loops=1)
   ->  Finalize GroupAggregate  (cost=350016.67..351643.59 rows=40673 width=163) (actual time=490.180..492.249 rows=100 loops=1)
         Group Key: foo.channel, foo.col_name, foo.d_year, foo.d_qoy, foo.i_category
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=350016.67..350321.71 rows=40673 width=163) (actual time=490.148..491.776 rows=291 loops=1)
 Planning time: 0.604 ms
 Execution time: 500.452 ms
(6 rows)

