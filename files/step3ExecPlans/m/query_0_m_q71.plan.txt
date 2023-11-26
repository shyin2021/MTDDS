                                                                    QUERY PLAN                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=274722.25..274722.30 rows=20 width=95) (actual time=465.536..465.647 rows=2010 loops=1)
   Sort Key: (sum(tmp.ext_price)) DESC, item.i_brand_id
   Sort Method: quicksort  Memory: 331kB
   ->  GroupAggregate  (cost=274721.16..274721.81 rows=20 width=95) (actual time=461.216..464.783 rows=2010 loops=1)
         Group Key: item.i_brand, item.i_brand_id, time_dim.t_hour, time_dim.t_minute
         ->  Remote Subquery Scan on all (dn1,dn2)  (cost=274721.16..274721.31 rows=20 width=69) (actual time=461.208..463.739 rows=2094 loops=1)
 Planning time: 0.661 ms
 Execution time: 468.009 ms
(8 rows)

