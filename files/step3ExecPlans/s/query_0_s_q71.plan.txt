                                                                  QUERY PLAN                                                                  
----------------------------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=141705.36..141705.39 rows=10 width=95) (actual time=466.940..466.988 rows=1129 loops=1)
   Sort Key: (sum(tmp.ext_price)) DESC, item.i_brand_id
   Sort Method: quicksort  Memory: 207kB
   ->  GroupAggregate  (cost=141704.87..141705.20 rows=10 width=95) (actual time=465.230..466.610 rows=1129 loops=1)
         Group Key: item.i_brand, item.i_brand_id, time_dim.t_hour, time_dim.t_minute
         ->  Remote Subquery Scan on all (dn0)  (cost=141704.87..141704.95 rows=10 width=69) (actual time=465.211..465.494 rows=1155 loops=1)
 Planning time: 0.496 ms
 Execution time: 467.786 ms
(8 rows)

