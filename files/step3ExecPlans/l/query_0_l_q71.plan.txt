                                                                      QUERY PLAN                                                                      
------------------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=410084.56..410084.64 rows=31 width=95) (actual time=551.635..551.894 rows=3009 loops=1)
   Sort Key: (sum(tmp.ext_price)) DESC, item.i_brand_id
   Sort Method: quicksort  Memory: 520kB
   ->  GroupAggregate  (cost=410082.79..410083.79 rows=31 width=95) (actual time=539.800..550.336 rows=3009 loops=1)
         Group Key: item.i_brand, item.i_brand_id, time_dim.t_hour, time_dim.t_minute
         ->  Remote Subquery Scan on all (dn1,dn2,dn3)  (cost=410082.79..410083.02 rows=31 width=69) (actual time=539.787..547.496 rows=3164 loops=1)
 Planning time: 1.062 ms
 Execution time: 556.959 ms
(8 rows)

